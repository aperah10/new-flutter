import 'package:aper/Respo/Login/loginRespo.dart';
import 'package:aper/Ui/newproduct_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Logic/ProductL/bloc/productp_bloc.dart';
import 'Logic/auth/bloc/userauth_bloc.dart';
import 'Respo/allrepopth.dart';
import 'Respo/product/ProdRespo.dart';
import 'Ui/product_page.dart';
import 'Ui/signup and login/login_screen.dart';
import 'Ui/signup and login/signup_screen.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

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
  // runApp(MyApp());

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
  MyApp({Key ? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    MultiBlocProvider(
      // providers:
          providers: MainBloc.allBlocs(),
      //     [
      //   BlocProvider(
      //     create: (context) => ProductpBloc(prodRespo: ProductDataRespo()),
      //     child: ProductDataShow(),
      //   ),
      //   BlocProvider(
      //     create: (context) => ProductpBloc(prodRespo: ProductDataRespo()),
      //     child: ProductDataList(),
      //   )
      // ],
      child: MaterialApp(
        locale: const Locale('mn', 'MN'),
        title: ' MyApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        // home: Scaffold(body: Center(child: Text(' this sis home'),),),
        home:
            BlocBuilder<UserauthBloc, UserauthState>(builder: (context, state) {
          print('this is state type ${state}');
          if (state is AuthenticatedAuthenticated) {
            // return ProductDataList();
            return Center(child: Text('welcome to page '),);
          }
          if (state is AuthenticationUnauthenticated) {
            // return SignUpScreen();
            return LoginScreen(userRepository: userRepository);
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
              child: Text(' no data '),
            ),
          );
        }),
      ),
    );
  }
}

class HomeBuilderApp extends StatelessWidget {
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
