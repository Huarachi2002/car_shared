import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
// import '../../../../config/requests/google_maps_requests.dart';
// import 'package:geocoding/geocoding.dart';
import '../states/app_state.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:uuid/uuid.dart';
// import '../../../../constants.dart';

class HomeMapScreen extends StatefulWidget {
  static const String name = 'home_screen';
  // const HomeMapScreen({super.key});

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Map());
  }
}

class Map extends StatefulWidget {
  // const Map({super.key});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  // late GoogleMapController mapController;
  // GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  // TextEditingController locationController = TextEditingController();
  // TextEditingController destinationController = TextEditingController();
  // static LatLng _initialPosition = LatLng(-17.7833274, -63.1835149);
  // LatLng _lasPosition = _initialPosition;
  // final Set<Marker> _markers = {};
  // final Set<Polyline> _polyLines = {};

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _getUserLocation();
  // }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return SafeArea(
        child: appState.initialPosition == null
            ? Container(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitRotatingCircle(
                        color: Colors.black,
                        size: 50.0,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: appState.locationServiceActive == false,
                    child: Text(
                      "Please enable location services!",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  )
                ],
              ))
            : Stack(
                children: <Widget>[
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: appState.initialPosition, zoom: 10.0),
                    onMapCreated: appState.onCreated,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    compassEnabled: true,
                    markers: appState.markers,
                    onCameraMove: appState.onCameraMove,
                    polylines: appState.polyLines,
                  ),
                  Positioned(
                      top: 50.0,
                      right: 15.0,
                      left: 15.0,
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 5.0),
                                blurRadius: 10,
                                spreadRadius: 3)
                          ],
                        ),
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: appState.locationController,
                          decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(left: 20, top: 5),
                              width: 10,
                              height: 10,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "pick up",
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 16.0),
                          ),
                        ),
                      )),
                  Positioned(
                    top: 105.0,
                    right: 15.0,
                    left: 15.0,
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 5.0),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ],
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: appState.destinationController,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) {
                          appState.sendRequest(value);
                        },
                        decoration: InputDecoration(
                          icon: Container(
                            margin: EdgeInsets.only(left: 20, top: 5),
                            width: 10,
                            height: 10,
                            child: Icon(
                              Icons.local_taxi,
                              color: Colors.black,
                            ),
                          ),
                          hintText: "destination?",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 15.0, top: 16.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }

//   void onCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }

//   void _onCameraMove(CameraPosition position) {
//     setState(() {
//       _lasPosition = position.target;
//     });
//   }

//   void _onAddMarkerPressed() {
//     setState(() {
//       _markers.add(Marker(
//           markerId: MarkerId(
//             _lasPosition.toString(),
//           ),
//           position: _lasPosition,
//           infoWindow: InfoWindow(title: "remember here", snippet: "good place"),
//           icon: BitmapDescriptor.defaultMarker));
//     });
//   }

//   List _decodePoly(String poly) {
//     var list = poly.codeUnits;
//     var lList = <dynamic>[];
//     int index = 0;
//     int len = poly.length;
//     int c = 0;
// repeating until all attributes are decoded
//     do {
//       var shift = 0;
//       int result = 0;

//       for decoding value of one attribute
//       do {
//         c = list[index] - 63;
//         result |= (c & 0x1F) << (shift * 5);
//         index++;
//         shift++;
//       } while (c >= 32);
//       /* if value is negetive then bitwise not the value */
//       if (result & 1 == 1) {
//         result = ~result;
//       }
//       var result1 = (result >> 1) * 0.00001;
//       lList.add(result1);
//     } while (index < len);

// /*adding to previous value as done in encoding */
//     for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

//     print(lList.toString());

//     return lList;
//   }

//   void _getUserLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     List<Placemark> placemark =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     setState(() {
//       _initialPosition = LatLng(position.latitude, position.longitude);
//       locationController.text = placemark[0].name!;
//     });
//   }
}
