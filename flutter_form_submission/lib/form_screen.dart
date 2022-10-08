import 'dart:html';
import 'package:flutter_form_submission/user.dart';
import 'package:flutter_form_submission/user_sheets_api.dart';
import 'package:gsheets/gsheets.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {

  String? _name;
  String? _email;
  String? _password;
  String? _url;
  String? _phoneNumber;
  String? _date;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 15,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name is Required';
        }
      },
      onSaved: (value) {
        _name = value;
      },
    );
  }
  Widget _buildEmail(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }
      },
      onSaved: (value) {
        _email = value;
      },
    );
  }
  Widget _buildPassword(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is Required';
        }
      },
      onSaved: (value) {
        _password = value;
      },
    );
  }
  Widget _buildUrl(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'URL'),
      keyboardType: TextInputType.url,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'URL is Required';
        }
      },
      onSaved: (value) {
        _url = value;
      },
    );
  }
  Widget _buildPhoneNumber(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone Number'),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Phone Number is Required';
        }
      },
      onSaved: (value) {
        _phoneNumber = value;
      },
    );
  }
  Widget _buildDate(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Date'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Date is Required';
        }
      },
      onSaved: (value) {
        _date = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pocket Pet Rescue")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildName(),
            _buildEmail(),
            _buildPassword(),
            _buildUrl(),
            _buildPhoneNumber(),
            _buildDate(),
            SizedBox(height: 100,),
            ElevatedButton(child: Text("Submit", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),),
              onPressed: ()  async{
                if(!_formKey.currentState!.validate()){
                  return;
                }
                
                

                _formKey.currentState!.save();

                final user = {
                  UserFields.name: _name,
                  UserFields.email: _email,
                  UserFields.password: _password,
                  UserFields.url: _url,
                  UserFields.phone: _phoneNumber,
                  UserFields.date: _date,
                };

                await UserSheetsApi.insert([user]);

                print(_name);
                print(_email);
                print(_password);
                print(_url);
                print(_phoneNumber);
                print(_date);
              }, 
            ),
          ],
        ),),
      ),
    );
  }
}