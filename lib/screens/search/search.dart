import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';
import 'package:pn_fl_foody_user/widget/column_builder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final recentTransactionList = [
    "Pizza de pan",
    "Pasta Scampi de pollo",
    "Té mixto",
    "Pastel de lava",
    "Hamburguesa con queso"
  ];

  final recommendedList = [
    {
      "image": "assets/home/restaurant-3.png",
      "title": "Restaurante Bar 61",
      "isRestaurant": true,
    },
    {
      "image": "assets/food/food3.png",
      "title": "Pastel de lava de chocolate",
      "isRestaurant": false,
    },
    {
      "image": "assets/food/food8.png",
      "title": "Pizza siete quesos",
      "isRestaurant": false,
    },
    {
      "image": "assets/home/restaurant-5.png",
      "title": "La Fountain",
      "isRestaurant": true,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.west,
            color: blackColor,
          ),
        ),
      ),
      body: Column(
        children: [
          searchField(),
          recommended(),
        ],
      ),
    );
  }

  Widget recommended() {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding * 1.25),
        children: [
          recentTransactionList.isEmpty
              ? const SizedBox()
              : recentSearchesListContent(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recomendado",
                style: bold16Black,
              ),
              heightBox(fixPadding * 0.75),
              ColumnBuilder(
                itemBuilder: (context, index) {
                  final recommendedData = recommendedList[index];
                  return InkWell(
                    onTap: () {
                      recommendedData['isRestaurant'] == true
                          ? Navigator.pushNamed(context, '/restaurantDetail')
                          : Navigator.pushNamed(context, '/foodDetail');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: fixPadding * 0.75),
                      child: Row(
                        children: [
                          Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage(
                                  recommendedData['image'].toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          widthSpace,
                          Expanded(
                            child: Text(
                              recommendedData['title'].toString(),
                              style: medium16Black,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: recommendedList.length,
              )
            ],
          )
        ],
      ),
    );
  }

  recentSearchesListContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                "Búsquedas recientes",
                style: bold16Black,
              ),
            ),
            widthSpace,
            InkWell(
              onTap: () {
                setState(() {
                  recentTransactionList.clear();
                });
              },
              child: const Text(
                "Limpiar todo",
                style: bold12Primary,
              ),
            )
          ],
        ),
        heightBox(fixPadding * 0.75),
        ColumnBuilder(
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: fixPadding * 0.75),
                child: Row(
                  children: [
                    const Icon(
                      Icons.history,
                      color: greyColor,
                      size: 22.0,
                    ),
                    widthSpace,
                    Expanded(
                      child: Text(
                        recentTransactionList[index].toString(),
                        style: medium16Grey,
                      ),
                    ),
                    widthSpace,
                    InkWell(
                      onTap: () {
                        setState(() {
                          recentTransactionList.removeAt(index);
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        color: greyColor,
                        size: 22.0,
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: recentTransactionList.length),
        heightBox(fixPadding * 1.25)
      ],
    );
  }

  searchField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
          fixPadding * 2.0, fixPadding / 2, fixPadding * 2.0, fixPadding),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: recColor, borderRadius: BorderRadius.circular(10.0)),
      child: const TextField(
        cursorColor: primaryColor,
        style: semibold16Black33,
        decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: "Busca tus antojos...",
            hintStyle: semibold16Grey,
            prefixIconConstraints:
                BoxConstraints(maxHeight: 45.0, minWidth: 45.0),
            prefixIcon: Icon(
              Icons.search,
              size: 24.0,
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: fixPadding * 1.1, horizontal: fixPadding)),
      ),
    );
  }
}
