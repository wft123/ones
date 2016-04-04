/****************************************************************************
 * Initial setup
 ****************************************************************************/

var pc_configuration = {'iceServers': [{'url': 'stun:stun.l.google.com:19302'}]};
var pc_constraints = {
	'optional': [
		{'DtlsSrtpKeyAgreement': true},
		{'RtpDataChannels': false}
	]
};
var sdpConstraints = {
		'mandatory': {
			'OfferToReceiveAudio': true,
			'OfferToReceiveVideo': true
		}
};

// defult value
var port = 30000;
var ip = document.getElementById("ip").value;
var room = document.getElementById("key").value;
var clientId =document.getElementById("name").value;
var chatDate = getTimeStamp('date');
var socket;
var now = (window.performance.now() / 1000).toFixed(3);

//Peer Connection
var isInitiator;
var isStarted;
var isChannelReady;
start();


// Local video Element
var localVideo			= document.getElementById("localVideo");


// Remote video Element
var remoteVideo			= document.getElementById("remoteVideo");
var remoteMuteButton	= document.getElementById("remoteMuteBtn");
var remoteUnmuteButton	= document.getElementById("remoteUnmuteBtn");


// Chat
var sendChatArea		= document.getElementById("sendChatArea");
var receivedChatArea	= document.getElementById("receivedChatArea");
var sendChatButton		= document.getElementById("sendChatBtn");

sendChatButton.onclick = sendChatMessage;
// File
var sendFileInfo	= document.getElementById("sendFileInfo");
var sendFileInput	= document.getElementById("sendFileInput");
var sendFileButton	= document.getElementById("sendFileBtn");
var sendProgress	= document.getElementById("sendProgress");

sendFileInput.onchange = sendFileCheck;
sendFileButton.onclick = sendFile;

var receivedFile		= document.getElementById("receivedFileURL");

function clickTest(event) {
	console.log("'" + event.target.id + "' is clicked.");
}

function changeTest(event) {
	console.log("'" + event.target.id + "' is changed.");
}

/*******************************************************************************
 * Custom Utils
 ******************************************************************************/

function getTimeStamp(type) {
	var d = new Date();
	var s = '';
	if(type==='all'){
		s =
			leadingZeros(d.getFullYear(), 4) + '-' +
			leadingZeros(d.getMonth() + 1, 2) + '-' +
			leadingZeros(d.getDate(), 2) + ' ' +
			leadingZeros(d.getHours(), 2) + ':' +
			leadingZeros(d.getMinutes(), 2) + ':' +
			leadingZeros(d.getSeconds(), 2);
	}else if(type==='date'){
		s =
			leadingZeros(d.getFullYear(), 4) + '년 ' +
			leadingZeros(d.getMonth() + 1, 2) + '월 ' +
			leadingZeros(d.getDate(), 2)+'일';
	}else{
		s = 
			leadingZeros(d.getHours(), 2) + ':' +
			leadingZeros(d.getMinutes(), 2) + ':' +
			leadingZeros(d.getSeconds(), 2);
	}
	return s;
}

function leadingZeros(n, digits) {
	var zero = '';
	n = n.toString();

	if (n.length < digits) {
		for (i = 0; i < digits - n.length; i++)
			zero += '0';
	}
	return zero + n;
}

function appendMessage( who, data ){
	if(data.message.length==0) return false;
	var wrapDiv = document.createElement("div");
	var li = document.createElement("li");
	var timeDiv = document.createElement("div");
	wrapDiv.appendChild(li);
	wrapDiv.appendChild(timeDiv);
	receivedChatArea.appendChild(wrapDiv);
	wrapDiv.setAttribute("class",who+"wrap");
	li.setAttribute("class", who);
	timeDiv.setAttribute("class","time");
	timeDiv.innerHTML = getTimeStamp('time');
	var msg = data.message;
	
	try {
		var rs = ClevisURL.collect(data.message);
		if (rs.length > 0) {
			for (var n = 0; n < rs.length; n++) {
				rs[n] = rs[n].replace(/&/g, '&amp;');
				msg=msg.replace(rs[n],'<a href="http://'+rs[n]+'" target="_blank">'+rs[n]+'</a>')
				console.log(msg);
			}
		}
	} catch(e) {
		console.log("parse error:"+'['+ e.number +'] '+ e.description);
	} 	
	
	if(who==='yours'){
		li.innerHTML = "<span>"+data.name+"</span>" + msg; // data.message;
	}else{
		li.innerHTML = msg;//data.message;
	}
	receivedChatArea.scrollTop=receivedChatArea.scrollHeight;
}

