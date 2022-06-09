import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false, // Don't remember input
                    autocorrect: false, // Don't read the content
                    keyboardType: TextInputType.emailAddress, // Show "@" OSD
                    decoration: const InputDecoration(
                      hintText: 'Enter your email here',
                    ),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true, // Fill with asterisks
                    enableSuggestions: false, // Don't remember input
                    autocorrect: false, // Don't read the content
                    decoration: const InputDecoration(
                      hintText: 'Enter your password here',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        final UserCredential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password);
                      print(UserCredential);
                      } on FirebaseAuthException catch (e) {
                        if(e.code == 'user-not-found'){
                          print('User Not Found');
                        } else if (e.code == 'wrong-password'){
                          print('Wrong password.');
                        } else {
                          print('Something else happened');
                          print(e.code);
                        }
                      }
                      
                    },
                    child: const Text('LogIn'),
                  ),
                ],
              );
            default: 
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}