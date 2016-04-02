function notifyMe(title) {
	// Let's check if the browser supports notifications
	if (!("Notification" in window)) {
		alert("This browser does not support desktop notification");
	}

	// Let's check whether notification permissions have already been granted
	else if (Notification.permission === "granted") {
		// If it's okay let's create a notification
		var notification = createNotification(title);
	}

	// Otherwise, we need to ask the user for permission
	else if (Notification.permission !== 'denied') {
		Notification.requestPermission(function (permission) {
			// If the user accepts, let's create a notification
			if (permission === "granted") {
				var notification = createNotification(title);
			}
		});
	}

	// At last, if the user has denied notifications, and you
	// want to be respectful there is no need to bother them any more.
} Notification.requestPermission().then(function(result) {
	console.log(result);
});

function createNotification(title) {
	var options = {
		body: "상담이 도착했습니다.",
		icon: getContextPath()+"/assets/img/favicon.png"
	};
	return new Notification (title,options);
}

function getContextPath(){
	var offset=location.href.indexOf(location.host)+location.host.length;
	var ctxPath = location.href.substring(offset,location.href.indexOf('/',offset+1));
	return ctxPath;
}