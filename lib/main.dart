import 'dart:typed_data';

import 'package:batalyon/services/navigation_service.dart';
import 'package:batalyon/views/screen/alert/alert_view.dart';
import 'package:batalyon/views/screen/bukusaku/bukusaku.dart';
import 'package:batalyon/views/screen/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
final initializationSettingsIOS = IOSInitializationSettings();
final initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NavigationService());
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  final vibrationPattern = Int64List(1);

  vibrationPattern[0] = 18000;

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '040616', 'batalyon', 'sound of emergency',
      priority: Priority.high,
      vibrationPattern: vibrationPattern,
      enableLights: true,
      sound: RawResourceAndroidNotificationSound('emergency'),
      playSound: true,
      enableVibration: true,
      visibility: NotificationVisibility.public,
      importance: Importance.max,
      fullScreenIntent: true);
  var iOSPlatformChannelSpecifics =
      IOSNotificationDetails(presentAlert: true, presentSound: true);
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    '${message['data']['title']}',
    '${message['data']['message']}',
    platformChannelSpecifics,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (payload) async {
    GetIt.I<NavigationService>().navigateTo(AlertView.id);
  });
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
        onMessage: (message) async {
          print("onMessage: $message");
        },
        onLaunch: (message) async {
          print("onLaunch: $message");
          GetIt.I<NavigationService>().navigateTo(AlertView.id);
        },
        onResume: (message) async {
          print("onResume: $message");
        },
        onBackgroundMessage: myBackgroundMessageHandler);

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.getToken().then(print);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: GetIt.I<NavigationService>().navigatorKey,
      initialRoute: Home.id,
      routes: {
        Home.id: (context) => Home(),
        BukuSaku.id: (context) => BukuSaku(),
        AlertView.id: (context) => AlertView(),
      },
    );
  }
}
