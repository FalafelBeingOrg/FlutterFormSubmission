import 'package:flutter_form_submission/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_submission/log_in.dart';
import 'package:flutter_form_submission/user_sheets_api.dart';
import 'package:flutter_form_submission/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSheetsApi.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Form Submission",
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white
        ),
        primarySwatch: Colors.lightGreen,
      ),
      home: Login(),
    );
  }
}
