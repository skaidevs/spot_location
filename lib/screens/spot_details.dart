import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot/providers/spot_places.dart';
import 'package:spot/screens/map.dart';

class SpotDetail extends StatelessWidget {
  static const routeName = '/spot-details';
  @override
  Widget build(BuildContext context) {
    final _id = ModalRoute.of(context).settings.arguments;

    final _selectedSpot = Provider.of<SpotPlacesNotifier>(
      context,
      listen: false,
    ).findById(_id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedSpot.title,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              _selectedSpot.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _selectedSpot.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).accentColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MapScreen(
                    initialLocation: _selectedSpot.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: Text(
              'View on Map',
            ),
            textColor: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
