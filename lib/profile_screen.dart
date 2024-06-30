import 'package:flutter/material.dart';
import 'package:just_another_flutter/settings.dart';

class ProfileScreen extends StatelessWidget {
  final Color cardColor = Color.fromARGB(255, 79, 150, 145);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildUserInfoCard(),
            SizedBox(height: 54),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildBioSection(),
                    SizedBox(height: 54),
                    _buildOptionsList(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildUserInfoCard() {
    return Container(
      padding: EdgeInsets.all(16),
      color: cardColor,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40, color: Colors.grey[400]),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name...',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text("Other users' info...",
                  style: TextStyle(color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBioSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('BIO',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.white,
            padding: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 50),
            child: Text(
              'User bio......',
              style: TextStyle(
                  color: Colors.black,
                  height: 1.5,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsList(BuildContext context) {
    // Accept context here
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildOptionItem('Settings', context), // Pass context here
          _buildOptionItem('Saved Attractions', context),
          _buildOptionItem('History', context),
          _buildOptionItem('Past Itineraries', context),
        ],
      ),
    );
  }

  Widget _buildOptionItem(String title, BuildContext context) {
    // Accept context here
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.black),
        onTap: () {
          if (title == 'Settings') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: cardColor,
      currentIndex: 3, // Profile tab is selected
      items: [
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
