// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:municipal_cms/screens/resident_page.dart';
import 'Resident_registration_page.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ResidentLoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  ResidentLoginPage({super.key});

  void _login(BuildContext context) async {
    String password = _passwordController.text;
    String email = _emailController.text;
    var csrfResponse = await http.get(Uri.parse('/sanctum/csrf-cookie'));
    var csrfToken = csrfResponse.headers['set-cookie'] ?? '';

    var url = Uri.parse('http://127.0.0.1:8000/api/login');
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'accept': 'appliction/json',
      'X-XSRF-TOKEN': csrfToken,
      'user_type': 'Resident'
    };
    var data = {
      'email': email,
      'password': password,
    };
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ResidentPage()),
      );
    } 
    if (response.statusCode == 400) {
      print(response.body);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Credentials incorrect, Try again'),
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

  void _register(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resident Login'),
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
          child: Center(
            child: SizedBox(
              height: 400.0,
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (input) => input!.contains("@.")
                                  ? 'Email Id should be valid'
                                  : null,
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                                controller: _passwordController,
                                validator: (input) => input!.length < 8
                                    ? 'Password should atleast be with 8 characters'
                                    : null,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  icon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      }, icon: Icon(
                                        hidePassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility,
                                      ),
                                      ),
                                ),
                                obscureText: !hidePassword),
                            const SizedBox(height: 16.0),
                            const SizedBox(height: 16.0),
                            TextButton(
                              child: const Text('Register Now'),
                              onPressed: () => _register(context),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15.0),
                              alignment: Alignment.topCenter,
                              child: ElevatedButton(
                                child: const Text('Login'),
                                onPressed: () => _login(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
