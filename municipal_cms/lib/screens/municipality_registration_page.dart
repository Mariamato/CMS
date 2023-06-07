// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:municipal_cms/screens/municipality_login_page.dart';
import 'package:municipal_cms/service/auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MunicipalityRegistrationPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _municipalityNameController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _physicalAddressController =
      TextEditingController();
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();

  MunicipalityRegistrationPage({super.key});

  void _register(BuildContext context) async {
    String password = _passwordController.text;
    //String confirmPassword = _ConfirmPasswordController.text;
    String email = _emailController.text;
    String phoneNumber = _contactController.text;
    String municipality = _municipalityNameController.text;
    String location = _physicalAddressController.text;
    var csrfResponse = await http.get(Uri.parse('/sanctum/csrf-cookie'));
    var csrfToken = csrfResponse.headers['set-cookie'] ?? '';

    var url = Uri.parse('http://127.0.0.1:8000/api/register');
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'X-XSRF-TOKEN': csrfToken,
      'user_type': 'Municipality'
    };
    var data = {
      'email': email,
      'password': password,
      'Location': location,
      'PhoneNumber': phoneNumber,
      'MunicipalityName': municipality,
    };
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    bool isEmailValid = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9.]+$').hasMatch(email);

    bool isPasswordValid = RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(password);
    if (!isEmailValid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Email'),
          content: const Text('Please enter a valid email address.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (!isPasswordValid) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Password'),
          content: const Text(
              'Please enter a password with at least 8 characters, including one uppercase letter, one lowercase letter, one digit, and one special character.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }else if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Registration'),
                content: const Text('Municipality registered successfully'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MunicipalityLoginPage()),
      );
    } else {
      print(response.body);
      // Display an error message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Failed'),
          content: const Text('An error occurred during registration.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _togglePasswordVisibility() {
    _showPassword = !_showPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Jisajili '),
        ),
        body: Container(
          height: 10000.0,
          width: 10000.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/homepage.jpeg'), fit: BoxFit.cover),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  height: 500.0,
                  width: 600.0,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  controller: _municipalityNameController,
                                  decoration: const InputDecoration(
                                      labelText: 'Municipality Name',
                                      icon: Icon(Icons.location_city)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Municipality Name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    icon: Icon(Icons.email),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    icon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: _togglePasswordVisibility,
                                    ),
                                  ),
                                  obscureText: !_showPassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  decoration: const InputDecoration(
                                    labelText: 'Confirm password',
                                    icon: Icon(Icons.lock),
                                  ),
                                  obscureText: !_showPassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password entered does not match';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _physicalAddressController,
                                  decoration: const InputDecoration(
                                      labelText: 'location',
                                      icon: Icon(Icons.mail)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Location';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  controller: _contactController,
                                  decoration: const InputDecoration(
                                      labelText: 'Phone Number',
                                      icon: Icon(Icons.phone_rounded)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Phone number';
                                    }
                                    return null;
                                  },
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(15.0),
                                  alignment: Alignment.topCenter,
                                  child: ElevatedButton(
                                    child: const Text('Register'),
                                    onPressed: () {
                                      Map creds = {
                                        'email': _emailController.text,
                                        'password': _passwordController.text,
                                        'PhoneNumber': _contactController.text,
                                        'Location':
                                            _physicalAddressController.text,
                                        'MunicipalityName':
                                            _municipalityNameController.text,
                                        'CornfirmPassword':
                                            _confirmPasswordController.text,
                                        'DeviceName': 'mobile',
                                      };

                                      if (_formKey.currentState != null) {
                                        if (_formKey.currentState!.validate()) {
                                          Provider.of<Auth>(context,
                                                  listen: false)
                                              .register(creds: creds);
                                          _register(context);
                                        }
                                      }
                                    },
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
