import 'package:chat_app/cubit/auth_cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/cubit/auth_cubits/login_cubit/login_states.dart';
import 'package:chat_app/cubit/simple_bloc_obs.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:chat_app/view/chat_view.dart';
import 'package:chat_app/view/login_view.dart';
import 'package:chat_app/view/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'cubit/auth_cubits/register_cubit/register_cubit.dart';
import 'helpers/helpers.dart';

void main() async {
  Bloc.observer = SimpleBlocObs();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const ChatApp(),
    ),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        Helpers.LOGIN_VIEW_ROUTE: (context) => LoginView(),
        Helpers.REGISTER_VIEW_ROUTE: (context) => RegisterView(),
        Helpers.CHAT_VIEW_ROUTE: (context) => ChatView(),
      },
      initialRoute: Helpers.LOGIN_VIEW_ROUTE,
    );
  }
}
