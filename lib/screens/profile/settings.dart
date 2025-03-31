import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationOn = false;
  bool isShareLocation = false;

  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status.isGranted) {
      showNotification("Notificaciones activadas", "Ahora recibirás notificaciones.");
    }
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      showNotification("Ubicación compartida", "Ahora se compartirá tu ubicación.");
    }
  }

  void showNotification(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$title: $message")),
    );
  }

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
          "Configuración",
          style: bold18Black,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        children: [
          settingsWithSwitch("Notificaciones", isNotificationOn, () async {
            final newValue = !isNotificationOn;
            setState(() => isNotificationOn = newValue);
            if (newValue) await requestNotificationPermission();
          }),
          const SizedBox(height: 16.0),
          settingsWithSwitch("Acepto compartir mi ubicación", isShareLocation, () async {
            final newValue = !isShareLocation;
            setState(() => isShareLocation = newValue);
            if (newValue) await requestLocationPermission();
          }),
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
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        color: primaryColor,
        child: const Text(
          "Guardar",
          style: bold18White,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget settingsWithSwitch(String title, bool value, Function() onTap) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: boxShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: medium16Black,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 35.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: value ? primaryColor : greyD9Color,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  height: 14.0,
                  width: 14.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: whiteColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
