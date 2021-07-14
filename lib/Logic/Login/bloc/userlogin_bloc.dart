import 'dart:async';

import 'package:aper/Logic/auth/bloc/userauth_bloc.dart';
import 'package:aper/Respo/Login/loginRespo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'userlogin_event.dart';
part 'userlogin_state.dart';

class UserloginBloc extends Bloc<UserloginEvent, UserloginState> {
//  REPOSTIPRY FOR
  final CustomUserLoginRespo userRepository;
  final UserauthBloc authenticationBloc;

  UserloginBloc(
      {required this.authenticationBloc, required this.userRepository})
      : super(UserloginInitial());

  UserloginState get initialState => UserloginInitial();

  @override
  Stream<UserloginState> mapEventToState(
    UserloginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final usertoken =
            await userRepository.loginnow(event.email, event.password);
        yield UserloginInitial();
      } catch (error) {
         yield LoginFailure(error: error.toString());
      }
    }
  }
}
