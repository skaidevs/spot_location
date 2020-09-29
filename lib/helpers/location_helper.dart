import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyCK4srOStRPR7W9SorbjwBe_mIRj2voLMc';

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    String _location =
        'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$latitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude &key=$GOOGLE_API_KEY';
    return _location;
  }


  static Future<String> getSpotAddress(double lat, double lng) async {
    final _locationAddress =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final _response = await http.get(_locationAddress);

    var _resp = json.decode(_response.body)['results'][0]['formatted_address'];
    print('Response return: $_resp');

    return _resp;
  }
}
