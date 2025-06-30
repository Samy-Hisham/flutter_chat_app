import 'package:chat_app/cubit/auth_cubits/auth_states.dart';
import 'package:chat_app/helpers/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<AuthState> {
  RegisterCubit() : super(InitialAuthState());

  register(String email, String password) async {
    emit(LoadingAuthState());
    try {
      await Helpers.AUTH.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(AuthenticatedState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(UnauthenticatedState(errorMessage: 'The password is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(UnauthenticatedState(errorMessage: 'The email is already in use.'));
      } else if (e.code == 'invalid-email') {
        emit(UnauthenticatedState(errorMessage: 'The email address is invalid.'));
      } else {
        emit(UnauthenticatedState(errorMessage: e.message ?? 'An unknown error occurred.'));
      }
    }
    catch (e) {
      // If there's an error, emit unauthenticated state with error message
      emit(ErrorAuthState(errorMessage: e.toString()));
    }
  }
}
