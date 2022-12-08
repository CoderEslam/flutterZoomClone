import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone_tutorial/resources/auth_methods.dart';
import 'package:zoom_clone_tutorial/screens/home_screen.dart';
import 'package:zoom_clone_tutorial/screens/login_screen.dart';
import 'package:zoom_clone_tutorial/screens/video_call_screen.dart';
import 'package:zoom_clone_tutorial/utils/colors.dart';

/*
* SHA1: F3:67:56:60:18:49:2B:50:A0:DE:36:0A:9E:90:3E:F2:CC:EF:19:E9
* SHA-256: CB:58:70:BD:4E:65:3E:CB:95:AE:41:8D:62:F6:37:F1:E7:4C:9B:58:DC:99:17:1C:32:F3:00:A5:B8:81:AF:DB
* */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/video-call': (context) => const VideoCallScreen(),
      },
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
