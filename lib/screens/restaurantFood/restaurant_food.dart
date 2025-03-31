import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class RestaurantFoodScreen extends StatefulWidget {
  const RestaurantFoodScreen({super.key});

  @override
  State<RestaurantFoodScreen> createState() => _RestaurantFoodScreenState();
}

class _RestaurantFoodScreenState extends State<RestaurantFoodScreen> {
  final foodCategoryList = [
    "Comida Rápida",
    "Postre",
    "Entrante",
    "Ensalada",
    "Bebida",
    "Plato Principal"
  ];

  int selectedFoodCategory = 0;

  final itemList = [
    {
      "image": "assets/food/food21.png",
      "name": "Tostada de Aguacate",
      "description": "Haz de esta temporada de parrilladas... ",
      "rate": 4.5,
      "price": 8.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food10.png",
      "name": "Pizza Clásica de Queso",
      "description": "Haz de esta temporada de parrilladas... ",
      "rate": 4.0,
      "price": 7.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food11.png",
      "name": "Pizza Vegetariana",
      "description": "Haz de esta temporada de parrilladas... ",
      "rate": 4.0,
      "price": 5.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food12.png",
      "name": "Pizza Margherita",
      "description": "Haz de esta temporada de parrilladas... ",
      "rate": 5.0,
      "price": 8.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food20.png",
      "name": "Sándwich de Chutney",
      "description": "Haz de esta temporada de parrilladas... ",
      "rate": 4.5,
      "price": 6.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food14.png",
      "name": "Masa para Pizza sin Levadura",
      "description": "Haz de esta temporada de parrilladas... ",
      "rate": 4.0,
      "price": 8.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food15.png",
      "name": "Pizza de Paneer",
      "description": "Haz de esta temporada de parrilladas... ",
      "rate": 4.5,
      "price": 5.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food19.png",
      "name": "Hamburguesa Clásica con Queso",
      "description": "Haz de esta temporada de parrilladas... ",
      "rate": 5.0,
      "price": 9.30,
      "isFavorite": false,
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
          "Restaurante Bar 61",
          style: bold18Black,
        ),
      ),
      body: Column(
        children: [
          foodCategoryListContent(),
          heightSpace,
          heightSpace,
          foodListContent(context, size)
        ],
      ),
    );
  }

  Widget foodListContent(BuildContext context, Size size) {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding * 2.0),
        children: [
          Wrap(
            runSpacing: fixPadding * 1.5,
            spacing: fixPadding * 1.5,
            children: List.generate(
              itemList.length,
              (index) {
                final itemData = itemList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/foodDetail');
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
                                  itemData['image'].toString(),
                                ),
                                fit: BoxFit.cover),
                          ),
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                itemData['isFavorite'] =
                                    !(itemData['isFavorite'] as bool);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: blackColor,
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(milliseconds: 1500),
                                  content: Text(
                                    itemData['isFavorite'] == true
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
                                itemData['isFavorite'] == true
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
                          itemData['name'].toString(),
                          style: semibold14Black,
                          overflow: TextOverflow.ellipsis,
                        ),
                        heightBox(fixPadding * 0.3),
                        Text(
                          itemData['description'].toString(),
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
                                itemData['rate'].toString(),
                                style: medium12Black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            width5Space,
                            Text(
                              "\$${(itemData['price'] as double).toStringAsFixed(2)}",
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
        ],
      ),
    );
  }

  Widget foodCategoryListContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
      child: Row(
        children: List.generate(
          foodCategoryList.length,
          (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedFoodCategory = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 1.5, vertical: fixPadding / 2),
                margin: const EdgeInsets.symmetric(horizontal: fixPadding / 2),
                decoration: BoxDecoration(
                  color:
                      selectedFoodCategory == index ? primaryColor : recColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  foodCategoryList[index].toString(),
                  style: selectedFoodCategory == index
                      ? bold14White
                      : medium14Black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
