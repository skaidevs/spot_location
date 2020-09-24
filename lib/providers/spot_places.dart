import 'package:flutter/foundation.dart';
import 'package:spot/models/spot.dart';

// SpotPlacesNotifier will mange spots
class SpotPlacesNotifier with ChangeNotifier {
  List<Spot> _items = [];

  List<Spot> get items {
    return [...items];
  }
}
