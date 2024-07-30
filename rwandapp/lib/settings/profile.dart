import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:rwandapp/Pages/ExperiencesPage.dart';
import 'package:rwandapp/Pages/home_page.dart';
import 'package:rwandapp/settings/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rwandapp/main.dart'; // Assuming DiscoverRwandaScreen is in main.dart

class ProfileScreen extends StatefulWidget {
  final Color cardColor = const Color.fromARGB(255, 79, 150, 145);
  final String name;
  final String email;
  final String? profilePhotoUrl;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.email,
    this.profilePhotoUrl,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _profilePhotoUrl;
  final TextEditingController _bioController = TextEditingController(text: "User bio...");

  @override
  void initState() {
    super.initState();
    _profilePhotoUrl = widget.profilePhotoUrl;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePhotoUrl = pickedFile.path;
      });
    }
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DiscoverRwandaScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildUserInfoCard(),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildBioSection(),
                      const SizedBox(height: 32),
                      _buildOptionsList(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildUserInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: widget.cardColor,
      child: Row(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: _profilePhotoUrl != null
                      ? FileImage(File(_profilePhotoUrl!))
                      : null,
                  child: _profilePhotoUrl == null
                      ? Icon(Icons.person, size: 40, color: Colors.grey[400])
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(widget.email, style: const TextStyle(color: Colors.black)),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () => _logout(context),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
              ),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildBioSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('BIO',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          const SizedBox(height: 8),
          Container(
            color: Colors.white,
            child: TextFormField(
              controller: _bioController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: '',
                contentPadding: EdgeInsets.all(16),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.black,
                height: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Save the bio and handle further actions if needed
              print("Updated Bio: ${_bioController.text}");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: const Text('Save Bio'),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildOptionItem('Settings', context),
          _buildOptionItem('Saved Attractions', context),
          _buildOptionItem('History', context),
          _buildOptionItem('Past Itineraries', context),
        ],
      ),
    );
  }

  Widget _buildOptionItem(String title, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.black),
        onTap: () {
          if (title == 'Settings') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: widget.cardColor,
      currentIndex: 3,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      name: widget.name,
                      email: widget.email,
                      profilePhotoUrl: _profilePhotoUrl,
                    )),
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
