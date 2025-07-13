class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  // final String userId;
  //
  // AuthenticatedState(this.userId);
}

class FailureLoginState extends LoginState {
  final String errorMessage;

  FailureLoginState({required this.errorMessage});
}

class ErrorLoginState extends LoginState {
  final String errorMessage;

  ErrorLoginState(this.errorMessage);

}

class LoginState {}