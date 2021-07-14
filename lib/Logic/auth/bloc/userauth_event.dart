part of 'userauth_bloc.dart';

abstract class UserauthEvent extends Equatable {
  const UserauthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends UserauthEvent {}

class LoggedIn extends UserauthEvent {
  final String usertoken;
  LoggedIn({required this.usertoken});

  @override
  List<Object> get props => [usertoken];

  @override
   String toString() => 'LoggedIn { usertoken: $usertoken }'; 

}

class LoggedOut extends UserauthEvent {}
