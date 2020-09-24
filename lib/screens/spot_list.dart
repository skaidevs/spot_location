import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot/providers/spot_places.dart';
import 'package:spot/screens/add_spot.dart';

class SpotListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spot',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AddSpotScreen.routeName,
              );
            },
          ),
        ],
      ),
      body: Consumer<SpotPlacesNotifier>(
        child: Center(
          child: const Text('You got Nothing Spotted!'),
        ),
        builder: (context, spot, child) => spot.items.length <= 0
            ? child
            : ListView.builder(
                itemCount: spot.items.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                      spot.items[index].image,
                    ),
                  ),
                  title: Text(spot.items[index].title),
                  onTap: () {
                    //Go to Detail page
                    print('Go to Detail Page');
                  },
                ),
              ),
      ),
    );
  }
}
