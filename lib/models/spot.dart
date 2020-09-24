//Spot => Place
import 'dart:io';

import 'package:flutter/cupertino.dart';

//How a spot (Place) should look like..
class Spot {
  final String id;
  final String title;
  //Location is express as coordinate which is defined by longitude and latitude
  final SpotLocation location;
  //Image are stored in the device..(Each image is a file in the device)
  final File image;

  Spot({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}

class SpotLocation {
  final double longitude;
  final double latitude;
  final String address;

  const SpotLocation({
    @required this.longitude,
    @required this.latitude,
    this.address,
  });
}
