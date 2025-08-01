import 'package:chat_app/cubit/auth_cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/cubit/auth_cubits/login_cubit/login_states.dart';
import 'package:chat_app/helpers/helpers.dart';
import 'package:chat_app/widget/custom_btn.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

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
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            Navigator.pushNamed(
              context,
              Helpers.CHAT_VIEW_ROUTE,
              arguments: email,
            );
          } else if (state is FailureLoginState) {
            Helpers.showSnackBar(context, state.errorMessage);
          } else if (state is FailureLoginState) {
            Helpers.showSnackBar(context, state.errorMessage);
          }
        },
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is LoadingLoginState,
              child: Form(
                key: formKey,
                child: Scaffold(
                  backgroundColor: Provider.of<ThemeProvider>(
                    context,
                  ).appBarColor,
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView(
                      children: [
                        SizedBox(height: 10,),
                        IconButton(
                          alignment: Alignment.topRight,
                          icon: Icon(
                            Provider.of<ThemeProvider>(context).themeMode ==
                                ThemeMode.dark
                                ? Icons.light_mode
                                : Icons.dark_mode,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            final currentTheme = Provider.of<ThemeProvider>(
                              context,
                              listen: false,
                            );
                            currentTheme.changeTheme(
                              currentTheme.themeMode == ThemeMode.dark
                                  ? ThemeMode.light
                                  : ThemeMode.dark,
                            );
                          },
                        ),
                        SizedBox(height: 55),
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
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
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
                          obscureText: true,
                        ),
                        SizedBox(height: 10),
                        CustomBtn(
                          txt: 'LOGIN',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              // Trigger the login process
                              BlocProvider.of<LoginCubit>(
                                context,
                              ).login(email!, password!);
                            }
                          },
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
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(
                                    context,
                                  ).backgroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