var chatLog = [];
var saveButton = document.getElementById("saveBtn");
saveButton.onclick = saveChat;

function saveChat() {
	if(!confirm("대화 내용을 저장하시겠습니까?")) return;
	var element = document.createElement('a');
	var chatLog = '';
	var chatLogTemp = receivedChatArea.childNodes;

	for (var idx = 0; idx < chatLogTemp.length; idx++) {
		var content = chatLogTemp[idx].firstChild.innerHTML;
		var time = chatLogTemp[idx].lastChild.innerHTML;
		var name = '';
		if(chatLogTemp[idx].className==='minewrap'){
			name = clientId;
		}else if(chatLogTemp[idx].className==='yourswrap'){
			var temp = content.split("</span>");
			name = temp[0].substring(6);
			content = temp[1];
		}
		console.log(content);
		if(content.indexOf('data:')!=-1) content = "[ Data File ]";
		chatLog += time+', '+name+':'+ content + '\n';
	}

	var fileName = '';
	fileName += getTimeStamp('all');

	element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(chatLog));
	element.setAttribute('download', fileName);
	element.style.display = 'none';
	document.body.appendChild(element);

	element.click();

	document.body.removeChild(element);
}

function saveVideo(){
	console.log("call saveVideo");
	stopRecording('local');
	stopRecording('remote');
	if(confirm("영상을 저장하시겠습니까?")){
		downRecordedStream('local');
		downRecordedStream('remote');
	}
}

/*******************************************************************************
 * Signal Server Connection
 ******************************************************************************/

function start() {
	socket = io.connect('https://'+ip+':'+port);

	socket.on('log', function (array) {
		console.log.apply(console, array);
	});

	socket.on('signal', function (signal) {
		console.log('Client received signal message:', signal);
		handleSignalReceiveMessage(signal);
	});

	socket.on('ipaddr', function (ipaddr) {
		console.log('Server IP address is: ' + ipaddr);
		updateRoomURL(ipaddr);
	});

	socket.on('created', function (room) {
		console.log('Created room [', room, '] - my client ID is [', clientId, ']');
		isInitiator = true;
		isChannelReady = true;
	});

	socket.on('joined', function (room) {
		console.log('This peer has joined room [', room, '] with client ID [', clientId, ']');
		isInitiator = false;
		isChannelReady = true;
	});

	socket.on('full', function (room) {
		alert('Room "' + room + '" is full. We will create a new room for you.');
		window.location.hash = '';
		window.location.reload();
	});

	socket.on('ready', function () {
		console.log(now + " ready for peerConnection");
		maybeStart();
	});

	socket.on('roomList', function(list) {
		console.log('[Current Room List]');
		console.log(list);
	})
	
	/**
	 * start()'s Biz Area
	 */
//	trace("start() called");

	if (room === '') {
		room = 'q';
	}

	// Create or Join a room
	socket.emit('create or join', room);

	if (location.hostname.match(/localhost|127\.0\.0/)) {
		socket.emit('ipaddr');
	}

	console.log(socket);
}

function hangUp() {
	console.log(now + " hangUp() called");
	if(isMediaCallStarted)
		hangupMediaCall();

	if(dataChannel.readyState != 'close') {
		dataChannel.close();
	}

	if(dataChannel != null) {
		dataChannel = null;
	}

	peerConnection.close();
	peerConnection = null;
	socket.emit('leaveRoom', clientId);
	appendMessage('system', {message: "상대방이 퇴장했습니다."});
	closeVideo();
}

function sendSignal(signal) {
	console.log('Client sending signal : ', signal);
	socket.emit('signal', signal);
}

function updateRoomURL(ipaddr) {
	var url;
	if (!ipaddr) {
		url = location.href
	} else {
		url = location.protocol + '//' + ipaddr + ':'+port+'/#' + room
	}
	roomURL.innerHTML = url;
}

/****************************************************************************
 * PeerConnection & Data Channel
 ****************************************************************************/

var peerConnection;
var dataChannel;

