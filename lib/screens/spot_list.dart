import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot/providers/spot_places.dart';
import 'package:spot/screens/add_spot.dart';
import 'package:spot/screens/spot_details.dart';

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
      body: FutureBuilder(
        future: Provider.of<SpotPlacesNotifier>(
          context,
          listen: false,
        ).fetchAndSetSpots(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<SpotPlacesNotifier>(
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
                              subtitle: Text(
                                spot.items[index].location.address,
                              ),
                              title: Text(spot.items[index].title),
                              onTap: () {
                                //Go to Detail page
                                Navigator.of(context).pushNamed(
                                  SpotDetail.routeName,
                                  arguments: spot.items[index].id,
                                );
                              },
                            ),
                          ),
                  ),
      ),
    );
  }
}
