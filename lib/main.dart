import 'package:austernotes/constants/routes.dart';
import 'package:austernotes/services/auth/auth_service.dart';
import 'package:austernotes/views/login_view.dart';
import 'package:austernotes/views/notes_view.dart';
import 'package:austernotes/views/register_view.dart';
import 'package:austernotes/views/verify_email_view.dart';
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
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}