function handleSignalReceiveMessage(signal) {
	// TODO habdle received message from signal server
	if(signal.type === 'offer') {
		peerConnection.setRemoteDescription(new RTCSessionDescription(signal), function() {}, logError);
		doAnswer();

	} else if(signal.type === 'answer') {
		peerConnection.setRemoteDescription(new RTCSessionDescription(signal), function() {}, logError);

	} else if(signal.type === 'candidate') {
		peerConnection.addIceCandidate(new RTCIceCandidate({candidate: signal.candidate}));

	} else if(signal.type === 'mediaanswer') {
		peerConnection.setRemoteDescription(new RTCSessionDescription(signal.answerSDP), function() {}, logError);

	} else if(signal === 'bye') {
		hangUp();
	}
}

function handleDataChennelReceiveMessage(event) {
	// TODO handle received message from dataChannel
	var packet = JSON.parse(event.data)

	if(packet.category === 'chat') {
		appendMessage('yours', packet);
	} else if(packet.category === 'file') {
		receiveFile(packet);
	} else if(packet.category === 'mediaCall') {
		handleMediaCallReceiveMessage(packet);
	} else {
		console.log("Unknwoned Category.")
	}
}

function maybeStart() {
	if (!isStarted && isChannelReady) {
		createPeerConnection();
		isStarted = true;
	}

	if(isInitiator) {
		doCall();
	}
}

function createPeerConnection() {
	peerConnection = new RTCPeerConnection(pc_configuration, pc_constraints);
	peerConnection.onicecandidate	= handleIceCandidate;
	peerConnection.onaddstream		= handleRemoteStreamAdded;
	peerConnection.onremovestream	= handleRemoteStreamRemoved;

	if(isInitiator) {
		dataChannel = peerConnection.createDataChannel("dataChannel", {reliable: false});
		dataChannel.onmessage	= handleDataChennelReceiveMessage;
		dataChannel.onopen		= handleDataChannelStateChange;
		dataChannel.onclose		= handleDataChannelStateChange;

	} else {
		peerConnection.ondatachannel = gotReceiveChannel;
	}
}

function doCall() {
	var constraints = {'optional': [], 'mandatory': {
		'OfferToReceiveAudio': false,
		'OfferToReceiveVideo': false
	}};
	// temporary measure to remove Moz* constraints in Chrome
	if (webrtcDetectedBrowser === 'chrome') {
		for (var prop in constraints.mandatory) {
			if (prop.indexOf('Moz') !== -1) {
				delete constraints.mandatory[prop];
			}
		}
	}
	constraints = mergeConstraints(constraints, sdpConstraints);
	console.log(now + " create offer");
	peerConnection.createOffer(setLocalAndSendMessage, null, constraints);
}

function doAnswer() {
	console.log(now + ' Sending answer to peer.');
	peerConnection.createAnswer(setLocalAndSendMessage, null, sdpConstraints);
}

function gotReceiveChannel(event) {
	// console.log(now + ' Receive Channel Callback');
	dataChannel = event.channel;
	dataChannel.onmessage	= handleDataChennelReceiveMessage;
	dataChannel.onopen		= handleDataChannelStateChange;
	dataChannel.onclose		= handleDataChannelStateChange;
}

function handleIceCandidate(event) {
	//console.log(now + ' handleIceCandidate event: ');
	//console.log(event);

	if (event.candidate) {
		sendSignal({
			type: 'candidate',
			label: event.candidate.sdpMLineIndex,
			id: event.candidate.sdpMid,
			candidate: event.candidate.candidate
		});
	} else {
		console.log(now + ' End of candidates.');
	}
}

function handleDataChannelStateChange() {
	var readyState;

	if(dataChannel != null) {
		readyState = dataChannel.readyState;
	}

	peerConnection.onaddstream		= handleRemoteStreamAdded;
	peerConnection.onremovestream	= handleRemoteStreamRemoved;
	dataChannel.onmessage	= handleDataChennelReceiveMessage;
	dataChannel.onopen		= handleDataChannelStateChange;
	dataChannel.onclose		= handleDataChannelStateChange;
	console.log(now + ' DataChannel state is : ' + readyState);
	if(readyState == 'open'){
		appendMessage('system',{message:chatDate+' 상담을 시작합니다. \n 해당 상담내용은 익명을 보장하며 서비스 품질을 위해 저장됩니다.'});
	}
	if(readyState == 'closed') {
		hangUp();
	}
}

