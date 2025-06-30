class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class AuthenticatedState extends AuthState {
  // final String userId;
  //
  // AuthenticatedState(this.userId);
}

class UnauthenticatedState extends AuthState {
  final String errorMessage;

  UnauthenticatedState({required this.errorMessage});
}

class ErrorAuthState extends AuthState {
  final String errorMessage;

  ErrorAuthState({required this.errorMessage});
}

class AuthState {}