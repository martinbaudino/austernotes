import 'package:austernotes/constants/routes.dart';
import 'package:austernotes/services/auth/auth_exceptions.dart';
import 'package:austernotes/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import '../utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register Screen'),
      ),
      body: Column(
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
                AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(
                    verifyEmailRoute); // Allows going back with the toolbar
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  'Pass too short/weak.',
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context,
                  'Email used!',
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  'Invalid email.',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Falied to register.',
                );
              }
            },
            child: const Text('Go Register!'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already Registered? Log in!'),
          ),
        ],
      ),
    );
  }
}
