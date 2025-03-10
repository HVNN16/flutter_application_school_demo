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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyA2ArnTIYVX2cBPfpOz0Znyc3pccz0cXbU',
    appId: '1:795231895700:web:03f99baa35031f35d93481',
    messagingSenderId: '795231895700',
    projectId: 'school-bcd28',
    authDomain: 'school-bcd28.firebaseapp.com',
    storageBucket: 'school-bcd28.firebasestorage.app',
    measurementId: 'G-9B9G3CTJJC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAC-L8-fR1GqMJOWtUCsTc1n2kT9Al78KU',
    appId: '1:795231895700:android:55a22ba9424e3171d93481',
    messagingSenderId: '795231895700',
    projectId: 'school-bcd28',
    storageBucket: 'school-bcd28.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXI9okkcav2N9iZJBhOqkbWrUJwx7rw2Y',
    appId: '1:795231895700:ios:e34116413a16bdf2d93481',
    messagingSenderId: '795231895700',
    projectId: 'school-bcd28',
    storageBucket: 'school-bcd28.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplicationSchool',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXI9okkcav2N9iZJBhOqkbWrUJwx7rw2Y',
    appId: '1:795231895700:ios:e34116413a16bdf2d93481',
    messagingSenderId: '795231895700',
    projectId: 'school-bcd28',
    storageBucket: 'school-bcd28.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplicationSchool',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA2ArnTIYVX2cBPfpOz0Znyc3pccz0cXbU',
    appId: '1:795231895700:web:a484cf087427c75cd93481',
    messagingSenderId: '795231895700',
    projectId: 'school-bcd28',
    authDomain: 'school-bcd28.firebaseapp.com',
    storageBucket: 'school-bcd28.firebasestorage.app',
    measurementId: 'G-FRJH39LCJ2',
  );
}
