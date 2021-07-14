import 'dart:async';
import 'package:aper/Respo/Login/loginRespo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'userauth_event.dart';
part 'userauth_state.dart';

class UserauthBloc extends Bloc<UserauthEvent, UserauthState> {
  final CustomUserLoginRespo userRepository;

  UserauthBloc({required this.userRepository})
      : super(AuthenticationUninitialized());

  UserauthState get initialState => AuthenticationUninitialized();

  @override
  Stream<UserauthState> mapEventToState(
    UserauthEvent event,
  ) async* {
    // === WHEN APP STARATED EVENT
    print(event);
    if (event is AppStarted) {
      try {
         bool hasToken = await userRepository.hasToken();
        if (hasToken) {
          yield AuthenticatedAuthenticated();
        } else {
          yield AuthenticationUnauthenticated();
        }
      } catch (e) {
        print(e);
      }
    }
    //  2. WHEN EVENT IS LOGIN
    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.usertoken);
      yield AuthenticatedAuthenticated();
    }

    // 3. WHEN EVENT IS LOGGOUT
    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
