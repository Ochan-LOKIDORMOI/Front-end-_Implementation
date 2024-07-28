import 'package:flutter/material.dart';
import 'package:rwandapp/Pages/PlaceDetailsPage.dart';
import 'package:rwandapp/Pages/VisitedPlaces.dart';

void main() {
  runApp(const MaterialApp(
    home: ExperiencesPage(),
  ));
}

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
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaceDetailsPage(place: place),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    place['imagePath'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      place['name'],
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      place['description'],
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
