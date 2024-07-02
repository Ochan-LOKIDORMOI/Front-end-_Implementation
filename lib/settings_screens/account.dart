import 'package:flutter/material.dart';

class AcoountScreen extends StatelessWidget {
  const AcoountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: const Color.fromARGB(255, 79, 150, 145),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome, John!',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              const ListTile(
                leading: Icon(Icons.email),
                title: Text('Email: john@example.com'),
              ),
              const ListTile(
                leading: Icon(Icons.phone),
                title: Text('Phone: +1 123-456-7890'),
              ),
              const ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Location: Kigali , Rwanda'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 79, 150, 145),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {},
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

Widget _buildBottomNavigationBar() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.black,
    unselectedItemColor: const Color.fromARGB(255, 79, 150, 145),
    currentIndex: 3, // Profile tab is selected
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
