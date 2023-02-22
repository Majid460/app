class LoginState{
  const LoginState();
}
class Request extends LoginState{}
class LoadingUser extends LoginState{}
class Error extends LoginState{}
class EmailNotExist extends LoginState{}
class PasswordNotMatch extends LoginState{}
class NetworkError extends LoginState{}
class Success extends LoginState{
  final String? email;
  const Success({required this.email});
}