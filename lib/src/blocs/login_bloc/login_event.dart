import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
 const LoginEvent();
 @override
  List<Object> get props => [];
}
class SaveUser extends LoginEvent{}
class VerifyEvent extends LoginEvent{
   final String email;
   final String password;

  const VerifyEvent({required this.email,required this.password});

}