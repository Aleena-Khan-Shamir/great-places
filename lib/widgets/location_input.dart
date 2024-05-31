import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelected;
  const LocationInput({super.key, required this.onSelected});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  _showPreview(double lng, double lat) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        longitutde: lng, latitude: lat);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getUserCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      log(locData.toString());
      _showPreview(locData.longitude!, locData.latitude!);
      widget.onSelected(locData.longitude, locData.latitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectMap() async {
    final selectedLocation = await Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => const MapScreen(isSelected: true)));
    _showPreview(selectedLocation.longitude!, selectedLocation.latitude!);
    widget.onSelected(selectedLocation.longitude, selectedLocation.latitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 170,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border.all()),
        child: _previewImageUrl == null
            ? const Center(child: Text('No Location choosen'))
            : Image.network(
                _previewImageUrl!,
                fit: BoxFit.cover,
              ),
      ),
      const SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: _getUserCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location')),
          TextButton.icon(
              onPressed: _selectMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on map')),
        ],
      )
    ]);
  }
}
