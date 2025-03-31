import 'package:pn_fl_foody_user/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

Future<void> _signUp() async {
  if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Las contraseñas no coinciden")),
    );
    return;
  }

  try {
    // Crear usuario con FirebaseAuth
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    User? user = userCredential.user;

    if (user != null) {
      // Enviar correo de verificación
      await user.sendEmailVerification();

      // Guardar datos del usuario en Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': user.email,
        'username': _usernameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'verified': false, // Opcional: Indicar si el usuario verificó el correo
      });

      // Mostrar mensaje indicando que verifique su correo
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registro exitoso. Verifique su correo electrónico")),
      );

      // Redirigir al usuario a la pantalla de inicio de sesión
      Navigator.pushNamed(context, '/signin');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: ${e.toString()}")),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25.0),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      children: [
                        signUpContent(),
                        heightSpace,
                        userNameField(),
                        heightSpace,
                        emailField(),
                        heightSpace,
                        mobileNumberField(),
                        heightSpace,
                        passwordField(),
                        height5Space,
                        confirmPasswordField(),
                        height5Space,
                        signUpButton(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          signInAndOtherOptions(context)
        ],
      ),
    );
  }

  Widget signUpButton() {
    return GestureDetector(
      onTap: _signUp,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Text(
          "Registrarse",
          style: bold20White,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget mobileNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Número de teléfono móvil", style: semibold16Black33),
        heightSpace,
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
          child: TextField(
            controller: _phoneController,
            style: medium15Black33,
            cursorColor: primaryColor,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Ingrese el número de móvil",
              hintStyle: medium15Grey,
              contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Correo electrónico", style: semibold16Black33),
        heightSpace,
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
          child: TextField(
            controller: _emailController,
            style: medium15Black33,
            cursorColor: primaryColor,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Ingrese su correo electrónico",
              hintStyle: medium15Grey,
              contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget userNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Nombre de usuario", style: semibold16Black33),
        heightSpace,
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
          child: TextField(
            controller: _usernameController,
            style: medium15Black33,
            cursorColor: primaryColor,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Ingrese su nombre de usuario",
              hintStyle: medium15Grey,
              contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            ),
          ),
        ),
      ],
    );
  }

Widget confirmPasswordField() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0), // Espacio de 20px debajo
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Confirmar Contraseña", style: semibold16Black33),
        heightSpace,
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: boxShadow,
          ),
          child: TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            style: medium15Black33,
            cursorColor: primaryColor,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Vuelve a introducir tu contraseña",
              hintStyle: medium15Grey,
              contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            ),
          ),
        ),
      ],
    ),
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
      Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: boxShadow,
        ),
        child: TextField(
          controller: _passwordController,
          obscureText: true,
          style: medium15Black33,
          cursorColor: primaryColor,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Introduce tu contraseña",
            hintStyle: medium15Grey,
            contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          ),
        ),
      ),
    ],
  );
}



  Widget signInAndOtherOptions(BuildContext context) {
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
              text: "¿Ya tienes una cuenta? ",
              style: semibold16White.copyWith(
                color: whiteColor.withOpacity(0.7),
              ),
              children: [
                TextSpan(
                  text: "Iniciar sesión",
                  style: bold16White,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, '/signin');
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

  Widget signUpContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Registrarse", style: bold20Black),
        heightSpace,
        Text("Bienvenido, cree su cuenta utilizando su correo electrónico.", style: medium15Grey),
      ],
    );
  }
}