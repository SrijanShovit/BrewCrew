import 'package:brew_crew/database.dart';
import 'package:brew_crew/loading.dart';
import 'package:brew_crew/user.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  //form Values
   String _currentName='User';
   String _currentSugars='0';
   int _currentStrength=100;
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid : user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          UserData? userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Update your brew settings',
                  style: TextStyle(fontSize: 18.0),),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData!.name,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? 'Please Enter a Name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData!.sugars,

                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                        value:sugar,
                        child: Text('$sugar sugars')
                    );

                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val.toString()),
                ),
                //slider
                Slider(
                    min:100,
                    max: 900,
                    divisions: 8,
                    value: (_currentStrength ?? userData.strength).toDouble() ,
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    inactiveColor: Colors.brown[_currentStrength ?? 100],
                    onChanged: (val) => setState(() => _currentStrength = val.round())
                ),
                //button
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                     if (_formKey.currentState!.validate()){
                       await DatabaseService(uid: user.uid).updateUserData(
                         _currentSugars ?? userData.sugars,
                         _currentName ?? userData.name,
                         _currentStrength ?? userData.strength
                       );
                       Navigator.pop(context);
                     }
                    })

              ],
            ),
          );

        }else{
          return Loading();

        }

      }
    );
  }
}
