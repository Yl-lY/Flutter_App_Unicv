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
    apiKey: 'AIzaSyD12UHGxiRymRoPymQWcwj79rmkvTxKyfw',
    appId: '1:773715600348:web:2f3cd5af3ca2dfa044a519',
    messagingSenderId: '773715600348',
    projectId: 'unicv-chat-5-semestre',
    authDomain: 'unicv-chat-5-semestre.firebaseapp.com',
    storageBucket: 'unicv-chat-5-semestre.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDN0e_RtTlCG9Cd_kAIBb4f8fJKKgyEh7I',
    appId: '1:773715600348:android:8aff38f2ce14f42644a519',
    messagingSenderId: '773715600348',
    projectId: 'unicv-chat-5-semestre',
    storageBucket: 'unicv-chat-5-semestre.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDddrDbK6DtENlRJTeHrHYqqSZodwnp9DI',
    appId: '1:773715600348:ios:87dc4d44162da3d444a519',
    messagingSenderId: '773715600348',
    projectId: 'unicv-chat-5-semestre',
    storageBucket: 'unicv-chat-5-semestre.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDddrDbK6DtENlRJTeHrHYqqSZodwnp9DI',
    appId: '1:773715600348:ios:87dc4d44162da3d444a519',
    messagingSenderId: '773715600348',
    projectId: 'unicv-chat-5-semestre',
    storageBucket: 'unicv-chat-5-semestre.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD12UHGxiRymRoPymQWcwj79rmkvTxKyfw',
    appId: '1:773715600348:web:9a1dbdd226c59dcc44a519',
    messagingSenderId: '773715600348',
    projectId: 'unicv-chat-5-semestre',
    authDomain: 'unicv-chat-5-semestre.firebaseapp.com',
    storageBucket: 'unicv-chat-5-semestre.firebasestorage.app',
  );

}