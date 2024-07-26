import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<Map<String, String>> _users = [];

  void _login() {
    if(_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final password = _passwordController.text;

      bool userExists = _users.any((user) => user['name'] == name && user['password'] == password);
      if(userExists) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()),);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid Credentials')),
        );
      }
    }
  }

  void _register() {
    if(_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final password = _passwordController.text;

      _users.add({'name': name, 'password': password});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User Register Successfully')),
      );
      _nameController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: _login, child: Text('Login')),
                  ElevatedButton(onPressed: _register, child: Text('Register')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}