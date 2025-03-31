import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:pn_fl_foody_user/screens/screens.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
        title: const Text(
          "Perfil",
          style: bold18Black,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding / 2,
            fixPadding * 2.0, fixPadding * 4.0),
        children: [
          userInfo(),
          heightSpace,
          heightSpace,
          optionWidget(Mdi.bell, "Notificaciones", () {
            Navigator.pushNamed(context, '/notification');
          }),
          heightSpace,
          heightSpace,
          optionWidget(Heroicons.map_pin_solid, "Dirección", () {
            Navigator.pushNamed(context, '/address');
          }),
          heightSpace,
          heightSpace,
          optionWidget(Majesticons.creditcard, "Métodos de Pago", () {
            Navigator.pushNamed(context, '/paymentMethod', arguments: 1);
          }),
          heightSpace,
          heightSpace,
          optionWidget(Ion.heart_sharp, "Favoritos", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomBar(index: 1),
              ),
            );
          }),
          heightSpace,
          heightSpace,
          optionWidget(MaterialSymbols.settings, "Configuraciones", () {
            Navigator.pushNamed(context, '/settings');
          }),
          heightSpace,
          heightSpace,
          optionWidget(Ion.document_text, "Términos y Condiciones", () {
            Navigator.pushNamed(context, '/termsAndCondition');
          }),
          heightSpace,
          heightSpace,
          optionWidget(IconParkSolid.info, "Política de Privacidad", () {
            Navigator.pushNamed(context, '/privacyPolicy');
          }),
          heightSpace,
          heightSpace,
          optionWidget(Ic.baseline_headphones, "Ayuda y Soporte", () {
            Navigator.pushNamed(context, '/helpAndSupport');
          }),
          heightSpace,
          heightSpace,
          optionWidget(Majesticons.logout, "Cerrar sesión", () {
            logoutDialog(context);
          }),
        ],
      ),
    );
  }

  Future<dynamic> logoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.hardEdge,
          insetPadding: const EdgeInsets.all(fixPadding * 2.0),
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/profile/logout.png",
                        height: 57.0,
                        width: 57.0,
                      ),
                    ),
                    heightSpace,
                    const Text(
                      "¿Estás seguro de que deseas cerrar sesión?",
                      style: semibold18Black,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(fixPadding * 1.1),
                        width: double.maxFinite,
                        color: primaryColor,
                        alignment: Alignment.center,
                        child: const Text(
                          "Cancelar",
                          style: bold18White,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  widthBox(fixPadding * 0.3),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/signin', (route) => false);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(fixPadding * 1.1),
                        width: double.maxFinite,
                        color: primaryColor,
                        alignment: Alignment.center,
                        child: const Text(
                          "Cerrar sesión",
                          style: bold18White,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget optionWidget(String icon, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(fixPadding),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: boxShadow,
        ),
        child: Row(
          children: [
            Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: Iconify(
                icon,
                size: 20.0,
                color: primaryColor,
              ),
            ),
            widthSpace,
            Expanded(
              child: Text(
                title,
                style: semibold14Black,
              ),
            ),
            widthSpace,
            const Icon(
              Icons.arrow_forward_ios,
              color: blackColor,
              size: 16.0,
            )
          ],
        ),
      ),
    );
  }

  Widget userInfo() {
    return Row(
      children: [
        Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: const DecorationImage(
              image: AssetImage("assets/profile/user-image.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        widthSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Perry Piterson",
                style: semibold16Black,
                overflow: TextOverflow.ellipsis,
              ),
              heightBox(3.0),
              const Text(
                "+91 9758462548",
                style: medium14Grey,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        widthSpace,
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/editProfile');
          },
          child: Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            alignment: Alignment.center,
            child: const Iconify(
              MaterialSymbols.edit_rounded,
              color: whiteColor,
              size: 20.0,
            ),
          ),
        )
      ],
    );
  }
}
