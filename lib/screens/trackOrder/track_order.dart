import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:pn_fl_foody_user/constant/key.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  GoogleMapController? mapController;

  List<Marker> allMarkers = [];
  static const CameraPosition _currentPosition =
      CameraPosition(target: LatLng(51.498851, -0.147758), zoom: 14.0);

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  final startLat = 51.498528;
  final startLng = -0.158019;
  final endLat = 51.513011;
  final endLng = -0.136560;

  @override
  void initState() {
    getDirections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.west,
            color: blackColor,
          ),
        ),
        title: const Text(
          "Rastrear Pedido",
          style: bold18Black,
        ),
      ),
      body: Stack(
        children: [
          googleMap(size),
          deliveryDetail(),
        ],
      ),
    );
  }

  deliveryDetail() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(fixPadding * 1.5),
        margin: const EdgeInsets.all(fixPadding * 2.0),
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Repartidor",
                        style: semibold14Grey,
                        overflow: TextOverflow.ellipsis,
                      ),
                      heightBox(fixPadding * 0.3),
                      const Text(
                        "George Anderson",
                        style: semibold16Black,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                widthSpace,
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                  alignment: Alignment.center,
                  child: const Iconify(
                    Carbon.phone_filled,
                    color: whiteColor,
                    size: 20.0,
                  ),
                )
              ],
            ),
            heightSpace,
            height5Space,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Llegando en",
                        style: semibold14Grey,
                        overflow: TextOverflow.ellipsis,
                      ),
                      heightBox(fixPadding * 0.3),
                      const Text(
                        "10 Minutos",
                        style: semibold16Black,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                widthSpace,
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: const Iconify(
                      IconParkSolid.message,
                      color: whiteColor,
                      size: 20.0,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  googleMap(Size size) {
    return SizedBox(
      height: double.maxFinite,
      width: size.width,
      child: GoogleMap(
        mapType: MapType.terrain,
        polylines: Set<Polyline>.of(polylines.values),
        initialCameraPosition: _currentPosition,
        markers: Set.from(allMarkers),
        onMapCreated: mapCreated,
        zoomControlsEnabled: false,
      ),
    );
  }

  mapCreated(GoogleMapController controller) async {
    mapController = controller;
    await marker();
    if (mounted) {
      setState(() {});
    }
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(startLat, startLng),
        destination: PointLatLng(endLat, endLng),
        mode: TravelMode.driving,
        wayPoints: [
          PolylineWayPoint(location: "Regent St, London W1B 5AS"),
        ],
      ),
      googleApiKey: googleMapApiKey,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: primaryColor,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
    if (mounted) {
      setState(() {});
    }
  }

  marker() async {
    allMarkers.add(
      Marker(
          markerId: const MarkerId("0"),
          rotation: 0.1,
          visible: true,
          position: LatLng(startLat, startLng),
          anchor: const Offset(0.4, 0.25),
          icon: BytesMapBitmap(
            await getBytesFromAsset("assets/trackOrder/marker-1.png", 90),
            bitmapScaling: MapBitmapScaling.none,
          )),

    );
    allMarkers.add(
      Marker(
        markerId: const MarkerId("1"),
        position: LatLng(endLat, endLng),
        icon: BytesMapBitmap(
          await getBytesFromAsset("assets/trackOrder/marker-2.png", 90),
          bitmapScaling: MapBitmapScaling.none,
        ),
        anchor: const Offset(0.35, 0.4),
      ),
    );
  }
}
