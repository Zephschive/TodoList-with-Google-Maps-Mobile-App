import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todolist_googlemaps/auth/pages/login_page.dart';
import 'package:flutter_todolist_googlemaps/firebase_options.dart';
import 'package:flutter_todolist_googlemaps/screens/home_page.dart';
import 'package:flutter_todolist_googlemaps/theme/colors/light_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
   MyApp({super.key});
   
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: LightColors.kDarkBlue,
          displayColor: LightColors.kDarkBlue,
          fontFamily: 'Poppins'
        )
      ),
      home: LoginPage()    
      );
  }
}


