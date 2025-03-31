import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';
import 'package:pn_fl_foody_user/widget/column_builder.dart';
import 'package:readmore/readmore.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({super.key});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  GoogleMapController? mapController;

  List<Marker> allMarkers = [];

  static const CameraPosition _currentPosition =
      CameraPosition(target: LatLng(51.497351, -0.127758), zoom: 14);

  bool isFavorite = false;

  final mostPoularFoodList = [
    {
      "image": "assets/food/food12.png",
      "name": "Pizza Margherita",
      "description": "Haz que esta temporada de parrilladas... ",
      "rate": 5.0,
      "price": 8.30,
      "isFavorite": false
    },
    {
      "image": "assets/food/food19.png",
      "name": "Hamburguesa Clásica con Queso",
      "description": "Haz que esta temporada de parrilladas... ",
      "rate": 4.0,
      "price": 6.30,
      "isFavorite": false
    },
    {
      "image": "assets/food/food20.png",
      "name": "Sándwich de Chutney",
      "description": "Haz que esta temporada de parrilladas... ",
      "rate": 4.0,
      "price": 5.30,
      "isFavorite": false
    },
    {
      "image": "assets/food/food21.png",
      "name": "Tostada de Aguacate",
      "description": "Haz que esta temporada de parrilladas... ",
      "rate": 5.0,
      "price": 10.30,
      "isFavorite": false
    },
    {
      "image": "assets/food/food15.png",
      "name": "Pizza de Paneer",
      "description": "Haz que esta temporada de parrilladas... ",
      "rate": 4.5,
      "price": 5.30,
      "isFavorite": false
    },
  ];

  final reviewList = [
    {
      "image": "assets/review/review-1.png",
      "title": "Peter Willims",
      "date": "2 ene 2022",
      "rate": 5.0,
      "review":
          "Lorem ipsum dolor sit amet consectetur. Vel volutpat turpis a senectus aliquet vghiverra. Libero neque maecenas erat aliquet "
    },
    {
      "image": "assets/review/review-2.png",
      "title": "Courtney Henry",
      "date": "11 ene 2022",
      "rate": 4.5,
      "review":
          "Lorem ipsum dolor sit amet consectetur. Vel volutpat turpis a senectus aliquet vghiverra. Libero neque maecenas erat aliquet "
    },
    {
      "image": "assets/review/review-3.png",
      "title": "Guy Hawkins",
      "date": "12 ene 2022",
      "rate": 4.0,
      "review":
          "Lorem ipsum dolor sit amet consectetur. Vel volutpat turpis a senectus aliquet vghiverra. Libero neque maecenas erat aliquet "
    }
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          header(size, context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(fixPadding * 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      restaurantInfo(),
                      heightSpace,
                      heightSpace,
                      description(),
                      heightSpace,
                      heightSpace,
                      restaurantLocation(),
                    ],
                  ),
                ),
                heightSpace,
                heightSpace,
                mostPopularListContent(context),
                heightSpace,
                reviews(),
                heightBox(fixPadding * 1.25),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: orderFoodNowButton(),
    );
  }

  Widget orderFoodNowButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/restuarantFood');
      },
      child: Container(
        width: double.maxFinite,
        color: primaryColor,
        padding: const EdgeInsets.symmetric(
            vertical: fixPadding * 1.3, horizontal: fixPadding * 2.0),
        child: const Text(
          "Pedir comida ahora",
          style: extrabold18White,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
 Widget reviews() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                "Reseñas", // Traducción de "Reviews"
                style: bold16Black,
              ),
            ),
            widthSpace,
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/reviews');
              },
              child: const Text(
                "Ver todas", // Traducción de "View All"
                style: bold12Primary,
              ),
            )
          ],
        ),
        heightBox(fixPadding * 0.75),
        ColumnBuilder(
          itemBuilder: (context, index) {
            final reviewData = reviewList[index];
            return Container(
              padding: const EdgeInsets.all(fixPadding),
              margin: const EdgeInsets.symmetric(vertical: fixPadding * 0.75),
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: boxShadow),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              reviewData['image'].toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      widthSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reviewData['title'].toString(),
                              style: semibold15Black,
                              overflow: TextOverflow.ellipsis,
                            ),
                            heightBox(fixPadding * 0.2),
                            Text(
                              reviewData['date'].toString(),
                              style: semibold14Grey,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      widthSpace,
                      const Icon(
                        Icons.grade_rounded,
                        color: yellowColor,
                        size: 17.0,
                      ),
                      width5Space,
                      Text(
                        reviewData['rate'].toString(),
                        style: medium14Black,
                      )
                    ],
                  ),
                  heightSpace,
                  Text(
                    reviewData['review'].toString(),
                    style: medium14Grey,
                  )
                ],
              ),
            );
          },
          itemCount: reviewList.length,
        )
      ],
    ),
  );
}
  Widget mostPopularListContent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        child: Text(
          "Más Popular", // Traducción de "Most Popular"
          style: bold16Black,
        ),
      ),
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            mostPoularFoodList.length,
            (index) {
              final mostPopularItemData = mostPoularFoodList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/foodDetail');
                },
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.symmetric(horizontal: fixPadding),
                  padding: const EdgeInsets.all(fixPadding),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: boxShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(fixPadding * 0.5),
                        height: 78.0,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage(
                              mostPopularItemData['image'].toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              mostPopularItemData['isFavorite'] =
                                  !(mostPopularItemData['isFavorite']
                                      as bool);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: blackColor,
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(milliseconds: 1500),
                                content: Text(
                                  mostPopularItemData['isFavorite'] == true
                                      ? "Añadido a favoritos" // Traducción de "Added to favourite"
                                      : "Eliminado de favoritos", // Traducción de "Removed from favourite"
                                  style: semibold16White,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 25.0,
                            width: 25.0,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Icon(
                              mostPopularItemData['isFavorite'] == true
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: whiteColor,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                      heightSpace,
                      Text(
                        mostPopularItemData['name'].toString(),
                        style: semibold14Black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      heightBox(fixPadding * 0.3),
                      Text(
                        mostPopularItemData['description'].toString(),
                        style: medium12Grey,
                        overflow: TextOverflow.ellipsis,
                      ),
                      heightBox(fixPadding * 0.3),
                      Row(
                        children: [
                          const Icon(
                            Icons.grade_rounded,
                            color: yellowColor,
                            size: 15.0,
                          ),
                          widthBox(fixPadding * 0.3),
                          Expanded(
                            child: Text(
                              mostPopularItemData['rate'].toString(),
                              style: medium12Black,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          width5Space,
                          Text(
                            "\$${(mostPopularItemData['price'] as double).toStringAsFixed(2)}",
                            style: semibold14Black,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      )
    ],
  );
}
  Widget restaurantLocation() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Ubicación", // Traducción de "Location"
        style: bold16Black,
      ),
      heightSpace,
      height5Space,
      Container(
        height: 130,
        width: double.maxFinite,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: boxShadow,
        ),
        child: GoogleMap(
          initialCameraPosition: _currentPosition,
          markers: Set.from(allMarkers),
          onMapCreated: mapCreated,
          zoomControlsEnabled: false,
        ),
      )
    ],
  );
}

