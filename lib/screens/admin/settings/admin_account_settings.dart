import 'package:flutter/material.dart';

class AdminAccountSettingsScreen extends StatelessWidget {
  const AdminAccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Edit Profile'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Replace with your logic to navigate to edit profile screen
            },
          ),
          ListTile(
            title: const Text('Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Replace with your logic to navigate to change password screen
            },
          ),
          ListTile(
            title: const Text('Privacy Settings'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Replace with your logic to navigate to privacy settings screen
            },
          ),
          ListTile(
            title: const Text('Logout'),
            trailing: const Icon(Icons.exit_to_app),
            onTap: () {
              // Replace with your logic to handle logout functionality
            },
          ),
        ],
      ),
    );
  }
}
