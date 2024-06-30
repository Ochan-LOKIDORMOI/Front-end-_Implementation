import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: const Color.fromARGB(255, 79, 150, 145),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text('Write your feedback here...'),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                hintText: 'Enter your feedback here...',
              ),
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
              child: const Text('Submit'),
            ),
            const SizedBox(height: 32),
            const Text('Rate Us',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(Icons.star,
                    color: index < 3 ? Colors.amber : Colors.grey, size: 32);
              }),
            ),
          ],
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
    unselectedItemColor: Color.fromARGB(255, 79, 150, 145),
    currentIndex: 3,
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
