import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   String _username = ""; // Valor por defecto
  int currentPosterIndex = 0;
  
@override
  void initState() {
  super.initState();
  _loadUserData(); // Llamamos a la función aquí
}

  
  void _loadUserData() async {
    
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    // Obtener el nombre de usuario desde Firestore
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    String username = snapshot['username'];  // Asegúrate de que el campo 'username' exista en Firestore
    
    setState(() {
      _username = username;
    });
  }
}

final categoriesList = [
  {"image": "assets/home/category1.png", "title": "Hamburguesas"},
  {"image": "assets/home/category2.png", "title": "Pizzas"},
  {"image": "assets/home/category3.png", "title": "Antojitos"},
  {"image": "assets/home/category4.png", "title": "Pollos asados"},
  {"image": "assets/home/category5.png", "title": "Ensaladas"},
  {"image": "assets/home/category6.png", "title": "Postres"},
  {"image": "assets/home/category8.png", "title": "Bebidas"},
];


  final recommendedList = [
    {
      "image": "assets/food/food1.png",
      "name": "Hamburguesa en el Plato",
      "description": "Haz de esta temporada de parrilladas... ",
      "rate": 4.5,
      "price": 8.30,
      "isFavorite": false
    },
    {
      "image": "assets/food/food2.png",
      "name": "Mejores Acompañamientos para Hamburguesa",
      "description": "Haz de esta temporada de parrilladas... ",
      "rate": 4.0,
      "price": 10.30,
      "isFavorite": false
    },
    {
      "image": "assets/food/food3.png",
      "name": "Pizza con Extra Queso",
      "description": "Haz de esta temporada de parrilladas... ",
      "rate": 5.0,
      "price": 10.30,
      "isFavorite": false
    },
    {
      "image": "assets/food/food4.png",
      "name": "Pizza de Pepperoni",
      "description": "Haz de esta temporada de parrilladas... ",
      "rate": 4.0,
      "price": 6.30,
      "isFavorite": false
    },
];

final restaurantNearYouList = [
    {
      "image": "assets/home/restaurant-1.png",
      "name": "Restaurante Bar 61",
      "address": "76 A Calle Inglaterra",
      "rate": 4.5,
      "isFavorite": false
    },
    {
      "image": "assets/home/restaurant-2.png",
      "name": "Salón Amrutha",
      "address": "99B Silicon Valley",
      "rate": 5.0,
      "isFavorite": false
    },
    {
      "image": "assets/home/restaurant-3.png",
      "name": "Core de Clare",
      "address": "220 Calle Ópera",
      "rate": 4.0,
      "isFavorite": false
    },
    {
      "image": "assets/home/restaurant-4.png",
      "name": "El Barbary",
      "address": "99C Área OBC",
      "rate": 4.5,
      "isFavorite": false
    },
    {
      "image": "assets/home/restaurant-5.png",
      "name": "El Palomor",
      "address": "31A Colonia Om",
      "rate": 3.5,
      "isFavorite": false
    },
];

