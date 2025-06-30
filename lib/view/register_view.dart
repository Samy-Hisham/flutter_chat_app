import 'package:chat_app/cubit/auth_cubits/auth_states.dart';
import 'package:chat_app/cubit/auth_cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/helpers/helpers.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
    return BlocListener<RegisterCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Helpers.CHAT_VIEW_ROUTE,
            (route) => false,
          );
        } else if (state is UnauthenticatedState) {
          Helpers.showSnackBar(context, state.errorMessage);
        } else if (state is ErrorAuthState) {
          Helpers.showSnackBar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<RegisterCubit, AuthState>(
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LoadingAuthState,
            child: Scaffold(
              backgroundColor: Helpers.kPrimaryColor,
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
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(
                              context,
                            ).register(email!, password!);
                          }
                          // if (state is AuthenticatedState) {
                          //   Navigator.pushNamedAndRemoveUntil(
                          //     context,
                          //     Helpers.CHAT_VIEW_ROUTE,
                          //     (route) => false,
                          //   );
                          // } else if (state is UnauthenticatedState) {
                          //   Helpers.showSnackBar(context, state.errorMessage);
                          // }
                        },
                        child: Text('REGISTER'),
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
                              style: TextStyle(color: Color(0xffC7EDE6)),
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
    );
  }
}
