// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCHZNb9xI59S0**************',
    appId: '1:858851012397:web:d066c2cc**************',
    messagingSenderId: '8588**************',
    projectId: 'chatapp-e**************',
    authDomain: 'chatapp-e**************.firebaseapp.com',
    databaseURL: 'https://chatapp-e**************-default-rtdb.firebaseio.com',
    storageBucket: 'chatapp-e**************.appspot.com',
    measurementId: 'G-ZPV**********',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_RDOSGL36nH5hf**********',
    appId: '1:858851012397:android:362db9f2**********4',
    messagingSenderId: '858**********',
    projectId: 'chatapp-e**********',
    databaseURL: 'https://chatapp-e**********-default-rtdb.firebaseio.com',
    storageBucket: 'chatapp-e**********.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDtPiGc1emgKN**********',
    appId: '1:858851012397:ios:f08928**********4',
    messagingSenderId: '8588**********',
    projectId: 'chatapp-e**********',
    databaseURL: 'https://chatapp-e**********-default-rtdb.firebaseio.com',
    storageBucket: 'chatapp-e**********.appspot.com',
    iosBundleId: 'com.example.chatterbox',
  );
}
