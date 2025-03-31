import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';
import 'package:pn_fl_foody_user/widget/column_builder.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final notificationList = [
    {
      "title": "Nuevas Notificaciones",
      "list": [
        {
          "title": "Tu comida ha sido entregada",
          "message": "¡Hurra! Tu comida ha sido entregada. Disfruta de tu comida.",
          "isFoodNotification": true
        },
        {
          "title": "¡Califica el restaurante!",
          "message": "¡Por favor califica el restaurante para mejorar nuestros servicios!",
          "isFoodNotification": false
        },
        {
          "title": "¡Nueva oferta disponible!",
          "message": "¡Hurra! Revisa las ofertas de comida y disfruta de las mejores ofertas.",
          "isFoodNotification": false
        },
      ]
    },
    {
      "title": "Notificaciones antiguas",
      "list": [
        {
          "title": "Tu comida ha sido entregada",
          "message": "¡Hurra! Tu comida ha sido entregada. Disfruta de tu comida.",
          "isFoodNotification": true
        },
        {
          "title": "Tu pedido fue realizado con éxito..",
          "message": "¡Hurra! Tu comida ha sido entregada en poco tiempo. Disfruta de tu comida.",
          "isFoodNotification": true
        },
        {
          "title": "Gracias por ordenar...",
          "message": "Gracias por pedir comida usando esta app. Que tengas un buen día.",
          "isFoodNotification": true
        },
        {
          "title": "¡Pago fallido!...",
          "message": "¡Vaya! Algo salió mal, tu pago ha fallado...",
          "isFoodNotification": true
        },
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        centerTitle: false,
        titleSpacing: 0.0,
        elevation: 0.0,
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
          "Notificaciones",
          style: bold18Black,
        ),
      ),
      body: notificationList.isEmpty
          ? emptyListContent()
          : notificationListContent(),
    );
  }

  Widget emptyListContent() {
    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          Center(
            child: Image.asset(
              "assets/icons/empty_bell.png",
              height: 70.0,
              fit: BoxFit.cover,
            ),
          ),
          heightSpace,
          height5Space,
          const Text(
            "Sin notificaciones...",
            style: bold18Grey,
            textAlign: TextAlign.center,
          ),
          heightSpace,
          heightSpace,
          heightSpace,
        ],
      ),
    );
  }

  Widget notificationListContent() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding:
          const EdgeInsets.only(top: fixPadding / 2, bottom: fixPadding * 1.25),
      itemCount: notificationList.length,
      itemBuilder: (context, index) {
        final list = notificationList[index]['list'] as List;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index != 0) heightBox(fixPadding * 1.25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
              child: Text(
                notificationList[index]['title'].toString(),
                style: bold16Black,
              ),
            ),
            heightBox(fixPadding * 0.75),
            ColumnBuilder(
              itemBuilder: (context, i) {
                final listData = list[i];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      list.removeAt(i);
                      if (list.isEmpty) {
                        notificationList.removeAt(index);
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: blackColor,
                        duration: Duration(milliseconds: 1500),
                        content: Text(
                          "Eliminado de las notificaciones",
                          style: semibold16White,
                        ),
                      ),
                    );
                  },
                  background: Container(
                    color: redColor,
                    margin:
                        const EdgeInsets.symmetric(vertical: fixPadding * 0.75),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: fixPadding * 0.75,
                        horizontal: fixPadding * 2.0),
                    padding: const EdgeInsets.all(fixPadding),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: boxShadow,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: listData['isFoodNotification'] == true
                              ? const Iconify(
                                  Mdi.food,
                                  color: whiteColor,
                                  size: 26.0,
                                )
                              : const Iconify(
                                  Ion.restaurant,
                                  color: whiteColor,
                                  size: 24.0,
                                ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listData['title'].toString(),
                                style: medium16Black,
                              ),
                              height5Space,
                              Text(
                                listData['message'].toString(),
                                style: medium14Grey,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: list.length,
            )
          ],
        );
      },
    );
  }
}
