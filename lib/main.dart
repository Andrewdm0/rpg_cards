import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'models/personagem_bean.dart';
import 'pages/home_page/home_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

List personagens = [];
PersonagemBean? personagemBean;

Future<void> main() async {

  //Inicializando o Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Increvendo o usuario no tópico geral "All"
  FirebaseMessaging.instance.subscribeToTopic("all");
  runApp(MyApp());


  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'ic_stat_drafts',
            color: Colors.green,
            colorized: true,
          ),
        ),
      );
    }
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            textStyle: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
