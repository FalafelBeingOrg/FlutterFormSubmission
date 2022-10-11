

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_submission/form_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _formPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      maxLength: 20,
      validator: (value) {
        if (value == null || value.isEmpty || value != "PocketPets123") {
          return "Password is incorrect";
        }
      },
      onSaved: (value) {
        Navigator.push(
                context, MaterialPageRoute(builder: (_) => FormScreen()));
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _formPassword(),
                  SizedBox(height: 50,),
                  ElevatedButton(
                    onPressed: () {
                      if(!_formKey.currentState!.validate()){
                        return;
                      }
                      Navigator.push(
                        context, MaterialPageRoute(builder: (_) => FormScreen()));
                    },
                    child: Text(
                      'Login',
                       style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
              ])     
            )
          ],
        ),
      ),
    );
  }
}