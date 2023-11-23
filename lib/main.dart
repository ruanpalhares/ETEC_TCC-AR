import 'package:automcao_residencial/app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late FirebaseApp firebaseApp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await currentFirebaseApp();
  runApp(const Aplicacao());
}

Future<FirebaseApp> currentFirebaseApp() => Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
