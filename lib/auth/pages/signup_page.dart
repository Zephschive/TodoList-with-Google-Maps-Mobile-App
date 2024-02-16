 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:flutter_todolist_googlemaps/auth/pages/login_page.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
 
 class signup extends StatefulWidget {
   const signup({super.key});
 
   @override
   State<signup> createState() => _signupState();
 }
 
 class _signupState extends State<signup> {
   final usernameController = TextEditingController();
  final passwordController = TextEditingController();
   @override
   Widget build(BuildContext context) {

    void signup() async{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: usernameController.text, password: passwordController.text).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) { return LoginPage();})));
    }
     return SafeArea(
       child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
     
                // logo
                const Icon(
                  Icons.person_add,
                  size: 100,
                ),
     
                const SizedBox(height: 50),
     
                // welcome back, you've been missed!
                Text(
                  'Create A New Account',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
     
                const SizedBox(height: 25),
     
                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
     
                const SizedBox(height: 10),
     
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
     
                const SizedBox(height: 10),
     
                // forgot password?
               
     
                const SizedBox(height: 25),
     
                // sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: signup,
                ),
     
                const SizedBox(height: 50),
     
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
     
                const SizedBox(height: 10),
     
                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png'),
     
                    SizedBox(width: 25),
     
                    // apple button
                    SquareTile(imagePath: 'lib/images/apple.png')
                  ],
                ),
     
                const SizedBox(height: 50),
     
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already A Member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));},
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
         ),
     );;
   }
 }