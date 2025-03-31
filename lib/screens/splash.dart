import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _opacityController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    // Animation for scaling the logo (Duration increased to 3 seconds)
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),  // Duración aumentada a 3 segundos
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Animation for the opacity (fading in, Duration increased to 3 seconds)
    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),  // Duración aumentada a 3 segundos
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _opacityController, curve: Curves.easeIn),
    );

    // Start animations
    _scaleController.forward();
    _opacityController.forward();

    // Navigate after splash screen, waits for the animation to finish
    Timer(const Duration(seconds: 5), () {  // Aumento de 3 a 5 segundos para asegurar que la animación termine
      Navigator.pushNamed(context, '/onboarding');
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white, // Fondo blanco
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([_scaleController, _opacityController]),
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                "assets/splash/Logo-FoodWheelsFast.png", // Logo más grande
                width: 250.0, // Tamaño del logo
                height: 250.0, // Tamaño del logo
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