function setLocalAndSendMessage(sessionDescription) {
	sessionDescription.sdp = preferOpus(sessionDescription.sdp);
	peerConnection.setLocalDescription(sessionDescription);
	//trace('Offer from PeerConnection \n' + sessionDescription.sdp);
	sendSignal(sessionDescription);
}

/****************************************************************************
 * Media Call
 ****************************************************************************/

var isMediaCallStarted = false;
var isLocalLoaded = false;
var isRemoteLoaded = false;
var mediaType

function sendMediaCallMessage(media, msg) {
	var message = {};
	message.category = 'mediaCall';
	message.mediaType = media;
	message.message = msg;

	dataChannel.send(JSON.stringify(message));
}

function handleMediaCallReceiveMessage(packet) {
	mediaType = packet.mediaType;
	var message = packet.message;
	console.log(now + " mediaType : " + mediaType + " message : " + message);

	// TODO handle received message about media call
	if(message === 'start') {
		if(isMediaCallStarted == true)
			return;
		if(confirm("상담원이 영상통화를 요청했습니다 \n 수락하시겠습니까?")) {
			sendMediaCallMessage(mediaType, 'accept');

			if(mediaType === 'video') {
				var constraints = {video: true, audio: true};
				getUserMedia(constraints, handleUserMedia, handleUserMediaError);

			} else if(mediaType === 'audio') {
				var constraints = {video: false, audio: true};
				getUserMedia(constraints, handleUserMedia, handleUserMediaError);

			}
			openVideo();
		} else {
			sendMediaCallMessage(mediaType, 'reject');
			closeVideo();
		}

	} else if(message === 'accept') {
		if(!isMediaCallStarted) {
			if(mediaType === 'video') {
				var constraints = {video: true, audio: true};
				getUserMedia(constraints, handleUserMedia, handleUserMediaError);

			} else if(mediaType === 'audio') {
				var constraints = {video: false, audio: true};
				getUserMedia(constraints, handleUserMedia, handleUserMediaError);

			}
			openVideo();
		}
	} else if(message === 'gum done') {
		isRemoteLoaded = true;

		console.log('isLocalLoaded : ' + isLocalLoaded);
		console.log('isRemoteLoaded : ' + isRemoteLoaded);

		if(isLocalLoaded && isRemoteLoaded) {
			sendMediaCallMessage(mediaType, 'ready');
			maybeStartMediaCall();
		}

	} else if(message === 'ready') {
		console.log('ready');
		if(isLocalLoaded && isRemoteLoaded) {
			maybeStartMediaCall();
		}

	} else if(message === 'reject') {
		console.log("Call req is rejected");
		closeVideo();

	} else  if(message === 'hangup') {
		if(isMediaCallStarted == false) return;

		closeVideo();
		console.log("mediaType : '" + mediaType + "' Media Call is hung up");
		cleanMediaCallLocalResource();
		isMediaCallStarted = false;
	}
}

function handleUserMedia(stream) {
	console.log(now + ' handleUserMedia');
	localVideo.src = window.URL.createObjectURL(stream);
	localStream = stream;
	attachMediaStream(localVideo, stream);
	isLocalLoaded = true;
	sendMediaCallMessage(mediaType, 'gum done');
}

function maybeStartMediaCall() {
	if(!isMediaCallStarted) {
		peerConnection.addStream(localStream);
		isMediaCallStarted = true;

		if(isInitiator) {
			doMediaCallStart();
		}
	}
}

function doMediaCallStart() {
	var constraints = {'optional': [], 'mandatory': {
		'OfferToReceiveAudio': false,
		'OfferToReceiveVideo': false
	}};

	// temporary measure to remove Moz* constraints in Chrome
	if (webrtcDetectedBrowser === 'chrome') {
		for (var prop in constraints.mandatory) {
			if (prop.indexOf('Moz') !== -1) {
				delete constraints.mandatory[prop];
			}
		}
	}
	constraints = mergeConstraints(constraints, sdpConstraints);
	peerConnection.onaddstream = handleRemoteStreamAdded;
	peerConnection.createOffer(setLocalAndSendMessage, null, constraints);
}

