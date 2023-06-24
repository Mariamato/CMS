import 'dart:ui';
import 'package:flutter/material.dart';


final TextEditingController _TaskController = TextEditingController();
final TextEditingController _LocationController = TextEditingController();

void _ViewSchedule(BuildContext context) {
  // Add view schedule functionality here
}

void _SubmitReport(BuildContext context) {}

class ServiceProviderPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  ServiceProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Service provider page")),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextButton(
                      onPressed: (() => _ViewSchedule(context)),
                      child: const Text("Upload Task schedule here...")),
                  Center(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: 500.0,
                        width: 400.0,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: _TaskController,
                                      decoration: const InputDecoration(
                                        labelText: 'Task performed:',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter task performed';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _LocationController,
                                      decoration: const InputDecoration(
                                        labelText: 'Location:',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the location task performed';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16.0),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Day:',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the day task performed';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16.0),
                                  
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // Save report to backend server here
                                          print('Submitting report');
                                        }
                                        _SubmitReport(context);
                                      },
                                      child: const Text('Submit'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
