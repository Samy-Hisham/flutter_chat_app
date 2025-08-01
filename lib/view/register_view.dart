import 'package:chat_app/cubit/auth_cubits/login_cubit/login_states.dart';
import 'package:chat_app/cubit/auth_cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/helpers/helpers.dart';
import 'package:chat_app/widget/custom_btn.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../cubit/auth_cubits/register_cubit/register_states.dart';
import '../themes/theme_provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Helpers.CHAT_VIEW_ROUTE,
              (route) => false,
            );
          } else if (state is FailureRegisterState) {
            Helpers.showSnackBar(context, state.errorMessage);
          } else if (state is ErrorRegisterState) {
            Helpers.showSnackBar(context, state.errorMessage);
          }
        },
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is LoadingLoginState,
              child: Scaffold(
                backgroundColor: Provider.of<ThemeProvider>(
                  context,
                ).appBarColor,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        SizedBox(height: 75),
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
                        Row(
                          children: [
                            Text(
                              'REGISTER',
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
                        ),
                        SizedBox(height: 10),
                        CustomBtn(
                          txt: 'REGISTER',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              context.read<RegisterCubit>().register(
                                email: email!,
                                password: password!,
                              );
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'already have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                ' Login',
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
