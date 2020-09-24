import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:spot/models/spot.dart';

// SpotPlacesNotifier will mange spots
class SpotPlacesNotifier with ChangeNotifier {
  List<Spot> _items = [];

  List<Spot> get items {
    return [..._items];
  }

  void addSpot({
    String pickedTitle,
    File pickedImage,
  }) {
    final newSpot = Spot(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: null,
      image: pickedImage,
    );

    _items.add(newSpot);
    notifyListeners();
  }
}
