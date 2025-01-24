import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:shoply/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shoply/core/common/widgets/custom_app_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController =
      MapController(); //to control the map view(camera)

  LocationData? currentLocation; // to get the current location
  List<LatLng> routePoints =
      []; // to store the route points, this will be used to draw the route on the map
  List<Marker> markers = []; // to store the markers on the map and save it
  final String orsApiKey =
      '5b3ce3597851110001cf62488e38ba45243e4fea8548315106a38bb8';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    var location = Location();
    try {
      var userLocation = await location.getLocation();
      setState(() {
        currentLocation = userLocation;
        markers.add(Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(userLocation.latitude!, userLocation.longitude!),
          child: const Icon(Icons.my_location, color: kPrimaryColor, size: 40),
        ));
      });
    } on Exception {
      currentLocation = null;
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      //listen to location changes, if location changes, update the current location
      setState(() {
        currentLocation = currentLocation;
      });
    });
  }

  Future<void> _getRoute(LatLng destination) async {
    if (currentLocation == null) return;

    final start =
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    final response = await http.get(
      Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coords =
          data['features'][0]['geometry']['coordinates'];

      setState(() {
        routePoints =
            coords.map((coord) => LatLng(coord[1], coord[0])).toList();
        markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: destination,
            child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
          ),
        );
      });
    } else {
      // Handle errors
      print('Failed to fetch route');
    }
  }

  void _addDestinationMarker(LatLng point) {
    setState(() {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: point,
          child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
        ),
      );
    });
    _getRoute(point);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Map'),
      body: currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(
              color: kPrimaryColor,
            ))
          : FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                initialZoom: 13.0,
                onTap: (tapPosition, point) => _addDestinationMarker(point),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: markers),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routePoints,
                      strokeWidth: 3.0,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          if (currentLocation != null) {
            mapController.move(
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
              13.0,
            );
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
