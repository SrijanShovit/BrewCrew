
import 'package:brew_crew/auth.dart';
import 'package:brew_crew/user.dart';
import 'package:brew_crew/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser?>.value(
        value: AuthService().user,
        initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}


