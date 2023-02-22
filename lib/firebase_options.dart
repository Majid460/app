// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'

    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
 

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
    apiKey: 'AIzaSyCu1EKxmkLZJdJH-aLsTR5nibPzj7afEoc',
    appId: '1:545042377608:web:6bbd4d3236e858aef5283d',
    messagingSenderId: '545042377608',
    projectId: 'flutter-taskapp-3a599',
    authDomain: 'flutter-taskapp-3a599.firebaseapp.com',
    storageBucket: 'flutter-taskapp-3a599.appspot.com',
    measurementId: 'G-L53YJH6WLS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnlMyUS4E-pRsb3COQp0DQX8sNaM0Gp3I',
    appId: '1:545042377608:android:70c3e5f28dcaef56f5283d',
    messagingSenderId: '545042377608',
    projectId: 'flutter-taskapp-3a599',
    storageBucket: 'flutter-taskapp-3a599.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7jhSL_EKHu1csyg2tJGn-Rv6CfbMYCmQ',
    appId: '1:545042377608:ios:a9266629a6041708f5283d',
    messagingSenderId: '545042377608',
    projectId: 'flutter-taskapp-3a599',
    storageBucket: 'flutter-taskapp-3a599.appspot.com',
    iosClientId: '545042377608-6giogucr9qtq9ck4up0henehustvace8.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );
}
