part of 'userlogin_bloc.dart';

abstract class UserloginEvent extends Equatable {
  const UserloginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends UserloginEvent {
  final String email;
  final String password;
  LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email , password]; 

  @override 
  String toString() =>    'LoginButtonPressed { email: $email, password: $password }';
}
