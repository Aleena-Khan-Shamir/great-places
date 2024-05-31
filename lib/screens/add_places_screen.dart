import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlacesScreen extends StatefulWidget {
  const AddPlacesScreen({super.key});
  static const routeName = '/add-places';
  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;
  void _savedImage(File pickImage) {
    _pickedImage = pickImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng, address: '');
  }

  void _savedPlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .savePlace(_titleController.text, _pickedImage!, _pickedLocation!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Places')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(height: 15),
                  ImageInput(onSelectedImage: _savedImage),
                  const SizedBox(height: 15),
                  LocationInput(onSelected: _selectPlace)
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: _savedPlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Places'))
        ],
      ),
    );
  }
}
