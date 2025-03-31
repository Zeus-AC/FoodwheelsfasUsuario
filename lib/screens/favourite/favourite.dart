import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final tabBarList = ["Comidas", "Restaurantes"];

  int selectedTabBar = 0;

  PageController pageController = PageController();

  final favouriteFoodList = [
    {
      "image": "assets/food/food19.png",
      "name": "Hamburguesa de Queso Clásica",
      "restaurant": "Restaurante Bar61",
      "rate": 5.0,
      "review": 200,
      "price": 10.00
    },
    {
      "image": "assets/foodDetail/food-image.png",
      "name": "Pizza Margarita",
      "restaurant": "Food Hunger",
      "rate": 4.0,
      "review": 200,
      "price": 12.00
    },
    {
      "image": "assets/food/food20.png",
      "name": "Sándwich Chutney",
      "restaurant": "Food Hunger",
      "rate": 4.0,
      "review": 200,
      "price": 8.00
    }
  ];

  final favouriteRestaurantList = [
    {
      "image": "assets/home/restaurant-7.png",
      "name": "Restaurante Marine Rise",
      "address": "76A England Street, Church Street...",
      "rate": 5.0,
      "review": 200,
    },
    {
      "image": "assets/home/restaurant-6.png",
      "name": "Restaurante Bar61",
      "address": "220 Opera Street, Inglaterra",
      "rate": 4.0,
      "review": 100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        elevation: 0.0,
        centerTitle: false,
        titleSpacing: 20.0,
        title: const Text(
          "Favoritos",
          style: bold18Black,
        ),
      ),
      body: Column(
        children: [
          tabBar(),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedTabBar = index;
                });
              },
              children: [
                favouriteFoodList.isEmpty
                    ? emptyListContent("No hay elementos en Comidas Favoritas")
                    : foodFavouriteListContent(size),
                favouriteRestaurantList.isEmpty
                    ? emptyListContent("No hay elementos en Restaurantes Favoritos")
                    : rastaurantFavouriteListContent(size),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rastaurantFavouriteListContent(Size size) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: fixPadding),
      itemCount: favouriteRestaurantList.length,
      itemBuilder: (context, index) {
        final itemData = favouriteRestaurantList[index];
        return Slidable(
          key: UniqueKey(),
          endActionPane: ActionPane(
            extentRatio: 0.15,
            motion: const ScrollMotion(),
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    favouriteRestaurantList.removeAt(index);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: blackColor,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(milliseconds: 1500),
                      content: Text(
                        "Eliminado de favoritos",
                        style: semibold16White,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: fixPadding),
                  width: size.width * 0.15,
                  decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/delete-icon.png",
                    height: 24.0,
                    width: 24.0,
                    fit: BoxFit.contain,
                    color: whiteColor,
                  ),
                ),
              )
            ],
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/restaurantDetail');
            },
            child: Container(
              padding: const EdgeInsets.all(fixPadding),
              margin: const EdgeInsets.symmetric(
                  vertical: fixPadding, horizontal: fixPadding * 2.0),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: boxShadow,
              ),
              child: Row(
                children: [
                  Container(
                    height: 68.0,
                    width: 68.0,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage(
                          itemData['image'].toString(),
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
                          itemData['name'].toString(),
                          style: medium16Black,
                          overflow: TextOverflow.ellipsis,
                        ),
                        height5Space,
                        Text(
                          itemData['address'].toString(),
                          style: medium14Grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                        height5Space,
                        Row(
                          children: [
                            const Icon(
                              Icons.grade_rounded,
                              color: yellowColor,
                              size: 17.0,
                            ),
                            width5Space,
                            Expanded(
                              child: Text(
                                "${itemData['rate']} (${itemData['review']})",
                                style: medium14Black,
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
            ),
          ),
        );
      },
    );
  }

  Widget emptyListContent(String text) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          Center(
            child: Image.asset(
              "assets/icons/empty-favorites.png",
              height: 65.0,
              fit: BoxFit.cover,
            ),
          ),
          heightSpace,
          height5Space,
          Text(
            text,
            style: bold18Grey,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget foodFavouriteListContent(Size size) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: fixPadding),
      itemCount: favouriteFoodList.length,
      itemBuilder: (context, index) {
        final itemData = favouriteFoodList[index];
        return Slidable(
          key: UniqueKey(),
          endActionPane: ActionPane(
            extentRatio: 0.15,
            motion: const ScrollMotion(),
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    favouriteFoodList.removeAt(index);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: blackColor,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(milliseconds: 1500),
                      content: Text(
                        "Eliminado de favoritos",
                        style: semibold16White,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: fixPadding),
                  width: size.width * 0.15,
                  decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/delete-icon.png",
                    height: 24.0,
                    width: 24.0,
                    fit: BoxFit.contain,
                    color: whiteColor,
                  ),
                ),
              )
            ],
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/foodDetail');
            },
            child: Container(
              padding: const EdgeInsets.all(fixPadding),
              margin: const EdgeInsets.symmetric(
                  vertical: fixPadding, horizontal: fixPadding * 2.0),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: boxShadow,
              ),
              child: Row(
                children: [
                  Container(
                    height: 68.0,
                    width: 68.0,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage(
                          itemData['image'].toString(),
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
                          itemData['name'].toString(),
                          style: medium16Black,
                          overflow: TextOverflow.ellipsis,
                        ),
                        height5Space,
                        Text(
                          itemData['restaurant'].toString(),
                          style: medium14Grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                        height5Space,
                        Row(
                          children: [
                            const Icon(
                              Icons.grade_rounded,
                              color: yellowColor,
                              size: 17.0,
                            ),
                            width5Space,
                            Expanded(
                              child: Text(
                                "${itemData['rate']} (${itemData['review']})",
                                style: medium14Black,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            width5Space,
                            Text(
                              "\$${(itemData['price'] as double).toStringAsFixed(2)}",
                              style: bold16Primary,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget tabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding, vertical: fixPadding * 1.5),
      width: double.maxFinite,
      color: recColor,
      child: Row(
        children: List.generate(
          tabBarList.length,
          (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTabBar = index;
                    pageController.jumpToPage(selectedTabBar);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: fixPadding),
                  padding: const EdgeInsets.all(fixPadding * 0.8),
                  decoration: BoxDecoration(
                    color: selectedTabBar == index ? primaryColor : whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    tabBarList[index].toString(),
                    style: selectedTabBar == index
                        ? semibold16White
                        : semibold16Black,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
