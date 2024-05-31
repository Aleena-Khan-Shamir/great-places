// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_places_screen.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddPlacesScreen.routeName);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .getAndFetchPlaces(),
          builder: (_, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : Consumer<GreatPlaces>(
                  builder: (_, greatPlaces, ch) {
                    if (greatPlaces.items.isEmpty) {
                      return const Center(
                        child: Text('Got no places yet, start adding some!'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (_, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.items[index].image),
                          ),
                          title: Text(greatPlaces.items[index].title),
                          // subtitle:
                          //     Text(greatPlaces.items[index].location.address),
                          onTap: () {
                            Navigator.pushNamed(
                                context, PlaceSetailScreen.routeName,
                                arguments: greatPlaces.items[index].id);
                          },
                        ),
                      );
                    }
                  },
                ),
        ));
  }
}
