import 'package:chat_app/cubit/auth_cubits/login_cubit/login_states.dart';
import 'package:chat_app/helpers/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());

  login(String email, String password) async {
    emit(LoadingLoginState());
    try {
      await Helpers.AUTH
          .signInWithEmailAndPassword(email: email, password: password);

      emit(SuccessLoginState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(FailureLoginState(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(FailureLoginState(errorMessage: 'Wrong password provided for that user.'));
      } else if (e.code == 'invalid-email') {
        emit(FailureLoginState(errorMessage: 'The email address is invalid.'));
      } else {
        emit(FailureLoginState(errorMessage: e.message ?? 'An unknown error occurred.'));
      }
    }
    catch (e) {
      emit(ErrorLoginState(e.toString()));
    }
  }
}
