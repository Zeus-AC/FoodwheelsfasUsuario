import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';
import 'package:pn_fl_foody_user/widget/column_builder.dart';

class SelectDeliveryAddressScreen extends StatefulWidget {
  const SelectDeliveryAddressScreen({super.key});

  @override
  State<SelectDeliveryAddressScreen> createState() =>
      _SelectDeliveryAddressScreenState();
}

class _SelectDeliveryAddressScreenState
    extends State<SelectDeliveryAddressScreen> {
  final addressList = [
    {
      "title": "Casa",
      "address": "1515 N Main St, Monticello, IN 47960, Estados Unidos.",
      "phoneNumber": "+1 123-456-7890"
    },
    {
      "title": "Oficina",
      "address":
          "102 E Taylor St, Grant Park, IL 60940, Estados Unidos.",
      "phoneNumber": "+1 786-456-7290"
    },
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
          "Seleccionar Dirección de Entrega",
          style: bold18Black,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding / 2,
            fixPadding * 2.0, fixPadding * 2.0),
        children: [
          addressListContent(),
          addNewAddress(),
        ],
      ),
      bottomNavigationBar: amountAndProceedToCheckOut(),
    );
  }

  Widget amountAndProceedToCheckOut() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(fixPadding * 2.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Monto a Pagar",
                  style: bold18Black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              widthSpace,
              Text(
                "\$72.00",
                style: bold18Black,
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/paymentMethod', arguments: 0);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 2.0, vertical: fixPadding * 1.3),
            width: double.maxFinite,
            color: primaryColor,
            child: const Text(
              "Proceder al Pago",
              style: bold18White,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }

  Widget addNewAddress() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/addNewAddress');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding, vertical: fixPadding * 1.2),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                "Agregar Nueva Dirección",
                style: extrabold14Primary,
              ),
            ),
            widthSpace,
            Container(
              height: 20.0,
              width: 20.0,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: primaryColor),
              alignment: Alignment.center,
              child: const Icon(
                Icons.add,
                color: whiteColor,
                size: 18.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget addressListContent() {
    return ColumnBuilder(
      itemBuilder: (context, index) {
        final addressData = addressList[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: fixPadding * 2.0),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: boxShadow,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(fixPadding),
                  width: double.maxFinite,
                  color: recColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          addressData['title'].toString(),
                          style: semibold16Black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      widthSpace,
                      Container(
                        height: 20.0,
                        width: 20.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: whiteColor,
                          border: Border.all(
                              color: primaryColor,
                              width: selectedIndex == index ? 6.0 : 2.0),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(fixPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        addressData['address'].toString(),
                        style: medium14Grey,
                      ),
                      height5Space,
                      Text(
                        addressData['phoneNumber'].toString(),
                        style: medium14Black,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: addressList.length,
    );
  }
}
