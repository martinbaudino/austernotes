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
    apiKey: 'AIzaSyDvi76ZAFsVjN-v8NH1yOYjIMyS2ACpjwk',
    appId: '1:497196694080:web:be90631795d0d869a8fda5',
    messagingSenderId: '497196694080',
    projectId: 'austernotes',
    authDomain: 'austernotes.firebaseapp.com',
    storageBucket: 'austernotes.appspot.com',
    measurementId: 'G-VLBXV97XL0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB66P5SJ8Gfm1qkMin66aLqCPslGV304q4',
    appId: '1:497196694080:android:b510650db96912f9a8fda5',
    messagingSenderId: '497196694080',
    projectId: 'austernotes',
    storageBucket: 'austernotes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUvf1yHsRhUvO8PbvTCP1itoUh4GNa8u8',
    appId: '1:497196694080:ios:3d15b63ed549f57da8fda5',
    messagingSenderId: '497196694080',
    projectId: 'austernotes',
    storageBucket: 'austernotes.appspot.com',
    iosClientId: '497196694080-l6b18asebnv48vej0v3g6s4ngdkegfg3.apps.googleusercontent.com',
    iosBundleId: 'ar.baudino.austernotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUvf1yHsRhUvO8PbvTCP1itoUh4GNa8u8',
    appId: '1:497196694080:ios:3d15b63ed549f57da8fda5',
    messagingSenderId: '497196694080',
    projectId: 'austernotes',
    storageBucket: 'austernotes.appspot.com',
    iosClientId: '497196694080-l6b18asebnv48vej0v3g6s4ngdkegfg3.apps.googleusercontent.com',
    iosBundleId: 'ar.baudino.austernotes',
  );
}
