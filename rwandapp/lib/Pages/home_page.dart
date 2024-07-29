import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rwandapp/Pages/ExperiencesPage.dart';
import 'package:rwandapp/Pages/VisitedPlaces.dart';
import 'package:rwandapp/Pages/wishlist_screen.dart';
import 'package:rwandapp/settings/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final String name;
  final String email;

  const HomePage({
    super.key,
    required this.name,
    required this.email,
    String? profilePhotoUrl,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color cardColor = const Color.fromARGB(255, 79, 150, 145);
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover Rwanda',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 13, 17, 13),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for places...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.blue.shade50,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Recommended for you',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  color: Colors.blue.shade50,
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: constraints.maxWidth > 600 ? 300.0 : 200.0,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('places')
                          .where('category', isEqualTo: 'Recommended')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final filteredDocs = snapshot.data!.docs.where((doc) =>
                            doc['name']
                                .toString()
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()));
                        return GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (constraints.maxWidth / 2) /
                              (constraints.maxWidth / 2 + 100),
                          children: filteredDocs.map((doc) {
                            return _buildPlaceCard(
                              doc['name'],
                              doc['imagePath'],
                              doc['url'],
                              doc['description'],
                              constraints.maxWidth,
                              doc,
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  color: Colors.green.shade50,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  color: Colors.green.shade50,
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: constraints.maxWidth > 600 ? 300.0 : 200.0,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('places')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final filteredDocs = snapshot.data!.docs.where((doc) =>
                            doc['name']
                                .toString()
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()));
                        return GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (constraints.maxWidth / 2) /
                              (constraints.maxWidth / 2 + 100),
                          children: filteredDocs.map((doc) {
                            return _buildPlaceCard(
                              doc['name'],
                              doc['imagePath'],
                              doc['url'],
                              doc['description'],
                              constraints.maxWidth,
                              doc,
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildPlaceCard(String name, String imagePath, String url,
      String description, double screenWidth, QueryDocumentSnapshot doc) {
    return GestureDetector(
      onTap: () {
        VisitedPlaces.addPlace({
          'name': name,
          'imagePath': imagePath,
          'url': url,
          'description': description,
        });
        _launchURL(url);
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenWidth > 600 ? 180.0 : 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: NetworkImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: cardColor,
      currentIndex: 0,
      onTap: (index) {
        if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                name: widget.name,
                email: widget.email,
              ),
            ),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExperiencesPage()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WishlistScreen()),
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
