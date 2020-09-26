import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot/models/spot.dart';
import 'package:spot/providers/spot_places.dart';
import 'package:spot/widgets/image_input.dart';
import 'package:spot/widgets/location_input.dart';

class AddSpotScreen extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _AddSpotScreenState createState() => _AddSpotScreenState();
}

class _AddSpotScreenState extends State<AddSpotScreen> {
  final _titleController = TextEditingController();

  File _pickedImage;
  SpotLocation _spotLocation;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectSpot(double lat, double lng) {
    _spotLocation = SpotLocation(
      longitude: lng,
      latitude: lat,
      // address: _spotLocation.address,
    );
  }

  Future<void> _saveSpot() async {
    print('Saved: ${_spotLocation.address}');
    print('Saved1: ${_pickedImage.path}');
    print('Saved2: ${_titleController.text}');

    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _spotLocation == null) {
      // We could validate more and show a widget.. don't you think we should?
      return;
    }

    await Provider.of<SpotPlacesNotifier>(
      context,
      listen: false,
    ).addSpot(
        pickedImage: _pickedImage,
        pickedTitle: _titleController.text,
        spotLocation: _spotLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Spot'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(
                  10.0,
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(
                      onSelectImage: _selectImage,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(onSelectSpot: _selectSpot),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            label: Text('Add Spot'),
            icon: Icon(
              Icons.add,
            ),
            onPressed: _saveSpot,
          ),
        ],
      ),
    );
  }
}
