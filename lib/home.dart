
import 'package:brew_crew/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/auth.dart';
import 'package:brew_crew/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/brew_list.dart';
import 'package:brew_crew/brew.dart';

class Home extends StatelessWidget {


  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: ( context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
            backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: [
            FlatButton.icon(onPressed: () async{
              await _auth.signOut();
            },
                icon: Icon(Icons.person),
                label: Text('logout')
            ),FlatButton.icon(onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('settings')
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}