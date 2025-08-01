import 'package:chat_app/cubit/auth_cubits/login_cubit/login_states.dart';
import 'package:chat_app/cubit/auth_cubits/register_cubit/register_states.dart';
import 'package:chat_app/helpers/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialRegisterState());

  register({required String email, required String password}) async {
    emit(LoadingRegisterState());
    try {
      await Helpers.AUTH.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(SuccessRegisterState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(FailureRegisterState(errorMessage: 'The password is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(FailureRegisterState(errorMessage: 'The email is already in use.'));
      } else if (e.code == 'invalid-email') {
        emit(FailureRegisterState(errorMessage: 'The email address is invalid.'));
      } else {
        emit(FailureRegisterState(errorMessage: e.message ?? 'An unknown error occurred.'));
      }
    }
    catch (e) {
      // If there's an error, emit unauthenticated state with error message
      emit(ErrorRegisterState(errorMessage: e.toString()));
    }
  }
}
