import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/subway.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  TextEditingController addressController = TextEditingController();

  final addressTypeList = [
    {"image": "assets/icons/home.png", "title": "Casa"},
    {"image": "assets/icons/office.png", "title": "Oficina"},
    {"image": "assets/icons/globe.png", "title": "Otro"},
  ];

  int selectedType = 0;

  Completer<GoogleMapController> mapcontroller = Completer();

  TextEditingController searchController = TextEditingController();

  static CameraPosition locationposition =
      const CameraPosition(target: LatLng(51.5403, 0.1482), zoom: 10.46);

  Map<String, Marker> markers = {};

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
          "Agregar nueva dirección",
          style: bold18Black,
        ),
      ),
      body: Stack(
        children: [
          googleMap(),
          addAddressSheet(size),
        ],
      ),
    );
  }

  Widget addAddressSheet(Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BottomSheet(
        onClosing: () => false,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: boxShadow,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: fixPadding * 2.0, horizontal: fixPadding * 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addressField(),
                      heightSpace,
                      heightSpace,
                      addressType(size),
                    ],
                  ),
                ),
                addButton(context)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget addButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: double.maxFinite,
        color: primaryColor,
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.3),
        child: const Text(
          "Agregar",
          style: bold18White,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget addressType(Size size) {
    return Row(
      children: List.generate(
        addressTypeList.length,
        (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedType = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: fixPadding / 2),
                padding: const EdgeInsets.all(fixPadding),
                decoration: BoxDecoration(
                  color: selectedType == index ? primaryColor : whiteColor,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: boxShadow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      addressTypeList[index]['image'].toString(),
                      height: 20.0,
                      width: 20.0,
                    ),
                    widthSpace,
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: (size.width - 210) / 3),
                      child: Text(
                        addressTypeList[index]['title'].toString(),
                        style:
                            selectedType == index ? bold16White : medium16Black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget addressField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dirección",
            style: bold18Black,
          ),
          heightSpace,
          height5Space,
          Container(
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: boxShadow,
            ),
            child: TextField(
              controller: addressController,
              cursorColor: primaryColor,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Ingresa o selecciona la dirección aquí",
                hintStyle: medium16Grey,
                prefixIconConstraints: BoxConstraints(maxWidth: 40.0),
                prefixIcon: Center(
                  child: Iconify(
                    Subway.location_1,
                    color: primaryColor,
                    size: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget googleMap() {
    return GoogleMap(
      initialCameraPosition: locationposition,
      onTap: (LatLng latLng) async {
        const MarkerId markerId = MarkerId('yourLocation');
        final Marker marker = Marker(
          markerId: markerId,
          position: latLng,
          icon: BytesMapBitmap(
            await getBytesFromAsset(
                "assets/restaurantDetail/map-marker.png", 100),
            bitmapScaling: MapBitmapScaling.none,
          ),
        );

        List<Placemark> newPlace =
            await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

        Placemark placeMark = newPlace[0];
        String street = placeMark.street!;
        String administrativeArea = placeMark.administrativeArea!;
        String postalCode = placeMark.postalCode!;
        String country = placeMark.country!;
        String address = "$street, $administrativeArea $postalCode, $country";

        setState(() {
          addressController.text = address;
          markers.clear();

          markers["yourLocation"] = marker;
        });
      },
      onMapCreated: (GoogleMapController controller) {
        mapcontroller.complete(controller);
        addMarker(
          'yourLocation',
          const LatLng(51.6003, 0.1482),
        );
      },
      markers: markers.values.toSet(),
    );
  }

  addMarker(String id, LatLng location) async {
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        icon: BytesMapBitmap(
          await getBytesFromAsset("assets/restaurantDetail/map-marker.png", 90),
          bitmapScaling: MapBitmapScaling.none,
        ));

    markers[id] = marker;
    setState(() {});
  }
}
