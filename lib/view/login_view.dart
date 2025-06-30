import 'package:chat_app/cubit/auth_cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/cubit/auth_cubits/auth_states.dart';
import 'package:chat_app/helpers/helpers.dart';
import 'package:chat_app/widget/custom_btn.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

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
    return BlocListener<LoginCubit, AuthState>(listener: (context, state) {
      if (state is AuthenticatedState) {
        Navigator.pushNamed(
          context,
          Helpers.CHAT_VIEW_ROUTE,
        );
      }else if (state is UnauthenticatedState) {
        Helpers.showSnackBar(context, state.errorMessage);
      }
      else if (state is ErrorAuthState) {
        Helpers.showSnackBar(context, state.errorMessage);
      }
    },
    child:  BlocBuilder<LoginCubit, AuthState>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoadingAuthState,
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
                    CustomBtn(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(
                            context,
                          ).login(email!, password!);

                        //     if (state is AuthenticatedState) {
                        //     Navigator.pushNamed(
                        //       context,
                        //       Helpers.CHAT_VIEW_ROUTE,
                        //     );
                        //   } else if (state is UnauthenticatedState) {
                        //     isLoading = false;
                        //     Helpers.showSnackBar(context, state.errorMessage);
                        //   }
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
      },
    )
    );
  }

  // Future<void> loginUser() async {
  //   UserCredential login = await Helpers.AUTH.signInWithEmailAndPassword(
  //     email: email!,
  //     password: password!,
  //   );
  // }
}
