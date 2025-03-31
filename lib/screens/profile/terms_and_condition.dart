import 'package:flutter/material.dart';
import 'package:pn_fl_foody_user/theme/theme.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
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
          "Términos y Condiciones",
          style: bold18Black,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(fixPadding * 2.0, fixPadding / 2,
            fixPadding * 2.0, fixPadding * 2.0),
        children: const [
          Text(
            "1. Aceptación de los Términos\n\nAl acceder o utilizar nuestra aplicación, el usuario acepta cumplir con los siguientes términos y condiciones. Si no está de acuerdo con estos términos, no debe utilizar la aplicación.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "2. Uso de la Aplicación\n\nEl usuario se compromete a utilizar la aplicación de manera responsable y de acuerdo con la ley vigente. No se permitirá el uso de la aplicación con fines ilegales o fraudulentos.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "3. Protección de Datos Personales\n\nNos comprometemos a proteger la privacidad de los datos personales del usuario. La recopilación y uso de los datos se realiza de acuerdo con nuestra Política de Privacidad.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "4. Propiedad Intelectual\n\nTodo el contenido de la aplicación, incluyendo texto, imágenes y diseño, está protegido por derechos de autor y otras leyes de propiedad intelectual. Queda prohibido copiar o distribuir cualquier contenido sin la autorización adecuada.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "5. Modificaciones de los Términos\n\nNos reservamos el derecho de modificar estos términos en cualquier momento. Las modificaciones entrarán en vigor una vez publicadas en esta página.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "6. Responsabilidad\n\nLa aplicación no se hace responsable de los daños directos o indirectos que puedan derivarse del uso de la aplicación. El usuario es responsable de proteger sus dispositivos de virus u otros problemas tecnológicos.",
            style: semibold14Grey,
          ),
          heightSpace,
          Text(
            "7. Ley Aplicable\n\nEstos términos se rigen por las leyes de [nombre del país o jurisdicción], y cualquier disputa será resuelta en los tribunales competentes de dicha jurisdicción.",
            style: semibold14Grey,
          ),
        ],
      ),
    );
  }
}
