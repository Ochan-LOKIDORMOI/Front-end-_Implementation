import 'package:flutter/material.dart';

import 'VisitedPlaces.dart';

class ExperiencesPage extends StatelessWidget {
  const ExperiencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Experiences',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 13, 17, 13),
      ),
      body: ListView.builder(
        itemCount: VisitedPlaces.visitedPlaces.length,
        itemBuilder: (context, index) {
          final place = VisitedPlaces.visitedPlaces[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(
                place['imagePath'],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              title: Text(place['name']),
              subtitle: Text(place['description']),
            ),
          );
        },
      ),
    );
  }
}
