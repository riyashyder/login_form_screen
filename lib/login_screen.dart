import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_form_screen/databasehelper.dart';
import 'package:login_form_screen/register_screen.dart';
import 'package:login_form_screen/userdetailslistscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formField = GlobalKey<FormState>();
  var _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _dobController = TextEditingController();
  DateTime? _selectedDate;
  bool passwordToggle = true;

  late DatabaseHelper _databaseHelper;

  Future<void> _initializeDatabase() async {
    _databaseHelper = DatabaseHelper();
    await _databaseHelper.initialization();
  }

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }


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

  // Handler for the "Login" button
  Future<void> _loginUser() async {
    if (_formField.currentState!.validate()) {
      if(_databaseHelper==null){
        return;
      }
      // Validate the form fields
      // Assume your DatabaseHelper has a method for checking login credentials
      bool loginSuccessful = await _databaseHelper.checkLoginCredentials(
        _usernameController.text,
        _passwordController.text,
      );

      if (loginSuccessful) {
        // Navigate to the list screen or any other screen on successful login
        Navigator.of(context).pushReplacement( // Use pushReplacement to replace the current screen
          MaterialPageRoute(
            builder: (context) => DirectorListScreen(),
          ),
        );
      } else {
        // Show an error message or handle unsuccessful login
        // For example, you can show a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid username or password'),
          ),
        );
      }
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child:Form(
            key: _formField,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Enter User Name',
                    hintText: 'Enter Your User Name',
                  ),
                ),
              ),
              SizedBox(
                height: 30,
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
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordController,
                  obscureText: passwordToggle,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          passwordToggle = !passwordToggle;
                        });
                      },
                      child: Icon(passwordToggle
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Password';
                    } else if (_passwordController.text.length < 6) {
                      return 'Password should be min 6 characters';
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _loginUser();
                },
                child: Text('Login'),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ));
                },
                child: Text('Register'),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),),
      ),
    );
  }
}
