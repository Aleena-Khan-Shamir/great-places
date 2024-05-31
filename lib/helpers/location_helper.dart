import 'dart:convert';

import 'package:http/http.dart' as http;

const gOOGLEAPIKEY = 'AIzaSyBg9yn5JtQgKRFbg6FCTy4ewbF24kRuAYI';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double longitutde, required double latitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$longitutde,$latitude&zoom=14&size=400x400&key=$gOOGLEAPIKEY&signature=YOUR_SIGNATURE';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$gOOGLEAPIKEY');
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
