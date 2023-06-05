import 'package:flutter/material.dart';

import '../../../authentication/services/auth_services.dart';

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
            title: const Text('Logout'),
            trailing: const Icon(Icons.exit_to_app),
            onTap: () async {
              final AuthService _authService = AuthService();
              await _authService.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'home', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
