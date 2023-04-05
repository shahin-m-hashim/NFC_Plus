import 'package:flutter/material.dart';
import 'package:mastering_flutter/whatsapp_chat_ui.dart';

// import 'package:mastering_flutter/netflix_login.dart';
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Netflix Login',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       home: _WhatsAppChatScreenState(),
//     );
//   }
// }

// Whatsapp Chat Screen UI
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 5,
        child: WhatsAppChatScreen(),
      ), // Use the WhatsApp chat screen as the home screen
    );
  }
}