final productOrderedList = [
    {
      "image": "assets/food/food5.png",
      "name": "Pollo con calabaza...",
      "category": "Pollo",
    },
    {
      "image": "assets/food/food6.png",
      "name": "Plato de comida india",
      "category": "Comida India",
    },
    {
      "image": "assets/food/food7.png",
      "name": "Paquete Combo",
      "category": "Hamburguesa",
    },
    {
      "image": "assets/food/food8.png",
      "name": "Pastel de Lava de Chocolate",
      "category": "Postre",
    },
];


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.0,
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
        titleSpacing: 20.0,
        title: headerTitle(),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: fixPadding * 3.0),
        children: [
          searchBox(),
          heightSpace,
          heightSpace,
          banners(size),
          heightSpace,
          heightSpace,
          category(),
          heightSpace,
          recommendedForUserListContent(),
          heightSpace,
          restaurantNearUserListContent(),
          heightSpace,
          productOrderedListContent()
        ],
      ),
    );
  }

  Widget productOrderedListContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title("Productos Ordenados", () {}),
      height5Space,
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            productOrderedList.length,
            (index) {
              final orderedItem = productOrderedList[index];
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
                      imageWidget(orderedItem, () {}),
                      heightSpace,
                      Text(
                        orderedItem['name'].toString(),
                        style: semibold16Black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      heightBox(fixPadding * 0.3),
                      Text(
                        orderedItem['category'].toString(),
                        style: medium12Grey,
                        overflow: TextOverflow.ellipsis,
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


  Widget restaurantNearUserListContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title("Restaurantes Cerca de Ti", () {
        Navigator.pushNamed(context, '/nearestRestaurant');
      }),
      height5Space,
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            restaurantNearYouList.length,
            (index) {
              final restaurantData = restaurantNearYouList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/restaurantDetail');
                },
                child: Container(
                  width: 160.0,
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
                      imageWidget(restaurantData, () {
                        setState(() {
                          restaurantData['isFavorite'] =
                              !(restaurantData['isFavorite'] as bool);
                        });
                      }),
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
        ),
      )
    ],
  );
}


  Widget recommendedForUserListContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title("Recomendado Para Ti", () {}),
      height5Space,
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            recommendedList.length,
            (index) {
              final recommendedItemData = recommendedList[index];

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
                      imageWidget(
                        recommendedItemData,
                        () {
                          setState(() {
                            recommendedItemData['isFavorite'] =
                                !(recommendedItemData['isFavorite'] as bool);
                          });
                        },
                      ),
                      heightSpace,
                      Text(
                        recommendedItemData['name'].toString(),
                        style: semibold14Black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      heightBox(fixPadding * 0.3),
                      Text(
                        recommendedItemData['description'].toString(),
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
                              recommendedItemData['rate'].toString(),
                              style: medium12Black,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          width5Space,
                          Text(
                            "\$${(recommendedItemData['price'] as double).toStringAsFixed(2)}",
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


 Widget imageWidget(Map<String, Object> itemData, Function() onTap) {
  return Container(
    padding: const EdgeInsets.all(fixPadding * 0.5),
    height: 78.0,
    width: double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      image: DecorationImage(
        image: AssetImage(
          itemData['image'].toString(),
        ),
        fit: BoxFit.cover,
      ),
    ),
    alignment: Alignment.topRight,
    child: GestureDetector(
      onTap: () {
        onTap();
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
  );
}


  Widget category() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Text(
            "Categoria",
            style: bold16Black,
          ),
        ),
        height5Space,
        SingleChildScrollView(
          padding: const EdgeInsets.all(fixPadding),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              categoriesList.length,
              (index) {
                final categoryData = categoriesList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/categoryWiseFood');
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            color: recColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            categoryData['image'].toString(),
                            height: 50.0,
                            width: 50.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        height5Space,
                        Text(
                          categoryData['title'].toString(),
                          style: semibold14Black,
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

  Widget title(String text, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: bold16Black,
            ),
          ),
          widthSpace,
          InkWell(
            onTap: onTap,
            child: const Text(
              "Ver más",
              style: bold12Primary,
            ),
          )
        ],
      ),
    );
  }

  Widget banners(Size size) {
    return Column(
      children: [
        CarouselSlider(
          items: [
            banner1(),
            banner2(size),
            banner3(size),
          ],
          options: CarouselOptions(
            autoPlay: true,
            height: 150,
            viewportFraction: 1.0,
            initialPage: currentPosterIndex,
            onPageChanged: (index, reason) {
              setState(() {
                currentPosterIndex = index;
              });
            },
          ),
        ),
        heightSpace,
        heightSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: fixPadding / 4),
                height: 8.0,
                width: currentPosterIndex == index ? 25.0 : 8.0,
                decoration: BoxDecoration(
                  color:
                      currentPosterIndex == index ? primaryColor : greyD9Color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget banner3(Size size) {
    return Container(
      padding: EdgeInsets.only(right: size.width * 0.13),
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: const DecorationImage(
          image: AssetImage("assets/home/banner3.png"),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "El sabor que buscas, al mejor precio.",
            style: extrabold28White.copyWith(height: 1.2),
            textAlign: TextAlign.center,
          ),
          heightSpace,
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 2.0, vertical: fixPadding * 0.6),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(5.0)),
            child: const Text(
              "Comprar ahora",
              style: extrabold16White,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget banner2(Size size) {
    return Container(
      padding: EdgeInsets.only(left: size.width * 0.12),
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: const DecorationImage(
          image: AssetImage("assets/home/banner2.png"),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
          "Menú de comida\ndeliciosa",
            style: extrabold28White.copyWith(height: 1.2),
            textAlign: TextAlign.center,
          ),
          heightSpace,
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 2.0, vertical: fixPadding * 0.6),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(5.0)),
            child: const Text(
              "Ordenala ya",
              style: extrabold16White,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget banner1() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 3.0),
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: const DecorationImage(
          image: AssetImage("assets/home/banner1.png"),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.centerRight,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Platillos con los\nmejores ingredientes",
            style: extrabold30White,
          ),
          height5Space,
          Text(
            "Pruebalos ya",
            style: medium16White,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget searchBox() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/search');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        padding: const EdgeInsets.all(fixPadding),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: recColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.search,
              color: greyColor,
              size: 24.0,
            ),
            widthSpace,
            Expanded(
              child: Text(
                "Busca tus antojos...",
                style: semibold16Grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget headerTitle() {
    return Row(
      children: [
        Container(
          height: 45.0,
          width: 45.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: const DecorationImage(
              image: AssetImage("assets/profile/user-image.png"),
            ),
          ),
        ),
        widthSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hola $_username",
                style: bold16Black,
                overflow: TextOverflow.ellipsis,
              ),
              heightBox(2),
              const Text(
                "Bienvenid@",
                style: medium14Grey,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        widthSpace,
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/notification');
          },
          child: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: whiteColor,
              boxShadow: boxShadow,
            ),
            alignment: Alignment.center,
            child: const Iconify(
              Ep.bell_filled,
              color: primaryColor,
              size: 22.0,
            ),
          ),
        )
      ],
    );
  }
}
