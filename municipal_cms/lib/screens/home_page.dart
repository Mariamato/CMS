import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:municipal_cms/screens/Service_provider_login_pag.dart';
import 'package:municipal_cms/service/auth.dart';
import 'package:municipal_cms/screens/lipia_hapa.dart';
import 'package:municipal_cms/screens/municipality_login_page.dart';
import 'package:municipal_cms/screens/task.dart';
import 'package:provider/provider.dart';
import 'Resident_login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Municipal Cleaning Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/Task': (context) => TaskPage(),
        '/resident': (context) => ResidentLoginPage(),
        '/ServiceProviderLoginpage': (context) => ServiceProviderLoginPage(),
        '/Municipality': (context) => MunicipalityLoginPage(),
        '/payment': (context) => LipaHapaPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Municipal Cleaning Management App')),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/homepage.jpeg'), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Welcome to the',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Municipal Cleaning Management App!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Center(
                child: SizedBox(
                    height: 200,
                    width: 300,
                    child: Card(
                        child:
                            Image(image: AssetImage('assets/homepage.jpeg')))),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(child: Consumer<Auth>(builder: (context, auth, child) {
                if (!auth.authenticated) {
                  return GridView.count(
                    crossAxisCount: 3,
                    children: [
                      _buildMenuItem(
                        context,
                        'Resident',
                        Icons.person,
                        '/resident',
                      ),
                      _buildMenuItem(
                        context,
                        'Service Provider',
                        Icons.local_car_wash,
                        '/ServiceProviderLoginpage',
                      ),
                      _buildMenuItem(
                        context,
                        'Municipality',
                        Icons.location_city_rounded,
                        '/Municipality',
                      ),
                    ],
                  );
                } else {
                  return  GridView.count(
                    crossAxisCount: 3,
                    children: [
                      _buildMenuItem(
                        context,
                        'Resident',
                        Icons.person,
                        '/resident',
                      ),
                      _buildMenuItem(
                        context,
                        'Service Provider',
                        Icons.local_car_wash,
                       '/resident',
                      ),
                      _buildMenuItem(
                        context,
                        'Municipality',
                        Icons.location_city_rounded,
                       '/resident',
                      ),
                    ],
                  );
                }
              })),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String title, IconData iconData, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 8.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
