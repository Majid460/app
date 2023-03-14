import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class SaveUser extends ProfileEvent {}

class UpdateEvent extends ProfileEvent {
  final String email;
  final String name;
  final String phone;
  const UpdateEvent(
      {required this.email, required this.name, required this.phone});
}