function handleRemoteStreamAdded(event) {
	remoteStream = event.stream;
	attachMediaStream(remoteVideo, remoteStream);
	
	//TODO remoteVideo's controller enable
	remoteVideo.controls = true;

	if(!isInitiator) {
		console.log('Sending answer to offerer.');
		peerConnection.createAnswer(setLocalAndSendMessage, null, sdpConstraints);
	}else{
		startRecording('local');
		startRecording('remote');
	}
}

function handleRemoteStreamRemoved(event) {
	console.log(now + ' Remote stream removed. Event: ', event);
}

function handleUserMediaError(error) {
	console.log(now + ' getUserMedia error: ', error);
}

function confirmHangup(mediaType) {
	if(confirm('hangup this media call?'))
		hangupMediaCall(mediaType);
}

function hangupMediaCall(mediaType) {
	// TODO hangup media call
	if(isMediaCallStarted == false)
		return;

	sendMediaCallMessage(mediaType, 'hangup');
	cleanMediaCallLocalResource();
	isMediaCallStarted = false;
}

function cleanMediaCallLocalResource() {
	console.log('clean');
	if(localStream) {
		localStream.getTracks().forEach(function(track) {
			track.stop();
		});
	}

	if(remoteStream) {
		remoteStream.getTracks().forEach(function(track) {
			track.stop();
		});
	}

	peerConnection.removeStream(localStream);
	localStream = null;
	localVideo.src = '';
	remoteStream = null;
	remoteVideo.src = '';
}

function mergeConstraints(cons1, cons2) {
	var merged = cons1;
	for (var name in cons2.mandatory) {
		merged.mandatory[name] = cons2.mandatory[name];
	}
	merged.optional.concat(cons2.optional);
	return merged;
}

function preferOpus(sdp) {
	var sdpLines = sdp.split('\r\n');
	var mLineIndex;
	// Search for m line.
	for (var i = 0; i < sdpLines.length; i++) {
		if (sdpLines[i].search('m=audio') !== -1) {
			mLineIndex = i;
			break;
		}
	}
	if (mLineIndex === null) {
		return sdp;
	}

	// If Opus is available, set it as the default in m line.
	for (i = 0; i < sdpLines.length; i++) {
		if (sdpLines[i].search('opus/48000') !== -1) {
			var opusPayload = extractSdp(sdpLines[i], /:(\d+) opus\/48000/i);
			if (opusPayload) {
				sdpLines[mLineIndex] = setDefaultCodec(sdpLines[mLineIndex], opusPayload);
			}
			break;
		}
	}
	// Remove CN in m line and sdp.
	sdpLines = removeCN(sdpLines, mLineIndex);

	sdp = sdpLines.join('\r\n');
	return sdp;
}

function extractSdp(sdpLine, pattern) {
	var result = sdpLine.match(pattern);
	return result && result.length === 2 ? result[1] : null;
}

// Set the selected codec to the first in m line.
function setDefaultCodec(mLine, payload) {
	var elements = mLine.split(' ');
	var newLine = [];
	var index = 0;
	for (var i = 0; i < elements.length; i++) {
		if (index === 3) { // Format of media starts from the fourth.
			newLine[index++] = payload; // Put target payload to the first.
		}
		if (elements[i] !== payload) {
			newLine[index++] = elements[i];
		}
	}
	return newLine.join(' ');
}

// Strip CN from sdp before CN constraints is ready.
function removeCN(sdpLines, mLineIndex) {
	var mLineElements = sdpLines[mLineIndex].split(' ');
	// Scan from end for the convenience of removing an item.
	for (var i = sdpLines.length - 1; i >= 0; i--) {
		var payload = extractSdp(sdpLines[i], /a=rtpmap:(\d+) CN\/\d+/i);
		if (payload) {
			var cnPos = mLineElements.indexOf(payload);
			if (cnPos !== -1) {
				// Remove CN payload from m line.
				mLineElements.splice(cnPos, 1);
			}
			// Remove CN line in sdp
			sdpLines.splice(i, 1);
		}
	}
	sdpLines[mLineIndex] = mLineElements.join(' ');
	return sdpLines;
}

