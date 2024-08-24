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
    apiKey: 'AIzaSyDwzNLkOR1G2bwjq5sUyFuTeZregaZO2og',
    appId: '1:44645642088:web:17b6e9f2e66fcc5b0df0dd',
    messagingSenderId: '44645642088',
    projectId: 'spotify-clone-796b7',
    authDomain: 'spotify-clone-796b7.firebaseapp.com',
    storageBucket: 'spotify-clone-796b7.appspot.com',
    measurementId: 'G-5SQ94Q9P5W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbk03MgYT0PSX3i4yHfX2qEvzfxEOIpNc',
    appId: '1:44645642088:android:691f734c80168c330df0dd',
    messagingSenderId: '44645642088',
    projectId: 'spotify-clone-796b7',
    storageBucket: 'spotify-clone-796b7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpeo-Q5I_hxXZJYLijZSyqpkgzl2LWSrQ',
    appId: '1:44645642088:ios:dc291dc375f4e3c30df0dd',
    messagingSenderId: '44645642088',
    projectId: 'spotify-clone-796b7',
    storageBucket: 'spotify-clone-796b7.appspot.com',
    iosBundleId: 'com.bilol.spotifyClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpeo-Q5I_hxXZJYLijZSyqpkgzl2LWSrQ',
    appId: '1:44645642088:ios:dc291dc375f4e3c30df0dd',
    messagingSenderId: '44645642088',
    projectId: 'spotify-clone-796b7',
    storageBucket: 'spotify-clone-796b7.appspot.com',
    iosBundleId: 'com.bilol.spotifyClone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDwzNLkOR1G2bwjq5sUyFuTeZregaZO2og',
    appId: '1:44645642088:web:dd2a71dcd0d58f940df0dd',
    messagingSenderId: '44645642088',
    projectId: 'spotify-clone-796b7',
    authDomain: 'spotify-clone-796b7.firebaseapp.com',
    storageBucket: 'spotify-clone-796b7.appspot.com',
    measurementId: 'G-BPYWEXQJP0',
  );
}
