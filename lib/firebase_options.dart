// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyB4wShnV2F9rUFpfcxro7daWNDVIssMXis',
    appId: '1:266072270261:web:79865bcee3c05ceca5e5fc',
    messagingSenderId: '266072270261',
    projectId: 'shop-5a027',
    authDomain: 'shop-5a027.firebaseapp.com',
    storageBucket: 'shop-5a027.appspot.com',
    measurementId: 'G-HY6GF16HTZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAc7pF6L-OSqiCzuVZsAwzdWo_xsbkkov4',
    appId: '1:266072270261:android:a92b8bcc6e06ea65a5e5fc',
    messagingSenderId: '266072270261',
    projectId: 'shop-5a027',
    storageBucket: 'shop-5a027.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXW52zYM6Q5A7Q7LfiX9dE3TVjpGrHaSM',
    appId: '1:266072270261:ios:b3dbab732549553fa5e5fc',
    messagingSenderId: '266072270261',
    projectId: 'shop-5a027',
    storageBucket: 'shop-5a027.appspot.com',
    iosClientId: '266072270261-kkn7sg89go7vghndumjshkf7lsnsk67k.apps.googleusercontent.com',
    iosBundleId: 'com.example.ebook',
  );
}
