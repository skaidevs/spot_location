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
}
