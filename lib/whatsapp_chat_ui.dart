import 'package:flutter/material.dart';

class WhatsAppChatScreen extends StatefulWidget {
  const WhatsAppChatScreen({Key? key}) : super(key: key);

  @override
  _WhatsAppChatScreenState createState() => _WhatsAppChatScreenState();
}

class _WhatsAppChatScreenState extends State<WhatsAppChatScreen> {
  // A list of maps to store the chat data
  List<Map<String, dynamic>> chats = [
    {
      "image": "assets/images/user1.jpg",
      "name": "Alice",
      "text": "Hey, how are you?",
      "message": true,
      "date": "12:00 PM"
    },
    {
      "image": "assets/images/user2.jpg",
      "name": "Bob",
      "text": "I'm good, thanks.",
      "message": false,
      "date": "12:05 PM"
    },
    {
      "image": "assets/images/user3.jpg",
      "name": "Charlie",
      "text": "What are you doing?",
      "message": true,
      "date": "12:10 PM"
    },
    {
      "image": "assets/images/user4.jpg",
      "name": "David",
      "text": "Just working on a project.",
      "message": false,
      "date": "12:15 PM"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {},
              ),
              Expanded(
                child: TabBar(
                  tabs: [
                    Tab(
                      text: "CHATS",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(chats[index]["image"]),
              ),
              title: Text(chats[index]["name"]),
              subtitle: Row(
                children: [
                  if (chats[index]["message"])
                    Icon(
                      Icons.check,
                      size: 18,
                    ),
                  Text(chats[index]["text"]),
                ],
              ),
              trailing: Text(chats[index]["date"]),
            );
          },
        ),
      ),
    );
  }
}
