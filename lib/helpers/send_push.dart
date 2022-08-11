import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

String? _token;

int _messageCount = 0;

String constructFCMPayload(String? token, dado,nome) {
  _messageCount++;
  return jsonEncode({
    "to": "/topics/all",
    "notification": {
      "title": "Dado Rolado",
      "body": "${nome} rolou dado de valor ${dado}",
      "mutable_content": true,
      "sound": "Tri-tone"
    },
    "data": {
      "url":
          "https://lh3.googleusercontent.com/-7lBWeaO5hYo/AAAAAAAAAAI/AAAAAAAAAAA/AHYzNgo-f5xFy_5nzjT3oc4RmidlgRBMXQ/photo.jpg?sz=46",
      "dl": "null"
    }
  });
}

getToken() async {
  return await FirebaseMessaging.instance.getToken();
}

Future<void> sendPushMessage(valorDado, nome) async {
  _token = await getToken();
  print(_token);
  if (_token == null) {
    print('Unable to send FCM message, no token exists.');
    return;
  }

  try {
    http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        /*headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },*/
        body: constructFCMPayload(_token, valorDado,nome),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer AAAAbj9SsWg:APA91bGsh1YMIplRT5gkchPzOvSUyrWsKbpmp4CRBzx_2FcKOE3vEZgrTRQ0jATTjI_s4cnsuzwY2QNw_cu4nRgCt-S7FNAjHI-GJAY-rLeGIic3oODC6nRJbOt1TjAZLZKLQKiWh_y6'
        });

    print('FCM request for device sent!');
    print(response.toString());
  } catch (e) {
    print(e);
  }
}
