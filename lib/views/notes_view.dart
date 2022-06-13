import 'package:austernotes/constants/routes.dart';
import 'package:austernotes/enums/menu_action.dart';
import 'package:austernotes/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

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
                    AuthService.firebase().logOut();                    
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