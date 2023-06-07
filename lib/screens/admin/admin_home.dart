import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pages/admin_read.dart';
import 'settings/settings.dart';
import 'widgets/admin_dashboard.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key});

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _selectedIndex = 0;
  bool _isNotificationActive = false;

  void updateNotificationState(bool isActive) {
    setState(() {
      _isNotificationActive = isActive;
    });
  }

  void viewNotifications() async {
    await Navigator.pushNamed(context, 'notifications');
    setState(() {
      _isNotificationActive = false; // Reset notification state
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/nfc_plus.png',
                width: 35,
                height: 35,
              ),
              const SizedBox(width: 8),
              const Text(
                'NFC Plus',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              _isNotificationActive
                  ? Icons.notifications_active_sharp
                  : FeatherIcons.bell,
              size: 25.0,
              color: Colors.white,
            ),
            onPressed: () {
              viewNotifications();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.867),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nfc_rounded),
            label: 'NFC',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_sharp),
            label: 'Settings',
          ),
        ],
      ),
      body: _buildPageContent(_selectedIndex),
    );
  }

  Widget _buildPageContent(int index) {
    switch (index) {
      case 0:
        return const AdminDashboardScreen();
      case 1:
        return AdminRead(updateNotificationState: updateNotificationState);
      case 2:
        return const AdminSettingsScreen();
      default:
        return Container();
    }
  }
}
