import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class CategoryFoodScreen extends StatefulWidget {
  const CategoryFoodScreen({super.key});

  @override
  State<CategoryFoodScreen> createState() => _CategoryFoodScreenState();
}

class _CategoryFoodScreenState extends State<CategoryFoodScreen> {
  final itemList = [
    {
      "image": "assets/food/food9.png",
      "name": "Pizza Doble Queso",
      "description": "Haz que esta temporada de parrilladas...",
      "rate": 4.5,
      "price": 8.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food10.png",
      "name": "Pizza Queso Clásico",
      "description": "Haz que esta temporada de parrilladas...",
      "rate": 4.0,
      "price": 7.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food11.png",
      "name": "Pizza Veggie",
      "description": "Haz que esta temporada de parrilladas...",
      "rate": 4.0,
      "price": 5.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food12.png",
      "name": "Pizza Margherita",
      "description": "Haz que esta temporada de parrilladas...",
      "rate": 5.0,
      "price": 8.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food13.png",
      "name": "Pizza Pepperoni",
      "description": "Haz que esta temporada de parrilladas...",
      "rate": 4.5,
      "price": 6.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food14.png",
      "name": "Masa de Pizza Sin Levadura",
      "description": "Haz que esta temporada de parrilladas...",
      "rate": 4.0,
      "price": 8.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food15.png",
      "name": "Pizza Paneer",
      "description": "Haz que esta temporada de parrilladas...",
      "rate": 4.5,
      "price": 5.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food16.png",
      "name": "Pizza Taco",
      "description": "Haz que esta temporada de parrilladas...",
      "rate": 5.0,
      "price": 9.30,
      "isFavorite": false,
    },
    {
      "image": "assets/food/food17.png",
      "name": "Pizza Aceituna Negra",
      "description": "Haz que esta temporada de parrilladas...",
      "rate": 3.5,
      "price": 8.30
    },
    {
      "image": "assets/food/food18.png",
      "name": "Pizza Blanca",
      "description": "Haz que esta temporada de parrilladas...",
      "rate": 4.0,
      "price": 5.00,
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
          "Pizza",
          style: bold18Black,
        ),
      ),
      body: foodListContent(context, size),
    );
  }

  Widget foodListContent(BuildContext context, Size size) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
          fixPadding * 2.0, fixPadding / 2, fixPadding * 2.0, fixPadding * 2.0),
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
    );
  }
}
