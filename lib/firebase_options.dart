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
        return macos;
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
    apiKey: 'AIzaSyAW9gNIMuB-yiL40RiLXWhsW_a57Cy85gQ',
    appId: '1:1054463436492:web:bb220f601dd4de228f8469',
    messagingSenderId: '1054463436492',
    projectId: 'depotautohub-49bff',
    authDomain: 'depotautohub-49bff.firebaseapp.com',
    databaseURL: 'https://depotautohub-49bff-default-rtdb.firebaseio.com',
    storageBucket: 'depotautohub-49bff.appspot.com',
    measurementId: 'G-6J98XE4KM9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnPLNzcdEFWZ79peryOnSx2-tsa9mgEac',
    appId: '1:1054463436492:android:4d6e49920a2f07de8f8469',
    messagingSenderId: '1054463436492',
    projectId: 'depotautohub-49bff',
    databaseURL: 'https://depotautohub-49bff-default-rtdb.firebaseio.com',
    storageBucket: 'depotautohub-49bff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArCreriCx-FHLm7vCO9OE0Q70hfk9AeA8',
    appId: '1:1054463436492:ios:9c7da3b89c3f25f38f8469',
    messagingSenderId: '1054463436492',
    projectId: 'depotautohub-49bff',
    databaseURL: 'https://depotautohub-49bff-default-rtdb.firebaseio.com',
    storageBucket: 'depotautohub-49bff.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyArCreriCx-FHLm7vCO9OE0Q70hfk9AeA8',
    appId: '1:1054463436492:ios:2d6e93291b4ab2378f8469',
    messagingSenderId: '1054463436492',
    projectId: 'depotautohub-49bff',
    databaseURL: 'https://depotautohub-49bff-default-rtdb.firebaseio.com',
    storageBucket: 'depotautohub-49bff.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
