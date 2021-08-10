import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/auth.dart';
import 'package:brew_crew/constants.dart ';
import 'package:brew_crew/loading.dart';



class Register extends StatefulWidget {

  final Function toggleView;
  Register({required this.toggleView} );

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register to Brew Crew'),
        actions: [
          FlatButton.icon(onPressed: () {
            widget.toggleView();
          },
              icon: Icon(Icons.person), label: Text('Sign In'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0 , horizontal:  50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                decoration:textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => email = val);

                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a stronger password' : null,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),

              SizedBox(height: 20),
              RaisedButton(
                color:Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),

                onPressed: () async {
                  //widget refers to stateful widget
                  //this not used as it will refer to this object
                  if (_formKey.currentState!.validate()){
                    setState(() => loading=true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                   if (result == null){
                      setState(()  {
                        error = 'invalid email or password';
                        loading = false;
                      });
                   }
                  }

                },
              ),
              SizedBox(height: 12,),
              Text(error,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.0
              ),),


            ],
          ),
        ),
      ),
    );
  }
}
