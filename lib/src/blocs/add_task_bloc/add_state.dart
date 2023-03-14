class AddState {
  const AddState();
}

class Request extends AddState {}

class LoadingData extends AddState {}

class Error extends AddState {
  final String error;
  Error({required this.error});
}

class NoData extends AddState {}

class NetworkError extends AddState {}

class Success extends AddState {
  final String? status;
  const Success({required this.status});
}
