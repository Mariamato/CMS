import 'package:flutter/material.dart';
import 'package:municipal_cms/service/auth.dart';
import 'screens/home_page.dart';
import 'package:provider/provider.dart';


void main() { 
runApp(
  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        //Provider(create: (context) => SomeOtherClass()),
      ],
      child: const MyApp(),
),);
}


