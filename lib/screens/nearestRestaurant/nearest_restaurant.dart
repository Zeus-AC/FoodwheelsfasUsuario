import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class NearestRestaurantScreen extends StatefulWidget {
  const NearestRestaurantScreen({super.key});

  @override
  State<NearestRestaurantScreen> createState() =>
      _NearestRestaurantScreenState();
}

class _NearestRestaurantScreenState extends State<NearestRestaurantScreen> {
  final restaurantNearYouList = [
    {
      "image": "assets/home/restaurant-1.png",
      "name": "Bar 61 Restaurant",
      "address": "76 A England Street",
      "rate": 4.5,
      "isFavorite": false
    },
    {
      "image": "assets/home/restaurant-2.png",
      "name": "Amrutha Lounge",
      "address": "99B Silicon Velley",
      "rate": 5.0,
      "isFavorite": false
    },
    {
      "image": "assets/home/restaurant-3.png",
      "name": "Core by Clare",
      "address": "220 Opera Street",
      "rate": 4.0,
      "isFavorite": false
    },
    {
      "image": "assets/home/restaurant-4.png",
      "name": "The Barbary",
      "address": "99C OBC Area",
      "rate": 4.5,
      "isFavorite": false
    },
    {
      "image": "assets/home/restaurant-5.png",
      "name": "The Palomor",
      "address": "31A Om Colony",
      "rate": 3.5,
      "isFavorite": false
    },
    {
      "image": "assets/home/restaurant-6.png",
      "name": "Hunger Spot",
      "address": "1124, Chruch Street",
      "rate": 4.0,
      "isFavorite": false
    },
    {
      "image": "assets/home/restaurant-7.png",
      "name": "Seven Star",
      "address": "76 A England Street",
      "rate": 5.0,
      "isFavorite": false
    },
    {
      "image": "assets/home/restaurant-8.png",
      "name": "King of Foods",
      "address": "76 A England Street",
      "rate": 4.5,
      "isFavorite": false
    },
    {
      "image": "assets/home/restaurant-9.png",
      "name": "Food Junction",
      "address": "76 A England Street",
      "rate": 3.5,
      "isFavorite": false
    },
  ];

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
          "Restaurantes Cercanos a Ti",
          style: bold18Black,
        ),
      ),
      body: nearestRestaurentListContent(context, size),
    );
  }

  Widget nearestRestaurentListContent(BuildContext context, Size size) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
          fixPadding * 2.0, fixPadding / 2, fixPadding * 2.0, fixPadding * 2.0),
      children: [
        Wrap(
          runSpacing: fixPadding * 1.5,
          spacing: fixPadding * 1.5,
          children: List.generate(
            restaurantNearYouList.length,
            (index) {
              final restaurantData = restaurantNearYouList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/restaurantDetail');
                },
                child: Container(
                  width: (size.width - 55) / 2,
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
                                restaurantData['image'].toString(),
                              ),
                              fit: BoxFit.cover),
                        ),
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              restaurantData['isFavorite'] =
                                  !(restaurantData['isFavorite'] as bool);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: blackColor,
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(milliseconds: 1500),
                                content: Text(
                                  restaurantData['isFavorite'] == true
                                      ? "Añadido a favoritos"
                                      : "Eliminado de favoritos",
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
                              restaurantData['isFavorite'] == true
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
                        restaurantData['name'].toString(),
                        style: semibold14Black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      heightBox(fixPadding * 0.3),
                      Text(
                        restaurantData['address'].toString(),
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
                          width5Space,
                          Expanded(
                            child: Text(
                              restaurantData['rate'].toString(),
                              style: medium12Black,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
