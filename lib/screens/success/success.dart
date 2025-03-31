import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/screens/bottom_bar.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
          Navigator.pushNamedAndRemoveUntil(
              context, '/bottomBar', (route) => false),
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(fixPadding * 2.0),
            children: [
              successContent(size),
              heightSpace,
              heightSpace,
              height5Space,
              backToMyOrders(context),
              heightSpace,
              height5Space,
              backToHomeButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget successContent(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/success/payment-success.png",
            height: size.height * 0.25,
            fit: BoxFit.cover,
          ),
        ),
        heightSpace,
        heightSpace,
        height5Space,
        const Text(
          "Pago Exitoso",
          style: bold18Black,
          textAlign: TextAlign.center,
        ),
        heightSpace,
        const Text(
          "Tu pago fue exitoso. Solo espera a que llegue a tu ubicación.",
          style: semibold16Grey,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget backToHomeButton(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/bottomBar', (route) => false);
        },
        child: const Text(
          "Volver al Inicio",
          style: bold18Primary,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget backToMyOrders(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomBar(index: 0)),
            (route) => false);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.0, vertical: fixPadding * 1.1),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Text(
          "Mis Pedidos",
          style: bold20White,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
