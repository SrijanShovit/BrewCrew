import 'package:brew_crew/authenticate.dart';
import 'package:brew_crew/home.dart';
import 'package:brew_crew/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser?>(context);
    print(user);
    if (user == null){
      return Authenticate();
    }
    else{
      return Home();
    }



  }
}
