import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final paymentMethodList = [   
    {
      "image": "assets/paymentMethod/cash.png",
      "title": "Pago contra entrega",
    },
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final idData = ModalRoute.of(context)?.settings.arguments as int;
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
        title: Text(
          idData == 1 ? "Métodos de Pago" : "Seleccionar Método de Pago",
          style: bold18Black,
        ),
      ),
      body: paymentListContent(),
      bottomNavigationBar: idData == 1
          ? buttonWiget("Agregar Nuevo Método", () {
              Navigator.pushNamed(context, '/creditcard', arguments: idData);
            })
          : amountAndContinueButton(idData),
    );
  }

  Widget paymentListContent() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
          top: fixPadding / 2, right: fixPadding * 2.0, left: fixPadding * 2.0),
      itemCount: paymentMethodList.length,
      itemBuilder: (context, index) {
        final paymentMethod = paymentMethodList[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(fixPadding),
            margin: const EdgeInsets.only(bottom: fixPadding * 2.0),
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
                  child: Image.asset(
                    paymentMethod['image'].toString(),
                    height: 20.0,
                    width: 20.0,
                    fit: BoxFit.contain,
                  ),
                ),
                widthSpace,
                Expanded(
                  child: Text(
                    paymentMethod['title'].toString(),
                    style: medium16Black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                widthSpace,
                Container(
                  height: 20.0,
                  width: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: selectedIndex == index
                        ? Border.all(color: primaryColor, width: 6.0)
                        : Border.all(color: greyD9Color, width: 2.0),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget amountAndContinueButton(int idData) {
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
        buttonWiget("Continuar", () {
          Navigator.pushNamed(context, '/creditcard', arguments: idData);
        })
      ],
    );
  }

  Widget buttonWiget(String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.3),
        width: double.maxFinite,
        color: primaryColor,
        child: Text(
          title,
          style: bold18White,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
