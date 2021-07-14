part of 'userauth_bloc.dart';

abstract class UserauthState extends Equatable {
  const UserauthState();
  
  @override
  List<Object> get props => [];
}

// class UserauthInitial extends UserauthState {} 

class AuthenticationUninitialized extends UserauthState {}
 
class AuthenticatedAuthenticated extends UserauthState {} 

class AuthenticationUnauthenticated extends UserauthState{} 
class  AuthenticationLoading extends UserauthState {}