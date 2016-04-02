var static = require('node-static');
var os = require('os');
var socketIO = require('socket.io');
var fs = require('fs');
var https = require('https');
var clients = {};

var options = {
	key: fs.readFileSync('key.pem'),
	cert: fs.readFileSync('cert.pem')
};

var fileServer = new(static.Server)();
var app = https.createServer(options, function (req, res) {
	fileServer.serve(req, res);
}).listen(30000, '0.0.0.0');

var io = socketIO.listen(app);
io.sockets.on('connection', function (socket) {
	
	//////////// Lobby start
	socket.on('new client', function(data){
		console.log(data.room);
		socket.nickname = data.nick;
		socket.roomname = data.room;
		socket.time = data.time;
		clients[socket.id] = socket;
		updateWaiting();
		io.sockets.emit('newClientJoin', socket.roomname);
	});
	
	socket.on('send message', function(data){
		var msg = data.trim();
		io.sockets.in(socket.roomname).emit('new message', {msg: msg, nick: socket.nickname});
	});
	
	socket.on('get clientList', function(data){
        var data = {};
		getWaitingClients();
	});
	
	socket.on('pull client', function(data){
		var client = clients[data.id];
		delete clients[data.id];
		client.emit('go Chat',{roomname: data.id});
		updateWaiting();
	});
	
	socket.on('create chat', function(data){
		socket.nickname = data.nick;
		socket.roomname = data.room;
		socket.join(data.room);
	});
	
	function getWaitingClients(){
		var data = {};
		for(var key in clients){
			var c = {};
			c.roomname = clients[key].roomname;
			c.time = clients[key].time;
			data[key] = c;
		}
		io.sockets.emit('rooms', Object(data));
	}
	
	function updateWaiting(){
		io.sockets.emit('waitUsers', Object.keys(clients).length);
		getWaitingClients();
	}
	
	function deleteClient(data){
		for(var key in clients){
			if(clients[key].id===socket.id){
				console.log(clients[key].id);
			} 
		}
	}
	///////////  Lobby End

	socket.on('disconnect',function(data) {
		socket.leave(socket.roomname);
		delete clients[socket.id];
		deleteClient(data);
		updateWaiting();
	});
	
	
	var roomName;
	//console.log('[' + socket.id + '] is connected');
	//socket.emit('roomList', io.sockets.adapter.rooms);

	function log() {
		var array = [">>> Message from server : "];
		array.push.apply(array, arguments);
		socket.emit('log', array);
	}

	socket.on('signal', function (signal) {
		console.log(signal);
		log('Client send signal : ', signal);

		// for a real app, would be room only (not broadcast)
		io.sockets.in(socket.roomname).emit('signal', signal);
	});

	socket.on('create or join', function (room) {
		//log('Request to create or join room : ' + room);
		
		socket.roomname = room;

		var targetRoom = io.sockets.adapter.rooms[room];
		var numClients = 0;

		if(targetRoom != null)
			numClients = targetRoom.length;

		log('Room ' + room + ' has ' + numClients + ' client(s)');
		//log('Request to create or join room : ', room);

		if (numClients === 0) {	// 방이 없을 때
			socket.join(room);	// 해당 소켓을 방에 join
			roomName = room;
			console.log("[" + roomName + "] room is created")
			socket.emit('created', room);	// 'created' 이벤트 전송

		} else if (numClients === 1) {
			socket.join(room);
			roomName = room;
			socket.emit('joined', room);
			io.sockets.in(room).emit('ready');

		} else { // max two clients
			socket.emit('full', room);
		}
		socket.emit('emit(): client [' + socket.id + '] joined room : ' + room);
		socket.broadcast.emit('broadcast(): client [' + socket.id + '] joined room : ' + room);
	});

	socket.on('ipaddr', function() {
		var ifaces = os.networkInterfaces();
		for(var dev in ifaces) {
			ifaces[dev].forEach(function (details) {
				if(details.family == 'IPv4' && details.address != '127.0.0.1') {
					socket.emit('ipaddr', details.address);
				}
			})
		}
	});

	socket.on('leaveRoom', function(clientId) {
		socket.leave(roomName);
	});
});