/****************************************************************************
* Record Media Call
****************************************************************************/
var localMediaRecorder;
var remoteMediaRecorder;
var localRecordedBlobs = [];
var remoteRecordedBlobs = [];
var recOptions = {mimeType: 'video/webm'};

function handleLocalDataAvailable(event) {
	if(event.data && event.data.size > 0) {
		localRecordedBlobs.push(event.data);
	}
}

function handleRemoteDataAvailable(event) {
	if(event.data && event.data.size > 0) {
		remoteRecordedBlobs.push(event.data);
	}
}

function startRecording(targetStream) {
	if(targetStream === 'local') {
		localMediaRecorder = getMediaRecorder(localStream);
		if(localMediaRecorder == null)
			return;

		streamRecord('local');

	} else if(targetStream === 'remote') {
		remoteMediaRecorder = getMediaRecorder(remoteStream);

		if(localMediaRecorder == null)
			return;

		streamRecord('remote');

	}
	console.log(localMediaRecorder);
	console.log("startRecording");
}

function getMediaRecorder(targetStream) {
	var mediaRecoder;

	try {
		mediaRecoder = new MediaRecorder(targetStream, recOptions);
	} catch(e0) {
		console.log('Unable to create MediaRecoder with recOptions Object: ', e0);
		try {
			recOptions = {mimeType: 'video/webm, codecs=vp9'};
			mediaRecoder = new MediaRecorder(targetStream, recOptions);
		} catch(e1) {
			console.log('Unable to create MediaRecoder with recOptions Object: ', e1);
			try {
				recOptions = 'video/vp8';
				mediaRecoder = new MediaRecorder(targetStream, recOptions);
			} catch(e2) {
				alert('MediaRecorder is not supported by this browser.\n\n' +
					'Try Firefox 29 or later, or Chrome 47 or later, with Enable experimental Web Platform features enabled from chrome://flags.');
				console.error('Exception while creating MediaRecorder: ', e2);
				return;
			}
		}
	}
	return mediaRecoder;
}

function streamRecord(targetStream) {
	console.error('strem record call')
	if(targetStream === 'local') {
		// console.log('Create MediaRecorder ', localMediaRecorder, ' with recOptions ', recOptions);
		localMediaRecorder.onstop = handleRecordStop;
		localMediaRecorder.ondataavailable = handleLocalDataAvailable;
		localMediaRecorder.start(10);

	} else if(targetStream === 'remote') {
		// console.log('Create MediaRecorder ', remoteMediaRecorder, ' with recOptions ', recOptions);
		remoteMediaRecorder.onstop = handleRecordStop;
		remoteMediaRecorder.ondataavailable = handleRemoteDataAvailable;
		remoteMediaRecorder.start(10);
	}
}

function handleRecordStop(event) {
	console.log('Recorder stopped: ', event);
}

function stopRecording(targetStream) {
	if(targetStream === 'local') {
		localMediaRecorder.stop();
		console.log('Recorded Local Blobs: ', localRecordedBlobs);
	} else if(targetStream === 'remote') {
		remoteMediaRecorder.stop();
		console.log('Recorded remote Blobs: ', remoteRecordedBlobs);
	}
}

function playRecordedStream(targetStream) {
	if(targetStream === 'local') {
		var buf = new Blob(localRecordedBlobs, {type: 'video/webm'});

	} else if(targetStream === 'remote') {
		var buf = new Blob(remoteRecordedBlobs, {type: 'video/webm'});
	}
}

function downRecordedStream(targetStream) {
	if(targetStream === 'local') {
		var blob = new Blob(localRecordedBlobs, {type: 'video/webm'});
		var url = window.URL.createObjectURL(blob);
		var a = document.createElement('a');
		a.style.display = 'none';
		a.href = url;
		a.download = 'localRecorded.webm';
		document.body.appendChild(a);
		a.click();

		setTimeout(function() {
			document.body.removeChild(a);
			window.URL.revokeObjectURL(url);
		}, 100);
	} else if(targetStream === 'remote') {
		var blob = new Blob(remoteRecordedBlobs, {type: 'video/webm'});
		var url = window.URL.createObjectURL(blob);
		var a = document.createElement('a');
		a.style.display = 'none';
		a.href = url;
		a.download = 'remoteRecorded.webm';
		document.body.appendChild(a);
		a.click();

		setTimeout(function() {
			document.body.removeChild(a);
			window.URL.revokeObjectURL(url);
		}, 100);
	}
}


