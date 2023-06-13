import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBl9h4KvE1upL8KKi1HlflFLjv7H8YitnM",
            authDomain: "mfsbd-25488.firebaseapp.com",
            projectId: "mfsbd-25488",
            storageBucket: "mfsbd-25488.appspot.com",
            messagingSenderId: "277598766365",
            appId: "1:277598766365:web:2dad0991bc99c3cc24cdf4"));
  } else {
    await Firebase.initializeApp();
  }
}
