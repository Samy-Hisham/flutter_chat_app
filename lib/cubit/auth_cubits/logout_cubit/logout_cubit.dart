import 'package:chat_app/cubit/auth_cubits/logout_cubit/logout_states.dart';
import 'package:chat_app/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(InitialLogoutState());

  Future<void> logout() async {
    emit(LoadingLogoutState());
    try {
      await Helpers.AUTH.signOut();
      emit(SuccessLogoutState());
    } catch (e) {
      emit(FailureLogoutState());
    }
  }
}