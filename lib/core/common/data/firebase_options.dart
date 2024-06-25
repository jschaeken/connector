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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA3YiB2Da_ZAXGxgCbX8LHp5VliQJvE3mw',
    appId: '1:261028981185:web:0577d5c35b63e7104ea740',
    messagingSenderId: '261028981185',
    projectId: 'essence-connector',
    authDomain: 'essence-connector.firebaseapp.com',
    storageBucket: 'essence-connector.appspot.com',
    measurementId: 'G-ZN4B85JSZ7',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAqzggvsFp_9evy8sHpCht5l2dGEDYrv6A',
    appId: '1:261028981185:ios:c5bc32438289f0974ea740',
    messagingSenderId: '261028981185',
    projectId: 'essence-connector',
    storageBucket: 'essence-connector.appspot.com',
    iosBundleId: 'com.example.connector',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA3YiB2Da_ZAXGxgCbX8LHp5VliQJvE3mw',
    appId: '1:261028981185:web:84d77bc8361b67314ea740',
    messagingSenderId: '261028981185',
    projectId: 'essence-connector',
    authDomain: 'essence-connector.firebaseapp.com',
    storageBucket: 'essence-connector.appspot.com',
    measurementId: 'G-BTJVYEQVYY',
  );
}