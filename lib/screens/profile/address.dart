import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';
import 'package:pn_fl_foody_user/widget/column_builder.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
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
            Icons.arrow_back,
            color: blackColor,
          ),
        ),
        title: const Text(
          "Dirección",
          style: bold18Black,
        ),
      ),
      body: addressList.isEmpty
          ? emptyListContent()
          : ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(fixPadding * 2.0,
                  fixPadding / 2, fixPadding * 2.0, fixPadding * 2.0),
              children: [
                addressListContent(),
                addNewAddress(),
              ],
            ),
    );
  }

  emptyListContent() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(fixPadding * 2.0),
              children: [
                Center(
                  child: Image.asset(
                    "assets/icons/empty-location.png",
                    height: 70.0,
                    fit: BoxFit.cover,
                  ),
                ),
                heightSpace,
                const Text(
                  "No hay direcciones disponibles",
                  style: bold18Grey,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(fixPadding * 2.0),
          child: addNewAddress(),
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
                "Añadir nueva dirección",
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
        return Container(
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          addressList.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: blackColor,
                            duration: Duration(milliseconds: 1500),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Eliminado de la lista de direcciones",
                              style: semibold16White,
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        "assets/icons/delete-icon.png",
                        color: lightRedColor,
                        height: 20.0,
                        width: 20.0,
                        fit: BoxFit.contain,
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
        );
      },
      itemCount: addressList.length,
    );
  }
}
