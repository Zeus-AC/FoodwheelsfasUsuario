import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
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
          "Ayuda y Soporte", // Traducción de "Help And Support"
          style: bold18Black,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          Center(
            child: Image.asset(
              "assets/profile/helpImage.png",
              height: size.height * 0.25,
              fit: BoxFit.cover,
            ),
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          nameField(),
          heightSpace,
          heightSpace,
          emailField(),
          heightSpace,
          heightSpace,
          messageField(),
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
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
            vertical: fixPadding * 1.3, horizontal: fixPadding * 2.0),
        color: primaryColor,
        child: const Text(
          "Enviar", // Traducción de "Submit"
          style: bold18White,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget messageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mensaje", // Traducción de "Message"
          style: semibold16Black,
        ),
        heightSpace,
        Container(
          height: 120.0,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
          child: const TextField(
            expands: true,
            minLines: null,
            maxLines: null,
            textAlignVertical: TextAlignVertical.top,
            style: medium15Black,
            cursorColor: primaryColor,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Ingrese el mensaje aquí...", // Traducción de hint text
              hintStyle: medium15Grey,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: fixPadding * 1.5, vertical: fixPadding * 1.4),
            ),
          ),
        )
      ],
    );
  }

  Widget emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Correo Electrónico", // Traducción de "Email Address"
          style: semibold16Black,
        ),
        heightSpace,
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
          child: const TextField(
            style: medium15Black,
            cursorColor: primaryColor,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Ingrese su correo electrónico", // Traducción de hint text
              hintStyle: medium15Grey,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: fixPadding * 1.5, vertical: fixPadding * 1.4),
            ),
          ),
        )
      ],
    );
  }

  Widget nameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nombre", // Traducción de "Name"
          style: semibold16Black,
        ),
        heightSpace,
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
          child: const TextField(
            style: medium15Black,
            cursorColor: primaryColor,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Ingrese su nombre", // Traducción de hint text
              hintStyle: medium15Grey,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: fixPadding * 1.5, vertical: fixPadding * 1.4),
            ),
          ),
        )
      ],
    );
  }
}
