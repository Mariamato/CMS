

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:municipal_cms/screens/Municipality_page.dart';
import 'package:municipal_cms/service/auth.dart';
import 'package:municipal_cms/screens/municipality_registration_page.dart';
import 'package:provider/provider.dart';

class MunicipalityLoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _rememberMe = false;

  void _toggleRememberMe() {
    setState(() {
      _rememberMe = !_rememberMe;
    });
  }

  void setState(Null Function() param0) {}

  // void _loginWithGoogle(BuildContext context) {}

  void _togglePasswordVisibility() {
    _showPassword = !_showPassword;
  }

  void _login(BuildContext context) {
    // Add login functionality here
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => MunicipalityPage ()),);
  }
  void _forgotPassword(BuildContext context) {
    // Add forgot password functionality here
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => MunicipalityPage ()),);
  }
  void _register(BuildContext context) {
    // Add registration functionality here

    Navigator.push(context, 
    MaterialPageRoute(builder: (context) =>  MunicipalityRegistrationPage()),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Municipality Login'),
      ),
      body: Container(
        height: 10000.0,
        width: 10000.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/homepage.jpeg'), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0,sigmaY: 10.0),
          child: Center(
            child: SizedBox(
              height: 400.0,
              width: 300.0,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                                    _showPassword ? Icons.visibility : Icons.visibility_off,
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
                            const SizedBox(height: 16.0),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: _rememberMe,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _rememberMe = value!;
                                          });
                                        }),
                                    const Text('Remember me'),
                                  ],
                                ),
                                TextButton(
                                  child: const Text('Register Now'),
                                  onPressed: () => _register(context),
                                ),
                              ],
                            ),
                             Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15.0),
                              alignment: Alignment.topCenter,
                              child: ElevatedButton(
                                child: const Text('Login'),
                                onPressed: () {
                                  Map creds = {
                                    'email': _emailController.text,
                                    'password': _passwordController.text,
                                    'device name': 'mobile',
                                  };

                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!.validate()) {
                                    Provider.of<Auth>(context, listen: false)
                                        .login(creds: creds);
                                    _login(context);
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(4),
                              alignment: Alignment.topCenter,
                              child: TextButton(
                                child: const Text('Forgot password?'),
                                onPressed: () => _forgotPassword(context),
                              ),
                            ),
                            
                            /* const SizedBox(height: 16.0),
                           const Text(
                              'Or login with',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16.0, color: Colors.grey),
                            ),
                           const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon:const Icon(Icons.facebook_outlined),
                                  onPressed: () => _loginWithFacebook(context),
                                ),
                                IconButton(
                                  icon: Icon(icons.google),
                                  onPressed: () => _loginWithGoogle(context),
                                ),
                                IconButton(
                                  icon: Icon(icons.twitter),
                                  onPressed: () => _loginWithTwitter(context),
                                ),
                              ],
                            ),*/
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
}
