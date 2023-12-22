const express = require('express');
const http = require('http');
const { getAllPlayers, createPlayer } = require('./controllers/playerController');
const { createRoom } = require('./controllers/roomController');

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

            //player joined room
            socket.join(room.id);

            //tell client room created and take player to next screen
            io.to(room.id).emit("createRoom:success", room);

        } catch (error) {
            console.log('error: ', error);
        }


    });

    //joinRoom
    socket.on('joinRoom', async ({ nickName, roomId }) => {
        try {

        } catch (error) {
            console.log('error: ', error);
        }
    });
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


server.listen(port, '0.0.0.0', () => {
    console.log(`Server started and running on port: ${port}`);
});