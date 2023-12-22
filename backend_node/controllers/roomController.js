const db = require('../model');
const path = require('path');

// create main Model
const Room = db.rooms;

//create room
const createRoom = async () => {
    let roomInfo = {};
    const room = await Room.create(roomInfo);
    return room;
}

module.exports = {
    createRoom
}