Widget description() {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Descripción", // Traducción de "Description"
        style: bold16Black,
      ),
      heightSpace,
      ReadMoreText(
        "Lorem ipsum dolor sit amet consectetur. Non feugiat lorem at pulvinar leo cursus. Ipsum mattis odiosectus iaculis convallis hac sit in fames. Tristique aliqmattis lgravida ipsum. Lorem ipsum dolor sit amconsectetur. Non feugiat lorem at pulvinar leo cursus. ",
        style: medium14Grey,
        trimExpandedText: "Mostrar menos", // Traducción de "Show less"
        trimCollapsedText: "Leer más", // Traducción de "Read more"
        lessStyle: bold14Primary,
        moreStyle: bold14Primary,
      )
    ],
  );
}

Widget restaurantInfo() {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              "Restaurante Bar 61", // Traducción de "Bar 61 Restaurant"
              style: bold18Black,
            ),
          ),
          widthSpace,
          widthSpace,
          Icon(
            Icons.grade_rounded,
            size: 19.0,
            color: yellowColor,
          ),
          width5Space,
          Text(
            "5.0",
            style: medium14Black,
          )
        ],
      ),
      heightSpace,
      Text(
        "76A Calle de Inglaterra, Calle de la Iglesia, Inglaterra", // Traducción de la dirección
        style: medium16Grey,
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
      position: const LatLng(51.497351, -0.127758),
      anchor: const Offset(0.4, 0.25),
      icon: BytesMapBitmap(
        await getBytesFromAsset("assets/restaurantDetail/map-marker.png", 70),
        bitmapScaling: MapBitmapScaling.none,
      ),
    ),
  );
}

SliverAppBar header(Size size, BuildContext context) {
  return SliverAppBar(
    expandedHeight: size.height * 0.35,
    pinned: true,
    backgroundColor: primaryColor,
    centerTitle: false,
    automaticallyImplyLeading: false,
    titleSpacing: 0.0,
    title: headerIcons(context),
    flexibleSpace: FlexibleSpaceBar(
      background: Image.asset(
        "assets/restaurantDetail/restaurant-image.png",
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget headerIcons(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 35.0,
            width: 35.0,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: const Icon(
              Icons.west,
              color: whiteColor,
              size: 22.0,
            ),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: blackColor,
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(milliseconds: 1500),
                    content: Text(
                      isFavorite
                          ? "Añadido a favoritos" // Traducción de "Added to favourite"
                          : "Eliminado de favoritos", // Traducción de "Removed from favourite"
                      style: semibold16White,
                    ),
                  ),
                );
              },
              child: Container(
                height: 35.0,
                width: 35.0,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Icon(
                  isFavorite
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  color: whiteColor,
                  size: 22.0,
                ),
              ),
            ),
            widthSpace,
            widthSpace,
            Container(
              height: 35.0,
              width: 35.0,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Icon(
                Icons.share,
                color: whiteColor,
                size: 22.0,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
}
