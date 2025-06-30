import 'package:chat_app/cubit/auth_cubits/auth_states.dart';
import 'package:chat_app/helpers/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<AuthState> {
  LoginCubit() : super(InitialAuthState());

  login(String email, String password) async {
    emit(LoadingAuthState());
    try {
      await Helpers.AUTH
          .signInWithEmailAndPassword(email: email, password: password);

      emit(AuthenticatedState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(UnauthenticatedState(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(UnauthenticatedState(errorMessage: 'Wrong password provided for that user.'));
      } else if (e.code == 'invalid-email') {
        emit(UnauthenticatedState(errorMessage: 'The email address is invalid.'));
      } else {
        emit(UnauthenticatedState(errorMessage: e.message ?? 'An unknown error occurred.'));
      }
    }
    catch (e) {
      emit(ErrorAuthState(errorMessage: e.toString()));
    }
  }
}
