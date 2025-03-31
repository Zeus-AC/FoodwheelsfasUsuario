import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  DateTime? backPressTime;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

 Future<void> _signIn() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text("Iniciando sesión..."),
          ],
        ),
      );
    },
  );

  try {
    await _auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    Navigator.pop(context); // Cerrar el diálogo de carga
    Navigator.pushReplacementNamed(context, '/bottomBar'); // Navegar 
  } catch (e) {
    Navigator.pop(context); // Cerrar el diálogo de carga
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error al iniciar sesión: ${e.toString()}"),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        bool backStatus = onPopScope();
        if (backStatus) {
          exit(0);
        }
      },
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Column(
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(25.0),
                    ),
                  ),
                  child: SafeArea(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(fixPadding * 2.0),
                      children: [
                        signInContent(),
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        emailField(),
                        heightSpace,
                        passwordField(),
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        signInButton(),

                      ],
                    ),
                  ),
                ),
              ),
              signUpAndOtherOptions(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget signInButton() {
    return GestureDetector(
      onTap: _signIn,
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: fixPadding * 1.1, horizontal: fixPadding * 2.0),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Text(
          "Iniciar sesión",
          style: bold20White,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Correo electrónico",
          style: semibold16Black33,
        ),
        heightSpace,
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          cursorColor: primaryColor,
          style: medium15Black33,
          decoration: InputDecoration(
            hintText: "Introduce tu correo electrónico",
            hintStyle: medium15Grey,
            contentPadding: EdgeInsets.symmetric(
              vertical: fixPadding * 1.45,
              horizontal: fixPadding * 2.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        )
      ],
    );
  }

  Widget passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Contraseña",
          style: semibold16Black33,
        ),
        heightSpace,
        TextField(
          controller: passwordController,
          obscureText: true,
          cursorColor: primaryColor,
          style: medium15Black33,
          decoration: InputDecoration(
            hintText: "Introduce tu contraseña",
            hintStyle: medium15Grey,
            contentPadding: EdgeInsets.symmetric(
              vertical: fixPadding * 1.45,
              horizontal: fixPadding * 2.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        )
      ],
    );
  }

  Widget signUpAndOtherOptions(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding * 1.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              text: "¿No tienes una cuenta?",
              style: semibold16White.copyWith(
                color: whiteColor.withOpacity(0.7),
              ),
              children: [
                TextSpan(
                  text: "Registrate",
                  style: bold16White,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, '/signup');
                    },
                ),
              ],
            ),
          ),
          heightSpace,
         
        ],
      ),
    );
  }

   Widget socialBoxWidget(String image) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: whiteColor,
      ),
      alignment: Alignment.center,
      child: Image.asset(
        image,
        height: 30.0,
        width: 30.0,
        fit: BoxFit.contain,
      ),
    );
  }


  Widget signInContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Iniciar sesión",
          style: bold20Black,
        ),
        heightSpace,
        Text(
          "Bienvenido, inicie sesión en su cuenta utilizando su correo electrónico y contraseña.",
          style: medium15Grey,
        )
      ],
    );
  }

  onPopScope() {
    DateTime now = DateTime.now();
    if (backPressTime == null ||
        now.difference(backPressTime!) >= const Duration(seconds: 2)) {
      backPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: blackColor,
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 1500),
          content: Text(
            "Presione Atrás una vez más para salir.",
            style: semibold16White,
          ),
        ),
      );
      return false;
    } else {
      return true;
    }
  }
  
}