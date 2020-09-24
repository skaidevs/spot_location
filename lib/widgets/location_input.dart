import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:spot/helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImage;

  Future<void> _getCurrentUserLocation() async {
    final _locationData = await Location().getLocation();
    print('Longitude: ${_locationData.longitude}');
    print('Latitude: ${_locationData.latitude}');
    final _staticMapUrlImage = LocationHelper.generateLocationPreviewImage(
      latitude: _locationData.latitude,
      longitude: _locationData.longitude,
    );

    setState(() {
      _previewImage = _staticMapUrlImage;
    });
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
              onPressed: () {},
            )
          ],
        )
      ],
    );
  }
}
