import 'package:aper/Respo/Login/loginRespo.dart';
import 'package:aper/Ui/newproduct_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Logic/auth/bloc/userauth_bloc.dart';
import 'Respo/allrepopth.dart';
import 'Ui/signup and login/signup_screen.dart';
import 'package:bloc/bloc.dart';

// / Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();

  final userRepository = CustomUserLoginRespo();
  runApp(
    BlocProvider<UserauthBloc>(
      create: (context) {
        return UserauthBloc(userRepository: userRepository)..add(AppStarted());
      },
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final CustomUserLoginRespo userRepository;
  MyApp({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MainBloc.allBlocs(),
      child: MaterialApp(
          locale: const Locale('mn', 'MN'),
          title: ' MyApp',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: HomeBuilderApp(userRepository: userRepository)),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                    APP Started time                                     */
/* -------------------------------------------------------------------------- */

class HomeBuilderApp extends StatelessWidget {
  final CustomUserLoginRespo userRepository;

  HomeBuilderApp({Key? key, required this.userRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserauthBloc, UserauthState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthenticatedAuthenticated) {
            return ProductDataList();
          }
          if (state is AuthenticationUnauthenticated) {
            return SignUpScreen();
          }
          if (state is AuthenticationLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
