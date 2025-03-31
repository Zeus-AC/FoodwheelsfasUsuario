import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/pepicons.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int selectedRate = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: whiteColor,
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
          "Valoración",
          style: bold18Black,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding / 2,
            fixPadding * 2.0, fixPadding * 2.0),
        children: [
          itemInfo(),
          heightSpace,
          heightSpace,
          ratingContent(),
        ],
      ),
      bottomNavigationBar: submitButton(context),
    );
  }

  Widget submitButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.3),
        width: double.maxFinite,
        color: primaryColor,
        child: const Text(
          "Enviar",
          style: bold18White,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget ratingContent() {
    return Container(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "¿Qué opinas sobre este restaurante?",
            style: semibold18Black,
            textAlign: TextAlign.center,
          ),
          heightSpace,
          const Text(
            "Tus comentarios nos ayudarán a mejorar la experiencia en el restaurante.",
            style: medium14Grey,
            textAlign: TextAlign.center,
          ),
          heightSpace,
          heightSpace,
          height5Space,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding / 2),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRate = index;
                      });
                    },
                    child: Iconify(
                      Pepicons.star_filled,
                      color: selectedRate >= index ? yellowColor : greyD9Color,
                      size: 30.0,
                    ),
                  ),
                );
              },
            ),
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          Container(
            height: 100.0,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: boxShadow,
            ),
            child: const TextField(
              textAlignVertical: TextAlignVertical.top,
              expands: true,
              minLines: null,
              maxLines: null,
              style: medium14Black,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Escribe tu comentario aquí",
                hintStyle: medium14Grey,
                contentPadding: EdgeInsets.all(fixPadding),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget itemInfo() {
    return Container(
      padding: const EdgeInsets.all(fixPadding),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: boxShadow,
      ),
      child: Row(
        children: [
          Container(
            height: 65.0,
            width: 65.0,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage("assets/home/restaurant-6.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          widthSpace,
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Restaurante Marine Rise",
                  style: semibold16Black,
                  overflow: TextOverflow.ellipsis,
                ),
                height5Space,
                Text(
                  "76A England Street, Church Street...",
                  style: medium14Grey,
                  overflow: TextOverflow.ellipsis,
                ),
                height5Space,
                Row(
                  children: [
                    Icon(
                      Icons.grade_rounded,
                      color: yellowColor,
                      size: 17.0,
                    ),
                    width5Space,
                    Expanded(
                      child: Text(
                        "5.0 (200)",
                        style: medium14Black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
