import 'package:flutter/material.dart';
import 'package:rwandapp/Pages/home_page.dart';
import 'package:rwandapp/Pages/location.dart';
import 'package:rwandapp/settings/account.dart';
import 'package:rwandapp/settings/feedback.dart';
import 'package:rwandapp/settings/notification.dart';


class SettingsScreen extends StatelessWidget {
  final Color cardColor = const Color.fromARGB(255, 79, 150, 145);
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color.fromARGB(255, 79, 150, 145),
      ),
      body: Column(children: [
        _buildSettingsOption(context, title: 'Account', onTap: () {}),
        _buildSettingsOption(context, title: 'Notifications', onTap: () {}),
        _buildSettingsOption(context, title: 'Privacy', onTap: () {}),
        _buildSettingsOption(context, title: 'Help', onTap: () {}),
        _buildSettingsOption(context, title: 'About', onTap: () {}),
        _buildSettingsOption(context, title: 'feedback', onTap: () {}),
        _buildSettingsOption(context, title: 'Logout', onTap: () {}),
      ]),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildSettingsOption(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        switch (title) {
          case 'Account':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AcoountScreen()));
            break;
          case 'feedback':
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FeedbackScreen()));
            break;
          case 'Notifications':
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsScreen()));
            break;
        }
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
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
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MapScreen()),
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
