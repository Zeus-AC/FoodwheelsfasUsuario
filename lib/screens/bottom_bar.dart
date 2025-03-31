import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:pn_fl_foody_user/screens/screens.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, this.index});

  final int? index;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  DateTime? backPressTime;

  int selectedIndex = 2;

  final pagesList = const [
    OrdersScreen(),
    FavouriteScreen(),
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    setState(() {
      selectedIndex = widget.index ?? 2;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        bool backStatus = onPopScope();
        if (backStatus) {
          exit(0);
        }
      },
      child: Scaffold(
        body: pagesList.elementAt(selectedIndex),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: homeItemWidget(),
        bottomNavigationBar: bottomBar(context),
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: BottomNavigationBar(
        onTap: (index) {
          if (index != 2) {
            setState(() {
              selectedIndex = index;
            });
          }
        },
        currentIndex: selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: whiteColor,
        items: [
          iconItemWidget(Mdi.list_box),
          iconItemWidget(Ic.sharp_favorite),
          const BottomNavigationBarItem(icon: SizedBox(), label: ""),
          imageItemWidget("assets/icons/cart.png"),
          imageItemWidget("assets/icons/user.png", size: 23.0)
        ],
      ),
    );
  }

  Widget homeItemWidget() {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = 2;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(fixPadding * 0.3),
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: boxShadow,
          shape: BoxShape.circle,
        ),
        child: Container(
          height: 50.0,
          width: 50.0,
          decoration: const BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Iconify(
            Mdi.cook,
            color: whiteColor,
            size: 25.0,
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem imageItemWidget(String icon, {double size = 26.0}) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        color: greyColor,
        height: size,
        fit: BoxFit.cover,
      ),
      activeIcon: Image.asset(
        icon,
        color: primaryColor,
        height: size,
        fit: BoxFit.cover,
      ),
      label: "",
    );
  }

  BottomNavigationBarItem iconItemWidget(String icon) {
    return BottomNavigationBarItem(
        icon: Iconify(
          icon,
          color: greyColor,
          size: 26.0,
        ),
        activeIcon: Iconify(
          icon,
          color: primaryColor,
          size: 26.0,
        ),
        label: "");
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
            "Press back once again to exit",
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
