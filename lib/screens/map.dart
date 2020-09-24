import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spot/models/spot.dart';

class MapScreen extends StatefulWidget {
  final SpotLocation initialLocation;
  final bool isSelecting;

  const MapScreen({
    Key key,
    this.initialLocation = const SpotLocation(
      longitude: 7.4301923,
      latitude: 9.1258859,
    ),
    this.isSelecting = false,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.latitude,
          ),
          zoom: 16,
        ),
      ),
    );
  }
}
