import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:municipal_cms/service/auth.dart';
import 'package:provider/provider.dart';

class MunicipalityRegistrationPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _municipalityNameController =
      TextEditingController();
  final TextEditingController _physicalAddressController =
      TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController __ConfirmPasswordController =
      TextEditingController();

  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();

  void _register(BuildContext context) async {
    final Form = _formKey.currentState;
    String password = _passwordController.text;
    String confirmPassword = __ConfirmPasswordController.text;
    String email = _emailController.text;
    String phoneNumber = _contactController.text;
    String municipality = _municipalityNameController.text;
    String location = _physicalAddressController.text;
    var form;

    // Send a POST request to your Laravel API for resident registration

    try {
      Dio dio = Dio();
      dio.options.baseUrl = 'http://127.0.0.1:8000/api/';
      dio.options.headers['accept'] = {
        'Applicatio/json'
        // Add any other required headers
      };
      Response response = await dio.post('register', data: {
        // 'ConfirmPassword':confirmPassword,
        'email': email,
        'password': password,
        'Location': location,
        'PhoneNumber': phoneNumber,
        'MunicipalityName': municipality,
      });

      // Handle the response and any further actions (e.g., displaying success message)
      print(response.data);
    } catch (error) {
      // Handle any errors (e.g., displaying error message)
      print(error);
    }
    if (form.validate()) {
      form.save;
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Passwords do not match.'),
        ));
      } else {
        Navigator.pushNamed(context, '/home');
      }
    } else {
      Navigator.pushNamed(context, '/home');
    }
  }

  void _togglePasswordVisibility() {
    _showPassword = !_showPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Jisajili hapa'),
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
                  height: 450.0,
                  width: 600.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextFormField(
                                    controller: _municipalityNameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Municipality Name',
                                      icon: Icon(Icons.location_city_rounded),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Name';
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
                                    controller: __ConfirmPasswordController,
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
                                  TextFormField(
                                    controller: _contactController,
                                    decoration: const InputDecoration(
                                        labelText: 'Phone Number',
                                        icon: Icon(Icons.phone_rounded)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your Name';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20.0,
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
                                          'PhoneNumber':
                                              _contactController.text,
                                          'Location':
                                              _physicalAddressController.text,
                                          'MunicipalityName':
                                              _municipalityNameController.text,
                                          'ConfirmPassword':
                                              __ConfirmPasswordController,
                                          'DeviceName': 'mobile',
                                        };
                                        if (_formKey.currentState != null) {
                                          if (_formKey.currentState!
                                              .validate()) {
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
