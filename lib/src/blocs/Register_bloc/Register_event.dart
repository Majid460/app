import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable{
 const SignUpEvent();
 @override
  List<Object> get props => [];
}
class SaveUser extends SignUpEvent{}
class RegisterEvent extends SignUpEvent{
  final String email;
  final String password;
  final String name;
   final String phone;
  const RegisterEvent({required this.email,required this.password,required this.name,required this.phone});

}