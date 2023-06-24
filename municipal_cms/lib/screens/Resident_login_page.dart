// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:municipal_cms/screens/resident_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/visibility_provider.dart';
import 'Resident_registration_page.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ResidentLoginPage extends StatelessWidget {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ResidentLoginPage({super.key});

  void _login(BuildContext context) async {
    String password = _passwordController.text;
    String PhoneNumber = _contactController.text;
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
      'phone': PhoneNumber,
      'password': password,
    };
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", jsonResponse['token']);
      prefs.setInt("userId", jsonResponse['userData']['id']);
      prefs.setString("name", jsonResponse['userData']['name']);
      prefs.setString("email", jsonResponse['userData']['email']);
      prefs.setString("phone", jsonResponse['userData']['phone']);

      //print(prefs.getString("token"));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ResidentPage()),
      );
    }
    if (response.statusCode == 401) {
      print(response.body);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Credentials incorrect'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    if (response.statusCode == 400) {
      // print(response.body);
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
    return ChangeNotifierProvider(
      create: (_) => visibility(),
      child: Scaffold(
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
                          child: Consumer<visibility>(
                              builder: (context, model, _) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
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
                                          model.togglePasswordVisibility();
                                        },
                                        icon: Icon(
                                          model.hidePassword
                                              ? Icons.visibility
                                              : Icons.visibility_off_outlined,
                                        ),
                                      ),
                                    ),
                                    obscureText: !model.hidePassword),
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
                            );
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
