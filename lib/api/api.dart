import 'dart:convert';
import 'package:http/http.dart' as http;

class MapAPI {
  final endpoint = 'https://openweathermap.org';

  final apiKey = '7694dea5580450ef02723bb4986150e2';

  Future<List<Map<String, dynamic>>> getLocations({type = 'all'}) async {
    var result = await http.get(Uri.parse('$endpoint/locations/$type?key=$apiKey'));
    var body = jsonDecode(result.body);
    return List.castFrom<dynamic, Map<String, dynamic>>(body['locations']);
  }

  Future<Map<String, dynamic>> getLocationDetails(id) async {
    var result = await http.get(Uri.parse('$endpoint/locations/$id?key=$apiKey'));
    return jsonDecode(result.body);
  }

}

void main() async {
  MapAPI mapAPI = MapAPI();

  // Example: Get all locations
  var locations = await mapAPI.getLocations();
  print('Locations: $locations');

  // Example: Get details of a specific location
  var locationDetails = await mapAPI.getLocationDetails('123');
  print('Location Details: $locationDetails');

}
