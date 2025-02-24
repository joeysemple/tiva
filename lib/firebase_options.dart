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
    apiKey: 'AIzaSyC8P02KbRUX_kfGA6U7EV7MSillnuSoWB4',
    appId: '1:535921487088:web:2900cd7609733f7284e635',
    messagingSenderId: '535921487088',
    projectId: 'tiva-af831',
    authDomain: 'tiva-af831.firebaseapp.com',
    storageBucket: 'tiva-af831.firebasestorage.app',
    measurementId: 'G-BCMS5BPPZJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsZ_7xywipIbFgYzN6TvtEtAXj43YpoHU',
    appId: '1:535921487088:android:ac0b8d5770a0e4a884e635',
    messagingSenderId: '535921487088',
    projectId: 'tiva-af831',
    storageBucket: 'tiva-af831.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnf79WZyp7Lfy6JSHnSDaTUL4FGnTVhcw',
    appId: '1:535921487088:ios:d1e148a09c8f26c884e635',
    messagingSenderId: '535921487088',
    projectId: 'tiva-af831',
    storageBucket: 'tiva-af831.firebasestorage.app',
    iosBundleId: 'com.example.tiva',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnf79WZyp7Lfy6JSHnSDaTUL4FGnTVhcw',
    appId: '1:535921487088:ios:d1e148a09c8f26c884e635',
    messagingSenderId: '535921487088',
    projectId: 'tiva-af831',
    storageBucket: 'tiva-af831.firebasestorage.app',
    iosBundleId: 'com.example.tiva',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC8P02KbRUX_kfGA6U7EV7MSillnuSoWB4',
    appId: '1:535921487088:web:566ceb84e641e8f684e635',
    messagingSenderId: '535921487088',
    projectId: 'tiva-af831',
    authDomain: 'tiva-af831.firebaseapp.com',
    storageBucket: 'tiva-af831.firebasestorage.app',
    measurementId: 'G-MR0SDLK8R4',
  );
}
