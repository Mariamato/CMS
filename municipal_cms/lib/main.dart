import 'package:flutter/material.dart';
import 'package:municipal_cms/service/user_provider.dart';
import 'screens/home_page.dart';
import 'package:provider/provider.dart';


void main() { 
runApp(
  MultiProvider(
      providers: [
  
        ChangeNotifierProvider(create: (context) => UserProvider()),
             ],
      child: const MyApp(),
),);
}


