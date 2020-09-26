import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:spot/helpers/db_helper.dart';
import 'package:spot/helpers/location_helper.dart';
import 'package:spot/models/spot.dart';

// SpotPlacesNotifier will mange spots
class SpotPlacesNotifier with ChangeNotifier {
  List<Spot> _items = [];

  List<Spot> get items {
    return [..._items];
  }

  //Get a Single Spot by ID
  Spot findById(String id) {
    return _items.firstWhere((spot) => spot.id == id);
  }

  Future<void> addSpot({
    String pickedTitle,
    File pickedImage,
    SpotLocation spotLocation,
  }) async {
    final _address = await LocationHelper.getSpotAddress(
      spotLocation.latitude,
      spotLocation.longitude,
    );

    print('Address: $_address');
    final _updatedLocation = SpotLocation(
      longitude: spotLocation.longitude,
      latitude: spotLocation.longitude,
      address: _address,
    );

    final newSpot = Spot(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: _updatedLocation,
      image: pickedImage,
    );

    _items.add(newSpot);
    notifyListeners();
    DBHelper.insert('user_spot', {
      'id': newSpot.id,
      'title': newSpot.title,
      'image': newSpot.image.path,
      'loc_lat': newSpot.location.latitude,
      'loc_lng': newSpot.location.longitude,
      'address': newSpot.location.address,
    });
  }

  Future<void> fetchAndSetSpots() async {
    final _dataList = await DBHelper.getData('user_spot');
    _items = _dataList
        .map(
          (item) => Spot(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: SpotLocation(
              longitude: item['loc_lng'],
              latitude: item['loc_lat'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
