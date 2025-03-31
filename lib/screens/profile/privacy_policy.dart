import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
          "Política de Privacidad",
          style: bold18Black,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, fixPadding / 2, fixPadding * 2.0, fixPadding * 2.0),
        children: const [
          Text(
            "En Coding Tech, valoramos tu privacidad y nos comprometemos a proteger la información personal que compartes con nosotros a través de nuestra aplicación FoodWheels Fast. Esta política explica cómo recopilamos, utilizamos y protegemos tus datos.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "\n1. Recopilación de Información\nRecopilamos información personal como nombre, dirección, teléfono y método de pago para procesar tus pedidos de comida. También obtenemos datos de ubicación para mejorar la experiencia de entrega.\n",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "2. Uso de la Información\nLa información recopilada se utiliza para procesar pedidos, mejorar el servicio y personalizar tu experiencia en la aplicación. No compartimos tus datos con terceros sin tu consentimiento, salvo cuando sea necesario para completar una transacción.\n",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "3. Seguridad de los Datos\nImplementamos medidas de seguridad para proteger tu información contra accesos no autorizados. Sin embargo, ningún método de transmisión por internet es 100% seguro, por lo que recomendamos el uso responsable de la aplicación.\n",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "4. Derechos del Usuario\nPuedes acceder, corregir o eliminar tu información personal desde la configuración de la aplicación. Si deseas más información sobre tus derechos, contáctanos a soporte@codingtech.com.\n",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "5. Cambios en la Política\nPodemos actualizar esta política en cualquier momento. Te notificaremos de cualquier cambio a través de la aplicación o nuestro sitio web.\n",
            style: semibold14Grey,
          ),
        ],
      ),
    );
  }
}
