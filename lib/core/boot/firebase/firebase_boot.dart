import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.g.dart';

abstract class FirebaseBoot {
  static Future<void> run({bool useEmulators = false}) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseAuth.instance.authStateChanges().first;
  }
}
