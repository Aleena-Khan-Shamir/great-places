import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];
  Place findId(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> savePlace(
    String pickTitle,
    File pickImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedAddress = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickTitle,
      location: updatedAddress,
      image: pickImage,
    );

    _items.add(newPlace);
    notifyListeners();

    await DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat_lat': newPlace.location.latitude,
      'lat_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> getAndFetchPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
                latitude: item['lat_lat'],
                longitude: item['lat_lng'],
                address: item['address']),
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
