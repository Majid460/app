class ProfileStateUpdate {
  const ProfileStateUpdate();
}

class Request extends ProfileStateUpdate {}

class LoadingUser extends ProfileStateUpdate {}

class Error extends ProfileStateUpdate {
  final String? error;
  const Error({required this.error});
}

class WeakPassword extends ProfileStateUpdate {}

class EmailInUse extends ProfileStateUpdate {}

class NetworkError extends ProfileStateUpdate {}

class Success extends ProfileStateUpdate {}
