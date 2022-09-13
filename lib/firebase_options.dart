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
    apiKey: 'AIzaSyAmR4W1zc4GybDh6TjJudoCjc9MXnExSQQ',
    appId: '1:246841675181:web:f122f7366baaf1decfa524',
    messagingSenderId: '246841675181',
    projectId: 'sumry-man',
    authDomain: 'sumry-man.firebaseapp.com',
    databaseURL: 'https://sumry-man-default-rtdb.firebaseio.com',
    storageBucket: 'sumry-man.appspot.com',
    measurementId: 'G-358PJP5SPD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDALR6Nrtj-bu5Qj_S42QU1GTboSS79Udk',
    appId: '1:246841675181:android:603f31f345255919cfa524',
    messagingSenderId: '246841675181',
    projectId: 'sumry-man',
    databaseURL: 'https://sumry-man-default-rtdb.firebaseio.com',
    storageBucket: 'sumry-man.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxd1n7JSWVQrBLxQ5CEH0XaEXTjZB3XpQ',
    appId: '1:246841675181:ios:d40b855e569de074cfa524',
    messagingSenderId: '246841675181',
    projectId: 'sumry-man',
    databaseURL: 'https://sumry-man-default-rtdb.firebaseio.com',
    storageBucket: 'sumry-man.appspot.com',
    iosClientId: '246841675181-jn5k3li7l0sn0eiitppiohhev4vceljv.apps.googleusercontent.com',
    iosBundleId: 'com.example.sumryApp',
  );
}
