import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:spot/helpers/db_helper.dart';
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
    DBHelper.insert('user_spot', {
      'id': newSpot.id,
      'title': newSpot.title,
      'image': newSpot.image.path,
    });
  }

  Future<void> fetchAndSetSpots() async {
    final _dataList = await DBHelper.getData('user_spot');
    _items = _dataList
        .map(
          (item) => Spot(
            id: item['id'],
            title: item['title'],
            location: null,
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
