import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:pn_fl_foody_user/screens/bottom_bar.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  GoogleMapController? mapController;

  List<Marker> allMarkers = [];

  static const CameraPosition _currentPosition =
      CameraPosition(target: LatLng(51.497351, -0.127758), zoom: 14);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final data = ModalRoute.of(context)?.settings.arguments as Map;
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
          "Detalles del Pedido",
          style: bold18Black,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding / 2,
            fixPadding * 2.0, fixPadding * 2.0),
        children: [
          orderInfo(data, size),
          heightSpace,
          heightSpace,
          orderItemsAndPriceDetail(),
          heightSpace,
          heightSpace,
          deliverTo(),
        ],
      ),
      bottomNavigationBar: data['status'] == "Ordered"
          ? Row(
              children: [
                Expanded(
                  child: buttonWidget("Calificar", () {
                    Navigator.pushNamed(context, '/rating');
                  }),
                ),
                widthBox(fixPadding * 0.3),
                Expanded(
                  child: buttonWidget("Reordenar", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomBar(index: 3),
                      ),
                    );
                  }),
                )
              ],
            )
          : buttonWidget(
              "Rastrear Pedido",
              () {
                Navigator.pushNamed(context, '/trackOrder');
              },
            ),
    );
  }

  Widget buttonWidget(String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(fixPadding * 1.3),
        width: double.maxFinite,
        color: primaryColor,
        child: Text(
          title,
          style: bold18White,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  deliverTo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Entregar a",
          style: bold16Black,
        ),
        heightSpace,
        height5Space,
        Container(
          padding: const EdgeInsets.all(fixPadding),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: boxShadow,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GoogleMap(
                  initialCameraPosition: _currentPosition,
                  markers: Set.from(allMarkers),
                  onMapCreated: mapCreated,
                  zoomControlsEnabled: false,
                ),
              ),
              widthSpace,
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Iconify(
                          Carbon.location,
                          color: greyColor,
                          size: 18.0,
                        ),
                        width5Space,
                        Expanded(
                          child: Text(
                            "Calle Aldama, centro...",
                            style: semibold14Black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    heightSpace,
                    Row(
                      children: [
                        Iconify(
                          Carbon.user,
                          color: greyColor,
                          size: 18.0,
                        ),
                        width5Space,
                        Expanded(
                          child: Text(
                            "Usuario 30",
                            style: semibold14Black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    heightSpace,
                    Row(
                      children: [
                        Iconify(
                          Carbon.phone,
                          color: greyColor,
                          size: 18.0,
                        ),
                        width5Space,
                        Expanded(
                          child: Text(
                            "+1(454)34211432",
                            style: semibold14Black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  mapCreated(GoogleMapController controller) async {
    mapController = controller;
    await marker();
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
        position: const LatLng(51.498051, -0.127758),
        anchor: const Offset(0.4, 0.25),
        icon: BytesMapBitmap(
          await getBytesFromAsset("assets/restaurantDetail/map-marker.png", 50),
          bitmapScaling: MapBitmapScaling.none,
        ),
      ),
    );
  }

  orderItemsAndPriceDetail() {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(fixPadding),
            color: recColor,
            child: const Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Text(
                    "Artículos del Pedido",
                    style: semibold16Black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                width5Space,
                Expanded(
                  flex: 2,
                  child: Text(
                    "Cant.",
                    style: semibold16Black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                width5Space,
                Expanded(
                  flex: 3,
                  child: Text(
                    "Monto",
                    style: semibold16Black,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(fixPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                orderItemInfo("Sandwich", "1", "\$6.00"),
                height5Space,
                orderItemInfo("Bebidas", "2", "\$8.00"),
                height5Space,
                orderItemInfo("Pizza", "1", "\$10.00"),
                height5Space,
                orderItemInfo("Monto Total", "", "\$24.00"),
                height5Space,
                heightSpace,
                const Text.rich(
                  TextSpan(
                    text: "Impuesto de Servicio : ",
                    style: semibold14Grey,
                    children: [
                      TextSpan(
                        text: "\$2.00",
                        style: medium14Black,
                      )
                    ],
                  ),
                  textAlign: TextAlign.right,
                ),
                height5Space,
                const Text.rich(
                  TextSpan(
                    text: "Cargo de Entrega : ",
                    style: semibold14Grey,
                    children: [
                      TextSpan(
                        text: "\$20.00",
                        style: medium14Black,
                      )
                    ],
                  ),
                  textAlign: TextAlign.right,
                ),
                height5Space,
                heightSpace,
                const Text.rich(
                  TextSpan(
                    text: "Monto a Pagar : ",
                    style: semibold14Black,
                    children: [
                      TextSpan(
                        text: "\$27.00",
                        style: bold14Primary,
                      )
                    ],
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  orderItemInfo(String title, String qty, String amount) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Text(
            title,
            style: medium14Black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        width5Space,
        Expanded(
          flex: 2,
          child: Text(
            qty,
            style: medium14Black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        width5Space,
        Expanded(
          flex: 3,
          child: Text(
            amount,
            style: medium14Black,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  orderInfo(Map<dynamic, dynamic> data, Size size) {
    return Container(
      height: 90.0,
      clipBehavior: Clip.hardEdge,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: boxShadow,
      ),
      child: Row(
        children: [
          imageBox(data['image'].toString()),
          Expanded(
            child: Stack(
              children: [
                orderContent(size, data),
                if (data['status'] == "Preparing")
                  statusBox("Preparando", orangeColor),
                if (data['status'] == "Dispatch")
                  statusBox("Enviado", primaryColor),
                if (data['status'] == "Ordered")
                  statusBox("Pedido", greyColor)
              ],
            ),
          )
        ],
      ),
    );
  }

  statusBox(String text, Color color) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 1.5, vertical: fixPadding / 2),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
          ),
        ),
        child: Text(
          text,
          style: bold14Grey.copyWith(color: color),
        ),
      ),
    );
  }

  imageBox(String image) {
    return Container(
      width: 65.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            image,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget orderContent(Size size, Map data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data['name'].toString(),
                  style: medium16Black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              widthSpace,
              Text(
                "${data['items']} Articulos",
                style: semibold14Grey,
              )
            ],
          ),
          heightBox(3.0),
          Row(
            children: [
              Container(
                height: 12.0,
                width: 12.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryColor, width: 2.0),
                ),
              ),
              width5Space,
              Expanded(
                child: Text(
                  data['orderId'].toString(),
                  style: semibold14Grey,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          heightBox(3.0),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 240),
            child: Text(
              "\$${(data['totalAmount'] as double).toStringAsFixed(2)}",
              style: bold16Black,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
