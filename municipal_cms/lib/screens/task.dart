import 'dart:ui';

import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("Request for a pickup")),
      ),
      body: Container(
        height: 10000.0,
          width: 10000.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/homepage.jpeg'), fit: BoxFit.cover),
          ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.5,sigmaY: 10.5),
          child: SizedBox(
            height: 400.0,
            width: 300.0,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/resindent.jpg"),
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Task:',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter task required';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Location:',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the location of the task';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Task description:',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please describe the task:';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                       ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                
                                  print('Submitting the task');
                                }
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
    );
  }
}
