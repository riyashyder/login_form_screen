import 'package:flutter/material.dart';
import 'package:login_form_screen/user-details_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserDetailsModel userDetails;

  UserDetailsScreen(this.userDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ID: ${userDetails.id}'),
          Text('Username: ${userDetails.userName}'),
          Text('Password: ${userDetails.password}'),
          Text('Email: ${userDetails.email}'),
          Text('Mobile No: ${userDetails.mobileno}'),
          Text('DOB: ${userDetails.dob}'),
        ],
      ),
    );
  }
}
