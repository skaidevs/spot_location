import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:spot/helpers/location_helper.dart';
import 'package:spot/screens/map.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectSpot;

  LocationInput({this.onSelectSpot});

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImage;

  void _showPreview({double lat, double lng}) {
    final _staticMapUrlImage = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImage = _staticMapUrlImage;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final _locationData = await Location().getLocation();
      print('Longitude: ${_locationData.longitude}');
      print('Latitude: ${_locationData.latitude}');

      _showPreview(
        lat: _locationData.latitude,
        lng: _locationData.longitude,
      );
      widget.onSelectSpot(
        _locationData.latitude,
        _locationData.longitude,
      );
    } catch (e) {
      print('GetCurrent location Error: ${e.toString()}');
      return;
    }
  }

  Future<void> _mapLocation() async {
    final _mappedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (_mappedLocation == null) {
      return;
    }
    print('Mapped Location: ${_mappedLocation.latitude}');

    _showPreview(
      lat: _mappedLocation.latitude,
      lng: _mappedLocation.longitude,
    );
    widget.onSelectSpot(
      _mappedLocation.latitude,
      _mappedLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170.0,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Theme.of(context).primaryColor),
          ),
          child: _previewImage == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.location_on,
              ),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.map,
              ),
              label: Text('Map Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _mapLocation,
            )
          ],
        )
      ],
    );
  }
}
