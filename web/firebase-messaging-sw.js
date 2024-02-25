importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js");

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;


firebase.initializeApp({
  apiKey: "AIzaSyBqbrQ-GCk6UON6VBn99Iu60lGSQhIiiYM",
  authDomain: "reviwe-on-firebase.firebaseapp.com",
  databaseURL: 'https://reviwe-on-firebase.firebaseio.com',
  projectId: 'reviwe-on-firebase',
  storageBucket: "reviwe-on-firebase.appspot.com",
  messagingSenderId: '151606860503',
  appId: "1:151606860503:web:cec424678b530e3c2f6e92",
  measurementId: "G-7G3W148R04",
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});