import 'package:austernotes/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings before configuring Firebase
  runApp(
    MaterialApp(
      title: 'AusterNotes',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              //final emailVerified = user?.emailVerified ?? false;
              if(user?.emailVerified ?? false){
                print('Mail Verified');
              } else {
                print('Verify mail');
              }
              return const Text('Done');
            default: 
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
