import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot/providers/spot_places.dart';
import 'package:spot/screens/add_spot.dart';
import 'package:spot/screens/spot_details.dart';
import 'package:spot/screens/spot_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SpotPlacesNotifier(),
      child: MaterialApp(
        title: 'Spot',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SpotListScreen(),
        routes: {
          AddSpotScreen.routeName: (ctx) => AddSpotScreen(),
          SpotDetail.routeName: (ctx) => SpotDetail(),
        },
      ),
    );
  }
}
