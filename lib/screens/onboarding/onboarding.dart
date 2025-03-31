import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboarding/onboarding.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentSelectedPage = 0;

  DateTime? backPressTime;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final bodyList = <Widget>[
      pageWidget(
          size,
          "assets/onboarding/image-1.png",
          "Busca tu comida favorita\ncerca de ti",
          "Descubre platillos de los mejores\n restaurantes de Tezontepec de Aldama."),
      pageWidget(
          size,
          "assets/onboarding/image-2.png",
          "Entrega rápida en\ntu ubicación",
          "Entrega rápida a tu casa,\noficina o donde estés."),
      pageWidget(
          size,
          "assets/onboarding/image-3.png",
          "Rastrea tu repartidor\nen el mapa",
          "Encuentra fácilmente tus platillos\nutilizando la ubicación en el mapa."),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        bool backStatus = onPopScope();
        if (backStatus) {
          exit(0);
        }
      },
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarColor: primaryColor,
            statusBarIconBrightness: Brightness.light),
        child: Scaffold(
          backgroundColor: primaryColor,
          body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(25.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            onboardingContent(bodyList),
                            pageIndicator(size, bodyList)
                          ],
                        ),
                      ),
                    ),
                    signupAndSigninButtons()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget onboardingContent(List<Widget> bodyList) {
    return Onboarding(
      swipeableBody: bodyList,
      startIndex: currentSelectedPage,
      onPageChanges:
          (netDragDistance, pagesLength, currentIndex, slideDirection) {
        setState(() {
          currentSelectedPage = currentIndex;
        });
      },
    );
  }

  Widget pageIndicator(Size size, List<Widget> bodyList) {
    return Positioned(
      left: 0,
      right: 0,
      top: (size.height * 0.52),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          bodyList.length,
          (index) {
            return Container(
              height: 10.0,
              width: 10.0,
              margin: const EdgeInsets.symmetric(horizontal: fixPadding / 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    currentSelectedPage == index ? primaryColor : greyD9Color,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget pageWidget(Size size, String image, String title, String description) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: fixPadding * 5.0),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              image,
              height: size.height * 0.35,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: bold22Black.copyWith(height: 1.2),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                heightSpace,
                height5Space,
                Text(
                  description,
                  style: medium15Grey,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget signupAndSigninButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding * 3.3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Container(
                height: 50.0,
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: whiteColor),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Registrarse",
                  style: bold20White.copyWith(height: 1.5),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signin');
              },
              child: Container(
                height: 50.0,
                padding:
                    const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: whiteColor),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Iniciar sesión",
                  style: bold20Primary.copyWith(height: 1.5),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  onPopScope() {
    DateTime now = DateTime.now();
    if (backPressTime == null ||
        now.difference(backPressTime!) >= const Duration(seconds: 2)) {
      backPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: blackColor,
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1500),
          content: Text(
            "Presiona atrás nuevamente para salir",
            style: semibold16White,
          ),
        ),
      );
      return false;
    } else {
      return true;
    }
  }
}