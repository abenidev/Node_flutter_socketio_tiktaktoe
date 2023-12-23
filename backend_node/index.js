const express = require('express');
const http = require('http');
const { getAllPlayers, createPlayer, getPlayersByRoomId, getPlayersById } = require('./controllers/playerController');
const { createRoom, getRoomById, updateRoomIsJoinVal, updateRoomTurn, updateRoomTurnIndex } = require('./controllers/roomController');

const app = express();
const port = process.env.PORT || 3000;

let server = http.createServer(app);

let io = require('socket.io')(server);

//middle ware
app.use(express.json());

//
io.on('connection', (socket) => {
    console.log('connected!');
    socket.on('createRoom', async ({ nickName }) => {
        console.log(nickName);
        try {
            //room created
            const roomResp = await createRoom();
            const room = roomResp.dataValues;
            console.log('roomId: ', room.id);

            //player is stored in room
            let playerInfo = {
                socketId: socket.id,
                nickName,
                playerType: 'X',
                roomId: room.id,
            };
            const playerResp = await createPlayer(playerInfo);
            const player = playerResp.dataValues;
            console.log('playerId: ', player.id);

            const updateRoomTurnResp = await updateRoomTurn(room.id, player.id);
            const updatedRoom = await getRoomById(room.id);

            //player joined room
            socket.join(room.id);

            //tell client room created and take player to next screen
            io.to(room.id).emit("createRoom:success", updatedRoom);

        } catch (error) {
            console.log('error: ', error);
        }


    });

    //joinRoom
    socket.on('joinRoom', async ({ nickName, roomId }) => {
        try {
            const room = await getRoomById(roomId);
            if (room == null) {
                socket.emit('joinRoom:Error:InvalidRoomId', 'Please enter a valid room!');
                return;
            }
            if (!room.isJoin) {
                //TODO: update when implementing spectate mode
                socket.emit('joinRoom:Error:RoomFull', 'Game is in progress, please join a different room!');
                return;
            }

            let playerInfo = {
                socketId: socket.id,
                nickName,
                playerType: 'O',
                roomId: roomId,
            };

            const playerResp = await createPlayer(playerInfo);
            const player = playerResp.dataValues;
            console.log('playerId: ', player.id);
            console.log('roomId: ', room.id);
            socket.join(roomId);
            //update room.isJoin value to false
            const updatedRoom = await updateRoomIsJoinVal(room.id, false);
            const updatedRoomData = await getRoomById(roomId);
            console.log('updatedRoomData: ', updatedRoomData);
            //
            io.to(room.id).emit("joinRoom:success", updatedRoomData);
            const players = await getPlayersByRoomId(room.id);
            io.to(room.id).emit("updatePlayers", players);
            io.to(room.id).emit("updateRoom", updatedRoomData);


        } catch (error) {
            console.log('error: ', error);
        }
    });

    //
    socket.on('tap', async ({ index, roomId }) => {
        try {
            let room = await getRoomById(roomId);
            let tappingPlayer = await getPlayersById(room.turn);
            let choice = tappingPlayer.playerType;
            let players = await getPlayersByRoomId(room.id);
            let nextTurnPlayer;
            for (let player of players) {
                if (choice === 'X') {
                    if (player.playerType === 'O') {
                        nextTurnPlayer = player;
                        break;
                    }
                }
                if (choice === 'O') {
                    if (player.playerType === 'X') {
                        nextTurnPlayer = player;
                        break;
                    }
                }
            }
            if (!nextTurnPlayer) {
                throw "Next turn player not found!!";
            }
            if (room.turnIndex === 0) {
                await updateRoomTurn(room.id, nextTurnPlayer.id);
                await updateRoomTurnIndex(room.id, 1);
            } else {
                await updateRoomTurn(room.id, nextTurnPlayer.id);
                await updateRoomTurnIndex(room.id, 0);
            }
            let updatedRoom = await getRoomById(roomId);

            io.to(room.id).emit("tapped", {
                index,
                choice,
                updatedRoom,
            });
        } catch (error) {
            console.log('error: ', error);
        }
    })
});

app.get('/', getAllPlayers);
app.get('/room', async (req, res) => {
    //room created
    const roomResp = await createRoom();
    const roomId = roomResp.dataValues.id;
    console.log('roomId: ', roomId);

    let player = {
        socketId: 'socketid',
        nickName: "nickname",
        playerType: 'X',
        roomId
    };

    const playerResp = await createPlayer(player);
    const playerId = playerResp.dataValues.id;
    console.log('playerId: ', playerId);
    res.status(200).send({ roomId, playerId });
});

app.get('/room/:id', async (req, res) => {
    const id = req.params.id;
    const room = await getRoomById(id);
    res.status(200).send({ room });
})

app.get('/room/update/:id', async (req, res) => {
    const id = req.params.id;
    const updatedRoom = await updateRoomIsJoinVal(id, false);
    res.status(200).send(updatedRoom);
})

app.get('/players/:roomId', async (req, res) => {
    const roomId = req.params.roomId;
    const players = await getPlayersByRoomId(roomId);
    res.status(200).send({ players });
})


server.listen(port, '0.0.0.0', () => {
    console.log(`Server started and running on port: ${port}`);
});