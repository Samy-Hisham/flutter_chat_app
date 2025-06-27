import 'package:chat_app/helpers/helpers.dart';
import 'package:chat_app/widget/custom_btn.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: Helpers.kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: [
                SizedBox(height: 75),
                // Spacer(flex: 2),
                Image.asset('assets/images/scholar.png', height: 100),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ],
                  ),
                ),
                // Spacer(flex: 2),
                Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                CustomTextFormField(
                  hintText: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Password',
                  onChanged: (data) {
                    password = data;
                  },
                ),
                SizedBox(height: 10),
                // CustomButton(text: 'LOGIN', onTap:  (){}),
                CustomBtn(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Helpers.showSnackBar(context, 'Login successful!');
                        // MOVE TO HOME VIEW
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          Helpers.showSnackBar(
                            context,
                            'No user found for that email.',
                          );
                        } else if (e.code == 'wrong-password') {
                          Helpers.showSnackBar(
                            context,
                            'Wrong password provided for that user.',
                          );
                        } else {
                          Helpers.showSnackBar(
                            context,
                            'An error occurred: ${e.message}',
                          );
                        }
                      } catch (e) {
                        Helpers.showSnackBar(
                          context,
                          'An unexpected error occurred: $e',
                        );
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  txt: 'LOGIN',
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to Register View
                        Navigator.pushNamed(
                          context,
                          Helpers.REGISTER_VIEW_ROUTE,
                        );
                      },
                      child: Text(
                        ' Register',
                        style: TextStyle(color: Color(0xffC7EDE6)),
                      ),
                    ),
                  ],
                ),
                // Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential login = await Helpers.AUTH.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
