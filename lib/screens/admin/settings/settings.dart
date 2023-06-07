import 'package:flutter/material.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text('Account'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, 'admin_account_settings');
            },
          ),
          // ListTile(
          //   title: const Text('App Settings'),
          //   trailing: const Icon(Icons.arrow_forward_ios),
          //   onTap: () {
          //     Navigator.pushNamed(context, 'app_settings');
          //   },
          // ),
          ListTile(
            title: const Text('About'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, 'about');
            },
          ),
          // ListTile(
          //   title: const Text('Help'),
          //   trailing: const Icon(Icons.arrow_forward_ios),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
