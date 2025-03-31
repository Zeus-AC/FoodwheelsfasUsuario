import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/screens/bottom_bar.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';
import 'package:pn_fl_foody_user/widget/column_builder.dart';
import 'package:readmore/readmore.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({super.key});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  bool isFavorite = false;

  final double price = 8.10;
  double totalPrice = 0.0;

  int totalItem = 2;

  final sizeList = ["Pequeño", "Mediano", "Grande", "Extra Grande"];
  int selectedSize = 1;

  final optionList = [
    {"title": "Queso extra", "isSelected": false},
    {"title": "Mayonesa extra", "isSelected": true},
    {"title": "Verduras extra", "isSelected": false},
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          header(size, context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(fixPadding * 2.0,
                      fixPadding * 2.0, fixPadding * 2.0, fixPadding * 1.25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      foodInfo(),
                      heightSpace,
                      heightSpace,
                      description(),
                      heightSpace,
                      heightSpace,
                      selectSize(),
                      heightSpace,
                      height5Space,
                      selectOptions(),
                      heightSpace,
                      height5Space,
                      reviews()
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: addToCart(),
    );
  }

  Widget addToCart() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding * 1.5),
      width: double.maxFinite,
      color: primaryColor,
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$totalItem Item (\$${(price * totalItem).toStringAsFixed(2)})",
              style: extrabold16White,
            ),
          ),
          widthSpace,
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomBar(index: 3),
                  ));
            },
            child: const Text(
              "Agregar al carrito",
              style: extrabold18White,
            ),
          )
        ],
      ),
    );
  }

  Widget reviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                "Reseñas",
                style: bold16Black,
              ),
            ),
            widthSpace,
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/reviews');
              },
              child: const Text(
                "Ver todas",
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
    );
  }
   Widget selectOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Seleccionar Opciones",
          style: bold16Black,
        ),
        heightSpace,
        ColumnBuilder(
          itemBuilder: (context, index) {
            final options = optionList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    options['isSelected'] = !(options['isSelected'] as bool);
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 20.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: options['isSelected'] == true
                            ? Border.all(color: primaryColor, width: 6.0)
                            : Border.all(color: greyD9Color),
                      ),
                    ),
                    widthSpace,
                    Expanded(
                      child: Text(
                        options['title'].toString(),
                        style: medium14Black,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: optionList.length,
        ),
      ],
    );
  }

  Widget selectSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Seleccionar Tamaño",
          style: bold16Black,
        ),
        heightSpace,
        ColumnBuilder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    selectedSize = index;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 20.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: selectedSize == index
                            ? Border.all(color: primaryColor, width: 6.0)
                            : Border.all(color: greyD9Color),
                      ),
                    ),
                    widthSpace,
                    Expanded(
                      child: Text(
                        sizeList[index].toString(),
                        style: medium14Black,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: sizeList.length,
        ),
      ],
    );
  }
    Widget description() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Descripción",
          style: bold16Black,
        ),
        heightSpace,
        ReadMoreText(
          "Lorem ipsum dolor sit amet consectetur. Non feugiat lorem at pulvinar leo cursus. Ipsum mattis odiosectus iaculis convallis hac sit in fames. Tristique aliqmattis lgravida ipsum. Lorem ipsum dolor sit amconsectetur. Non feugiat lorem at pulvinar leo cursus. ",
          style: medium14Grey,
          trimExpandedText: "Mostrar menos",
          trimCollapsedText: "Leer más",
          lessStyle: bold14Primary,
          moreStyle: bold14Primary,
        )
      ],
    );
  }

  Widget foodInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Expanded(
              child: Text(
                "Pizza Margherita",
                style: bold18Black,
              ),
            ),
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
        const Text(
          "Estos ingredientes incluyen salsa de tomate roja, mozzarella blanca y albahaca verde fresca.",
          style: medium16Grey,
        ),
        heightSpace,
        Row(
          children: [
            Expanded(
              child: Text(
                "\$${price.toStringAsFixed(2)}",
                style: semibold16Black,
              ),
            ),
            widthSpace,
            GestureDetector(
              onTap: () {
                if (totalItem > 1) {
                  setState(() {
                    totalItem--;
                  });
                }
              },
              child: Container(
                height: 28.0,
                width: 28.0,
                decoration: BoxDecoration(
                  color: greyD9Color,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.remove,
                  color: blackColor,
                  size: 22.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: fixPadding),
              child: Text(
                "$totalItem",
                style: semibold16Black,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  totalItem++;
                });
              },
              child: Container(
                height: 28.0,
                width: 28.0,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.add,
                  color: whiteColor,
                  size: 22.0,
                ),
              ),
            )
          ],
        )
      ],
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
          "assets/foodDetail/food-image.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  headerIcons(BuildContext context) {
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
                            ? "Añadido a favoritos"
                            : "Eliminado de favoritos",
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
