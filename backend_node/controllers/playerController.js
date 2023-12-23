const db = require('../model');

// create main Model
const Player = db.players;

//create player
const createPlayer = async (playerInfo) => {
    const player = await Player.create(playerInfo);
    return player;
}



//get players by roomId
const getPlayersByRoomId = async (roomId) => {
    let players = await Player.findAll({ where: { roomId } });
    return players;
}


//!
// get all players
const getAllPlayers = async (req, res) => {
    let Players = await Player.findAll({})
    res.status(200).send(Players);
}

module.exports = {
    getAllPlayers,
    createPlayer,
    getPlayersByRoomId,
}