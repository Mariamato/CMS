// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:municipal_cms/screens/Service_provider_login_pag.dart';
import 'package:municipal_cms/service/auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ServiceProviderRegistrationPage extends StatelessWidget {
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _municipalityNameController =
      TextEditingController();
  final TextEditingController _ConfirmPasswordController =
      TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _physicalAddressController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();

  ServiceProviderRegistrationPage({super.key});

  void _register(BuildContext context) async {
    String password = _passwordController.text;
    //String confirmPassword = _ConfirmPasswordController.text;
    String fullName = _fullNameController.text;
    String email = _emailController.text;
    String phoneNumber = _contactController.text;
    String municipality = _municipalityNameController.text;
    String location = _physicalAddressController.text;
    String speciality = _specialityController.text;
    var csrfResponse = await http.get(Uri.parse('/sanctum/csrf-cookie'));
    var csrfToken = csrfResponse.headers['set-cookie'] ?? '';

    var url = Uri.parse('http://127.0.0.1:8000/api/register');
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'X-XSRF-TOKEN': csrfToken,
      'user_type': 'ServiceProvider'
    };
    var data = {
      'FullName': fullName,
      'email': email,
      'password': password,
      'Location': location,
      'PhoneNumber': phoneNumber,
      'MunicipalityName': municipality,
      'Speciality': speciality,
    };
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );


    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Registration'),
                content: const Text('Service Provider registered successfully'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ServiceProviderLoginPage()),
      );
    }
     if(response.statusCode == 422){
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
                                  controller: _fullNameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Full Name',
                                    icon: Icon(Icons.person),
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
                                  validator: (input) => input!.contains("@.")
                                  ? 'Email Id should valid'
                                  : null,
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    icon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        hidePassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: !hidePassword,
                                  validator: (input) => input!.length < 8
                                    ? 'Password should atleast be with 8 characters'
                                    : null,
                                ),
                                TextFormField(
                                  controller: _ConfirmPasswordController,
                                  decoration: const InputDecoration(
                                    labelText: 'Confirm password',
                                    icon: Icon(Icons.lock),
                                  ),
                                  obscureText: hidePassword,
                                  validator: (input) => input!.length < 8
                                    ? 'Password should atleast be with 8 characters'
                                    : null,
                                ),
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
                                  controller: _specialityController,
                                  decoration: const InputDecoration(
                                      labelText: 'Speciality',
                                      icon: Icon(Icons.location_city)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Speciality';
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
                                        'PhoneNumber': _contactController.text,
                                        'Location':
                                            _physicalAddressController.text,
                                        'MunicipalityName':
                                            _municipalityNameController.text,
                                        'CornfirmPassword':
                                            _ConfirmPasswordController.text,
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
  
  void setState(Null Function() param0) {}
}
