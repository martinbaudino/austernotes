//import 'dart:js';

import 'package:austernotes/constants/routes.dart';
import 'package:austernotes/views/login_view.dart';
import 'package:austernotes/views/register_view.dart';
import 'package:austernotes/views/verify_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'firebase_options.dart';

void main() {
  devtools.log('Init...');
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings before configuring Firebase
  runApp(
    MaterialApp(
      title: 'AusterNotes',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          // //final emailVerified = user?.emailVerified ?? false;
          // if (user?.emailVerified ?? false) {
          //   return const Text('Done');
          // } else {
          //   return const VerifyEmailView();
          // }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum Menuaction { logout }

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AusterNotes MAIN'),
        actions: [
          PopupMenuButton<Menuaction>(
            itemBuilder: (context) {
              return const [
                PopupMenuItem<Menuaction>(
                    value: Menuaction.logout, child: Text('Logout')),
              ];
            },
            onSelected: (value) async {
              //devtools.log(value.toString());
              switch(value){
                case Menuaction.logout:
                  final shoulLogout = await showLogOutDialog(context);
                  //devtools.log(shoulLogout.toString());
                  if (shoulLogout){
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
                  break;
              }
            },
          )
        ],
      ),
      body: const Text('Hello AusterNotes!'),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure to sign out?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Log out')),
        ],
      );
    },
  ).then(
      (value) => value ?? false); // It either returns the bool value or false
}
