import 'package:awesome_card/credit_card.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen({super.key});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController number =
      MaskedTextController(mask: '0000 0000 0000 0000');
  late TextEditingController validThru = MaskedTextController(mask: "00/00");
  late TextEditingController cvv = MaskedTextController(mask: "000");
  late TextEditingController holder = TextEditingController();

  FocusNode cvvFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    number.addListener(() => setState(() {}));
    validThru.addListener(() => setState(() {}));
    cvv.addListener(() => setState(() {}));
    holder.addListener(() => setState(() {}));
    cvvFocus.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
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
          idData == 1 ? "Agregar nuevo método" : "Tarjeta de crédito",
          style: bold18Black,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2, fixPadding / 2, fixPadding * 2.0, fixPadding * 2.0),
        physics: const BouncingScrollPhysics(),
        children: [
          creditcardUi(size),
          heightSpace,
          heightSpace,
          heightSpace,
          creditcardForm(),
        ],
      ),
      bottomNavigationBar: idData == 1
          ? buttonWidget("Agregar", () {
              Navigator.pop(context);
            })
          : buttonWidget("Pago (\$72.00)", () {
              Navigator.pushNamed(context, '/success');
            }),
    );
  }

  Widget buttonWidget(String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.3),
        width: double.maxFinite,
        color: primaryColor,
        child: Text(
          title,
          style: bold18White,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget creditcardUi(Size size) {
    return CreditCard(
      cardNumber: number.text,
      cardExpiry: validThru.text,
      cardHolderName: holder.text,
      cvv: cvv.text,
      width: double.maxFinite,
      horizontalMargin: 0,
      showBackSide: cvvFocus.hasFocus ? true : false,
      frontBackground: const SizedBox(),
      backBackground: const SizedBox(),
      backTextColor: whiteColor,
      frontTextColor: whiteColor,
      frontLayout: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/creditcard/card-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tarjeta de Crédito",
              style: bold14White,
            ),
            width5Space,
            Text(
              number.text.isEmpty
                  ? "XXXX XXXX XXXX XXXX"
                  : number.text.toString(),
              style: bold18White,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                const Text(
                  "Exp.\nFecha",
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 10.0,
                  ),
                ),
                width5Space,
                Text(
                  validThru.text.isEmpty ? "XX/YY" : validThru.text.toString(),
                  style: bold14White,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    holder.text.isEmpty ? "Nombre" : holder.text.toString(),
                    style: bold14White,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                widthSpace,
                Image.asset(
                  "assets/creditcard/Visa.png",
                  height: 15.0,
                  fit: BoxFit.cover,
                )
              ],
            )
          ],
        ),
      ),
      backLayout: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/creditcard/card-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightSpace,
            heightSpace,
            Container(
              height: 50.0,
              width: double.maxFinite,
              color: blackColor,
            ),
            heightSpace,
            heightSpace,
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45.0,
                    color: const Color(0xFFD4D4D4),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding / 2),
                  height: 35.0,
                  width: 80.0,
                  color: whiteColor,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    cvv.text.isEmpty ? "" : cvv.text.toString(),
                    style: medium14Black,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      showShadow: false,
      height: 200.0,
    );
  }

  Widget creditcardForm() {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: whiteColor,
      boxShadow: boxShadow,
    );
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fieldTitle("Nombre en la tarjeta"),
          heightSpace,
          Container(
            decoration: boxDecoration,
            child: TextField(
              controller: holder,
              keyboardType: TextInputType.name,
              cursorColor: primaryColor,
              style: medium15Black,
              decoration: inputDecoration(
                hintText: "Ingrese nombre en la tarjeta",
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          fieldTitle("Número de tarjeta"),
          heightSpace,
          Container(
            decoration: boxDecoration,
            child: TextField(
              controller: number,
              keyboardType: TextInputType.number,
              cursorColor: primaryColor,
              style: medium15Black,
              decoration: inputDecoration(
                hintText: "Ingrese número de tarjeta",
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fieldTitle("Vencimiento"),
                    heightSpace,
                    Container(
                      decoration: boxDecoration,
                      child: TextField(
                        controller: validThru,
                        keyboardType: TextInputType.number,
                        cursorColor: primaryColor,
                        style: medium15Black,
                        decoration: inputDecoration(
                          hintText: "XX/YY",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              widthSpace,
              widthSpace,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fieldTitle("CVV"),
                    heightSpace,
                    Container(
                      decoration: boxDecoration,
                      child: TextField(
                        controller: cvv,
                        focusNode: cvvFocus,
                        keyboardType: TextInputType.number,
                        cursorColor: primaryColor,
                        style: medium15Black,
                        obscureText: true,
                        obscuringCharacter: "*",
                        decoration: inputDecoration(
                          hintText: "CVV",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget fieldTitle(String title) {
    return Text(
      title,
      style: semibold16Black33,
      overflow: TextOverflow.ellipsis,
    );
  }

  InputDecoration inputDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: medium15Grey,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(
          vertical: fixPadding * 1.4, horizontal: fixPadding * 1.6),
      isDense: true,
    );
  }
}
