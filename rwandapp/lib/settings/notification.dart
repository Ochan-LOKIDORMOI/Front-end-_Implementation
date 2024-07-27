import 'package:flutter/material.dart';
import 'package:rwandapp/Pages/home_page.dart';
import 'package:rwandapp/Pages/ExperiencesPage.dart';


class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _receiveNotifications = true;
  bool _receiveEmailNotifications = false;
  bool _receivePushNotifications = true;

  void _toggleReceiveNotifications(bool value) {
    setState(() {
      _receiveNotifications = value;
    });
  }

  void _toggleReceiveEmailNotifications(bool value) {
    setState(() {
      _receiveEmailNotifications = value;
    });
  }

  void _toggleReceivePushNotifications(bool value) {
    setState(() {
      _receivePushNotifications = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        backgroundColor: const Color.fromARGB(255, 79, 150, 145),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSwitchListTile(
              title: 'Receive Notifications',
              value: _receiveNotifications,
              onChanged: _toggleReceiveNotifications,
            ),
            _buildSwitchListTile(
              title: 'Receive Email Notifications',
              value: _receiveEmailNotifications,
              onChanged: _toggleReceiveEmailNotifications,
            ),
            _buildSwitchListTile(
              title: 'Receive Push Notifications',
              value: _receivePushNotifications,
              onChanged: _toggleReceivePushNotifications,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    const Color cardColor = Color.fromARGB(255, 79, 150, 145);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: cardColor,
      currentIndex: 3,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExperiencesPage()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.grid_view), label: 'Experiences'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border), label: 'Wishlist'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}
