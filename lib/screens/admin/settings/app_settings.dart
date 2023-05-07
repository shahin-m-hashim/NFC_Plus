import 'package:flutter/material.dart';

class AppSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Notifications'),
            trailing: Switch(
              value:
                  false, // Replace with your logic to handle the switch state
              onChanged: (bool value) {
                // Replace with your logic to handle switch changes
              },
            ),
          ),
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value:
                  false, // Replace with your logic to handle the switch state
              onChanged: (bool value) {
                // Replace with your logic to handle switch changes
              },
            ),
          ),
          ListTile(
            title: Text('Language'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Replace with your logic to navigate to language settings
            },
          ),
          ListTile(
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Replace with your logic to navigate to privacy policy screen
            },
          ),
        ],
      ),
    );
  }
}
