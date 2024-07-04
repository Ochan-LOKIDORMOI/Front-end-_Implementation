import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;

  final LatLng _kigaliCenter = const LatLng(-1.9706, 30.1044);
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _locations = [
    {
      'name': 'Inema Art Center',
      'latLng': const LatLng(-1.9535, 30.0915),
      'type': 'Art Gallery',
      'image': 'lib/images/inama art.jpg',
    },
    {
      'name': 'Caplaki Craft Village',
      'latLng': const LatLng(-1.9578, 30.0916),
      'type': 'Shopping',
      'image': 'lib/images/caplaki.jpg',
    },
    {
      'name': 'Kigali Genocide Memorial',
      'latLng': const LatLng(-1.9438, 30.0561),
      'type': 'Museum',
      'image': 'lib/images/genocide.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Rwanda'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TypeAheadField<Location>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search location',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  ),
                ),
              ),
              suggestionsCallback: (pattern) async {
                if (pattern.isEmpty) return [];
                return await locationFromAddress(pattern);
              },
              itemBuilder: (context, Location location) {
                return ListTile(
                  title: Text('${location.latitude}, ${location.longitude}'),
                );
              },
              onSuggestionSelected: (Location location) {
                _goToLocation(location.latitude, location.longitude);
              },
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _kigaliCenter,
                zoom: 12,
              ),
              markers: _locations.map((location) {
                return Marker(
                  markerId: MarkerId(location['name']),
                  position: location['latLng'],
                  infoWindow: InfoWindow(
                    title: location['name'],
                    snippet: location['type'],
                  ),
                );
              }).toSet(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Best of Kigali',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: _locations.map((location) {
                    return GestureDetector(
                      onTap: () => _goToLocation(
                        location['latLng'].latitude,
                        location['latLng'].longitude,
                      ),
                      child: Card(
                        child: ListTile(
                          leading: Image.asset(
                            location['image'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          title: Text(location['name']),
                          subtitle: Text(location['type']),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goToLocation(double lat, double lng) {
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 14),
      ),
    );
  }
}
