class SignUpState {
  const SignUpState();
}

class Request extends SignUpState {}

class LoadingUser extends SignUpState {}

class Error extends SignUpState {}

class WeakPassword extends SignUpState {}

class EmailInUse extends SignUpState {}

class NetworkError extends SignUpState {}

class Success extends SignUpState {
  final String? email;
  const Success({required this.email});
}
