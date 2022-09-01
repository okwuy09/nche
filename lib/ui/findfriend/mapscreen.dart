import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/const_values.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _googleMapController = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    getCurrentLocation();
    getCustomMarkerIcon();
    getPolyPoint();
    super.initState();
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
          (location) => {
            currentLocation = location,
          },
        );

    GoogleMapController googleMapController = await _googleMapController.future;

    location.onLocationChanged.listen((newLocation) {
      currentLocation = newLocation;

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(
              newLocation.latitude!,
              newLocation.longitude!,
            ),
          ),
        ),
      );
      setState(() {});
    });
  }

  void getPolyPoint() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void getCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/musk.jpg')
        .then(
      (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/musk.jpg')
        .then(
      (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/musk.jpg')
        .then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
              child: currentLocation == null
                  ? RefreshIndicator(
                      onRefresh: () async => await _pullRefresh(),
                      child: Stack(
                        children: [
                          ListView(),
                          const Center(child: Text('Loading...')),
                        ],
                      ))
                  : ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      child: GoogleMap(
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            // sourceLocation.latitude,
                            // sourceLocation.longitude,
                            currentLocation!.latitude!,
                            currentLocation!.longitude!,
                          ),
                          zoom: 13.5,
                        ),
                        polylines: {
                          Polyline(
                            polylineId: const PolylineId('route'),
                            points: polylineCoordinates,
                            color: AppColor.darkerYellow,
                            width: 6,
                          ),
                        },
                        markers: {
                          // Marker(
                          //   markerId: const MarkerId('currentLocation'),
                          //   icon: currentLocationIcon,
                          //   position: LatLng(
                          //     currentLocation!.latitude!,
                          //     currentLocation!.longitude!,
                          //   ),
                          // ),
                          Marker(
                            markerId: const MarkerId('source'),
                            icon: sourceIcon,
                            position: sourceLocation,
                          ),
                          Marker(
                            markerId: const MarkerId('destination'),
                            icon: destinationIcon,
                            position: destination,
                          )
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
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                        image: AssetImage('assets/musk.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '800 km',
                                style: style.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.darkerGrey,
                                ),
                              ),
                              Text(
                                'Distance',
                                style: style.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: screenSize.width * 0.13),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '35 mins',
                                style: style.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.darkerGrey,
                                ),
                              ),
                              Text(
                                'Estimated Time',
                                style: style.copyWith(
                                  fontSize: 13,
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
                  Expanded(child: Container()),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: AppColor.darkerYellow,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.location_on_outlined,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
