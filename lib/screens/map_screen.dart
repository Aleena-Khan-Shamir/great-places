// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialCameraPosition;
  final bool isSelected;
  const MapScreen(
      {super.key,
      this.initialCameraPosition = const PlaceLocation(
        latitude: 37.422,
        longitude: -122.084,
        address: '',
      ),
      this.isSelected = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Map'),actions: [
        if(widget.isSelected) IconButton(onPressed:_pickedLocation==null?null: (){
          Navigator.of(context).pop(_pickedLocation);
        }, icon: const Icon(Icons.check))
      ],),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.initialCameraPosition.latitude,
              widget.initialCameraPosition.longitude,
            ),
            zoom: 16),
        onTap: widget.isSelected ? _selectLocation : null,
        markers: _pickedLocation != null
            ? {
                Marker(
                    markerId: const MarkerId('m1'), position: _pickedLocation!)
              }
            : {},
      ),
    );
  }
}
