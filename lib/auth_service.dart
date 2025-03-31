import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Instancia única de GoogleSignIn
final GoogleSignIn googleSignIn = GoogleSignIn(
  clientId: "814853709307-b78jb25fe6ch6g522pj0650cfiakqpl3.apps.googleusercontent.com",  // Reemplaza con tu Client ID
  scopes: ['email'],
);

Future<User?> signInWithGoogle() async {
  try {
    // Intenta iniciar sesión con Google
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null; // El usuario canceló el inicio de sesión
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Autentica al usuario en Firebase
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user;
  } catch (e) {
    print("Error al iniciar sesión con Google: $e");
    return null;
  }
}
