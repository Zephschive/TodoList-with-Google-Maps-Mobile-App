import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todolist_googlemaps/auth/components/my_button.dart';
import 'package:flutter_todolist_googlemaps/auth/components/my_textfield.dart';
import 'package:flutter_todolist_googlemaps/auth/components/square_tile.dart';
import 'package:flutter_todolist_googlemaps/auth/pages/signup_page.dart';
import 'package:flutter_todolist_googlemaps/screens/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
 

  @override
  Widget build(BuildContext context) 
  
  {
     void signUserIn() async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: usernameController.text, password: passwordController.text).catchError((error, stackTrace) => print(error.toString()))
  .then((value) =>FirebaseFirestore.instance.collection('users').add({
    'users':usernameController.text,
    'password':passwordController.text,
  }).catchError((errorr, stackTrace) => print(errorr.toString())).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) { return HomePage();}))));

  
  }
   void signinwithGoogle() async{
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await guser!.authentication;

    final cred= GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

   await FirebaseAuth.instance.signInWithCredential(cred);
   
   Navigator.push(context, MaterialPageRoute(builder: (context) { return HomePage();}));
   
   }
   
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
      
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
      
                const SizedBox(height: 50),
      
                // welcome back, you've been missed!
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
      
                const SizedBox(height: 25),
      
                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Email',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
      
                const SizedBox(height: 25),
      
                // sign in button
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn,
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
      
                const SizedBox(height: 20),
      
                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    // google button
                  GestureDetector
                  (
                    onTap: (){
                      signinwithGoogle();
                    },
                    child: SquareTile(imagePath: "assets/images/google.png")),
      
                    SizedBox(width: 25),
      
                    // apple button
                    SquareTile(imagePath: "assets/images/apple.png")
                  ],
                ),
      
                const SizedBox(height: 50),
      
                // not a member? register now
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => signup(),
                            ),
                          );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
