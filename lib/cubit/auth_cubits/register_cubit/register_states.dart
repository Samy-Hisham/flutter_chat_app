class InitialRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class SuccessRegisterState extends RegisterState {
  // final String userId;
  // AuthenticatedState(this.userId);
}

class FailureRegisterState extends RegisterState {
  final String errorMessage;

  FailureRegisterState({required this.errorMessage});

}

class ErrorRegisterState extends RegisterState {
  final String errorMessage;

  ErrorRegisterState({required this.errorMessage});
}

class RegisterState {}