/****************************************************************************
 * Chat
 ****************************************************************************/

function sendChatMessage() {
	var message = {};
	message.category = 'chat';
	message.message = sendChatArea.value;
	message.name = clientId;
	sendChatArea.value='';
	
	if(message == null || message === '')
		return;

	// mine message
	appendMessage('mine', message);
	
	dataChannel.send(JSON.stringify(message));
}

/****************************************************************************
 * File Sharing
 ****************************************************************************/

var file;
var receivedFileURL;
var receivedFileName;
var totalSize;
var receivedBuffer = [];

function receiveFile(packet) {
	//console.log(packet);
	receivedFileName = packet.fileName;
	totalSize = packet.totalSize;

	receivedBuffer.push(packet.message);

	if(packet.last) {
		receivedFileURL = receivedBuffer.join('');
		receivedBuffer = [];
		createAnchor('yours', receivedFileURL, receivedFileName, totalSize);
	}
}

function createAnchor(who, URL, fileName, fileSize) {
	var anc = "<a ";
	anc += ' href="'+URL+'"';
	anc += ' style="display:block;"';
	anc += ' download='+fileName+'>';
	if(URL.indexOf('image')!=-1){
		anc += '<img src="'+URL+'" style="display:block; width:100px;"';
	}else{
		anc += fileName + "</br> (" + fileSize + " bytes)";
	}
	anc += "</a>";
	
	appendMessage(who, {name:'FILE', message:anc});
}

function sendFileCheck() {
	file = sendFileInput.files[0];
	//sendFileInput.disabled = true;
	//trace('file is ' + [file.name, file.size, file.type, file.lastModifiedDate].join(' '));

	// Handle 0 size files.
	if (file.size === 0) {
		sendFileInput.disabled = false;
		//closeDataChannels();
		return;
	} else {
		sendFileButton.disabled = false;
	}
};

function sendFile() {
	console.log(file);
	var CHUNK_SIZE = 64000;
	

	var reader = new window.FileReader();
	reader.readAsDataURL(file);
	reader.onload = onReadAsDataURL;

	// temp progress create
	
	var temp = document.createElement("li");
	temp.setAttribute("id", "fileLi");
	temp.setAttribute("class", "mine");
	receivedChatArea.appendChild(temp);
	temp.innerHTML='<progress id="customProgress" max="0" value="0"></progress></li>';
	
	// scroll bottom fix
	receivedChatArea.scrollTop=receivedChatArea.scrollHeight;
	
	var customProgress	= document.getElementById("customProgress");
	customProgress.max = file.size;
	
	function onReadAsDataURL(event, text) {
		var data = {};
		data.category = 'file';
		data.fileName = file.name;
		data.totalSize = file.size;

		if(event)
			text = event.target.result;

		if(text.length > CHUNK_SIZE) {
			data.message = text.slice(0, CHUNK_SIZE);

		} else {
			data.message = text;
			data.last = true;
		}

		dataChannel.send(JSON.stringify(data));

		var remainingDataURL = text.slice(data.message.length);
		if(remainingDataURL.length) setTimeout(function() {
			onReadAsDataURL(null, remainingDataURL);
		}, 500)
		customProgress.value = file.size - remainingDataURL.length;
		
		// complete sending file
		if(remainingDataURL.length==0){
			var fileLi	= document.getElementById("fileLi");
			receivedChatArea.removeChild(fileLi);
			
			createAnchor('mine', reader.result, file.name, file.size);		
		}
	}
}

/****************************************************************************
 * Aux functions, mostly UI-related
 ****************************************************************************/

function logError(err) {
	console.log(err.toString(), err);
}

function remoteMute() {
	if(remoteStream != null && remoteVideo.muted == false) {
		remoteVideo.muted = true;
		console.log('remoteVideo is muted?', remoteVideo.muted);
		remoteMuteButton.disabled = true;
		remoteUnmuteButton.disabled = false;
	}
}

function remoteUnmute() {
	if(remoteStream != null && remoteVideo.muted == true) {
		remoteVideo.muted = false;
		console.log('remoteVideo is muted?', remoteVideo.muted);
		remoteMuteButton.disabled = false;
		remoteUnmuteButton.disabled = true;
	}
}