import 'dart:async';
import 'dart:math';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';
import 'package:nche/model/users.dart';
import 'package:nche/services/provider/userdata.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  final Users destination;
  MapScreen({Key? key, required this.destination}) : super(key: key);

  final Completer<GoogleMapController> _googleMapController = Completer();

  //static const LatLng destination = LatLng(6.4096, 7.4978);

  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarkerWithHue(95);
  BitmapDescriptor sourceLocationIcon = BitmapDescriptor.defaultMarker;

  // calculate distance between two coordinate
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

// calculate the extimated time between two coordinate
  String getTimeTaken(Position source, LatLng dest) {
    double kms = calculateDistance(
        source.latitude, source.longitude, dest.latitude, dest.longitude);
    double kmsPerMin = 0.5;
    double minsTaken = kms / kmsPerMin;
    var totalMinutes = minsTaken;
    if (totalMinutes < 60) {
      return totalMinutes.toStringAsFixed(2) + "  mins";
    } else {
      String minutes = (totalMinutes % 60).toStringAsFixed(0);
      minutes = minutes.length == 1 ? "0" + minutes : minutes;
      return '${(totalMinutes / 60).toStringAsFixed(2)} hr  $minutes  mins';
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<UserData>(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        iconTheme: IconThemeData(color: AppColor.black),
        title: Align(
          widthFactor: 2,
          child: Text(
            'Track Friend',
            style: style.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: screenSize.height * 0.79,
              margin: const EdgeInsets.only(
                bottom: 6,
              ),
              decoration: BoxDecoration(
                color: AppColor.lightGrey,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      destination.location!.latitude,
                      destination.location!.longitude,
                    ),
                    zoom: 13.5,
                  ),
                  polylines: Set<Polyline>.of(provider.polylines.values),
                  markers: {
                    provider.locationPosition == null
                        ? const Marker(markerId: MarkerId('ok'))
                        : Marker(
                            markerId: const MarkerId('source'),
                            icon: sourceLocationIcon, //sourceLocationIcon,
                            position: LatLng(
                              provider.locationPosition!.latitude,
                              provider.locationPosition!.longitude,
                            ),
                          ),
                    Marker(
                      markerId: const MarkerId('destination'),
                      icon: destinationIcon,
                      position: LatLng(
                        destination.location!.latitude,
                        destination.location!.longitude,
                      ),
                      infoWindow: const InfoWindow(
                        title: 'Ruth',
                        snippet: 'New Location',
                      ),
                    ),
                  },
                  onMapCreated: ((controller) {
                    _googleMapController.complete(controller);
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.darkerYellow,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: NetworkImage(destination.avarter!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                calculateDistance(
                                      provider.locationPosition!.latitude,
                                      provider.locationPosition!.longitude,
                                      destination.location!.latitude,
                                      destination.location!.longitude,
                                    ).toStringAsFixed(2) +
                                    " KM",
                                style: style.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.darkerGrey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Distance',
                                style: style.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: screenSize.width * 0.15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTimeTaken(
                                  provider.locationPosition!,
                                  LatLng(
                                    destination.location!.latitude,
                                    destination.location!.longitude,
                                  ),
                                ),
                                style: style.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.darkerGrey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Estimated Time',
                                style: style.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Expanded(child: Container()),
                  // Container(
                  //   height: 45,
                  //   width: 45,
                  //   decoration: BoxDecoration(
                  //     color: AppColor.darkerYellow,
                  //     borderRadius: BorderRadius.circular(100),
                  //   ),
                  //   child: const Icon(
                  //     Icons.location_on_outlined,
                  //     size: 30,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
