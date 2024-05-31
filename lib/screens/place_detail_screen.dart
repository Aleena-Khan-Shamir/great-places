import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:provider/provider.dart';

class PlaceSetailScreen extends StatelessWidget {
  const PlaceSetailScreen({super.key});
  static const routeName = '/detail-place';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findId(id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 170,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(selectedPlace.image), fit: BoxFit.cover)),
          )
        ],
      ),
    );
  }
}
