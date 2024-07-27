// TODO Implement this library.
class VisitedPlaces {
  static final List<Map<String, dynamic>> _visitedPlaces = [];

  static List<Map<String, dynamic>> get visitedPlaces => _visitedPlaces;

  static void addPlace(Map<String, dynamic> place) {
    _visitedPlaces.add(place);
  }
}
