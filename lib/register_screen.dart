import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_form_screen/login_screen.dart';

import 'databasehelper.dart';
import 'main.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var emailController = TextEditingController();
  var _mobilenocontroller = TextEditingController();

  var _dobController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Register'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Enter UserName',
                    hintText: 'Enter Your UserName'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  labelText: 'Enter Date of Birth',
                  hintText: 'Enter Your DOB',
                ),
                onTap: () => _selectDate(context),
                readOnly: true,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Enter Password',
                    hintText: 'Enter Your Password'),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Enter Email ID',
                    hintText: 'Enter Your Email ID'
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _mobilenocontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    labelText: 'Enter Mobile No',
                    hintText: 'Enter Your Mobile No'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  _register();
                },
                child: Text('Register')),

          ],
        ),
      ),
    );
  }

  void _register() async {
    print('--------------> _save');
    print('--------------> user Name: ${usernameController.text}');
    print('--------------> Password: ${_passwordController.text}');
    print('--------------> email: ${emailController.text}');
    print('--------------> Mobile no: ${_mobilenocontroller.text}');
    print('--------------> Dob: ${_dobController.text}');

    Map<String, dynamic> row = {
      DatabaseHelper.colUserName: usernameController.text,
      DatabaseHelper.colPassword: _passwordController.text,
      DatabaseHelper.colemail: emailController.text,
      DatabaseHelper.colmobileno: _mobilenocontroller.text,
      DatabaseHelper.coldob: _dobController.text,
    };

    final result = await dbHelper.insertDirectorDetails(
        row, DatabaseHelper.registerTable);

    debugPrint('--------> Inserted Row Id: $result');

    if (result > 0) {
      Navigator.pop(context);
      _showSuccessSnackBar(context, 'Saved');
    }
    // setState(() {
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => DirectorListScreen()));
    // });
  }
  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(new SnackBar(content: new Text(message)));
  }
}
