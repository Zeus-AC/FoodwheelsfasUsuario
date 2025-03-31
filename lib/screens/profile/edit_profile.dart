import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    nameController.text = "Perry Piterson";
    emailController.text = "perry@gmail.com";
    phoneController.text = "+91 9758462548";
    super.initState();
  }

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
          "Editar Perfil",
          style: bold18Black,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding * 1.5,
            fixPadding * 2.0, fixPadding * 2.0),
        physics: const BouncingScrollPhysics(),
        children: [
          userProfileImage(size),
          heightSpace,
          heightSpace,
          heightSpace,
          nameField(),
          heightSpace,
          heightSpace,
          emailField(),
          heightSpace,
          heightSpace,
          phoneNumberField(),
        ],
      ),
      bottomNavigationBar: saveButton(),
    );
  }

  Widget saveButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        padding: const EdgeInsets.symmetric(
            vertical: fixPadding * 1.3, horizontal: fixPadding * 2.0),
        width: double.maxFinite,
        color: primaryColor,
        child: const Text(
          "Guardar",
          style: bold18White,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget phoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Número de Teléfono",
          style: semibold16Black,
        ),
        heightSpace,
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
          child: TextField(
            style: medium15Black,
            cursorColor: primaryColor,
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Ingresa tu número de teléfono",
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
          "Dirección de Correo Electrónico",
          style: semibold16Black,
        ),
        heightSpace,
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
          child: TextField(
            style: medium15Black,
            cursorColor: primaryColor,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Ingresa tu dirección de correo electrónico",
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
          "Nombre",
          style: semibold16Black,
        ),
        heightSpace,
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
          child: TextField(
            style: medium15Black,
            cursorColor: primaryColor,
            controller: nameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Ingresa tu nombre",
              hintStyle: medium15Grey,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: fixPadding * 1.5, vertical: fixPadding * 1.4),
            ),
          ),
        )
      ],
    );
  }

  Widget userProfileImage(Size size) {
    return Center(
      child: SizedBox(
        height: size.height * 0.13 + 2,
        width: size.height * 0.13 + 2,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.13,
              width: size.height * 0.13,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/profile/user-image.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  changeImageSheet();
                },
                child: Container(
                  height: size.height * 0.046,
                  width: size.height * 0.046,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/icons/camera.png",
                    color: whiteColor,
                    height: size.height * 0.027,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> changeImageSheet() {
    return showModalBottomSheet(
      backgroundColor: whiteColor,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(fixPadding * 2.0),
          children: [
            const Text(
              "Opciones para cambiar",
              style: bold18Black,
              textAlign: TextAlign.center,
            ),
            heightSpace,
            heightSpace,
            imageChangeOption("assets/icons/camera.png", "Cámara"),
            heightSpace,
            height5Space,
            imageChangeOption("assets/icons/gallery.png", "Galería"),
            heightSpace,
            height5Space,
            imageChangeOption("assets/icons/delete-icon.png", "Eliminar"),
          ],
        );
      },
    );
  }

  Widget imageChangeOption(String icon, String title) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              icon,
              color: whiteColor,
              height: 22,
              fit: BoxFit.contain,
            ),
          ),
          widthSpace,
          Expanded(
            child: Text(
              title,
              style: semibold16Black,
            ),
          )
        ],
      ),
    );
  }
}
