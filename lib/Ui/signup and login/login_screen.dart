import 'package:aper/Logic/Login/bloc/userlogin_bloc.dart';
import 'package:aper/Logic/auth/bloc/userauth_bloc.dart';
import 'package:aper/Respo/Login/loginRespo.dart';
import 'package:aper/Ui/signup%20and%20login/signup_screen.dart';
import 'package:aper/Widget/formWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../newproduct_page.dart';



// ====================================================================
// NEW LOGIN SCREEN
class LoginScreen extends StatelessWidget {
  final CustomUserLoginRespo userRepository;
   LoginScreen({Key? key , required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(create: (context) {
         return UserloginBloc(
            authenticationBloc: BlocProvider.of<UserauthBloc>(context),
            userRepository: userRepository,
          );
       },

        child: SingleChildScrollView(
          child: 
          // LoginForm(userRepository: userRepository )
           initScreen(context),
        ),
      )
      
    );
  }

  initScreen(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Container(
          margin: EdgeInsets.only(left: 30.0, top: 50.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.keyboard_backspace,
              color: Color(0xffc5ccd6),
              size: 30.0,
            ),
          )
        ),

        // Login Text Section
        Container(
          margin: EdgeInsets.only(top: 20.0, left: 30.0),
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 30.0
            ),
          ),
        ),
           
           LoginForm(userRepository: userRepository )
        // // Email Edit text
        // FieldF(hintText:'Email',inputType:TextInputType.emailAddress),
        //   // Password Edit text
        // FieldF(obscureTxt:true,hintText:'Password',inputType:TextInputType.visiblePassword),
        //  // Login Button
        // Center(child: SubmitButton(btnName: 'Submit' , createPage:()=>  ProductDataList(),)),

        // ExtraButton(btnName: 'SignUp',createPage:()=> SignUpScreen(),)
      ],
    );
  }
}


class LoginForm extends StatefulWidget {
  final CustomUserLoginRespo userRepository;
  LoginForm({Key ?key, required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(userRepository);
}

class _LoginFormState extends State<LoginForm> {
  final CustomUserLoginRespo userRepository;
  _LoginFormState(this.userRepository);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<UserloginBloc>(context).add(LoginButtonPressed(email: _usernameController.text,
       password: _passwordController.text,),);
    }

    return BlocListener<UserloginBloc, UserloginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Login failed."),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<UserloginBloc, UserloginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
            child: Form(
              child: Column(
                children: [
                  Container(
                    height: 200.0,
                      padding: EdgeInsets.only(bottom: 20.0, top: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("AUTH WITH REST", style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0
                          ),),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text("Login app using BLOC pattern and REST API", style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.black38
                          ),)
                        ],
                      )
                    ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                        style: TextStyle(
                            fontSize: 14.0,
                            color:Colors.purple,
                            fontWeight: FontWeight.bold),
                        controller: _usernameController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          // prefixIcon: Icon(EvaIcons.emailOutline, color: Colors.black26),
                          enabledBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(30.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(30.0)),
                          contentPadding: EdgeInsets.only(
                              left: 10.0, right: 10.0),
                          labelText: "E-Mail",
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              color:Colors.grey,
                              fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        autocorrect: false,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        style: TextStyle(
                            fontSize: 14.0,
                            color:Colors.purple,
                            fontWeight: FontWeight.bold),
                        controller: _passwordController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          // prefixIcon: Icon(EvaIcons.lockOutline, color: Colors.black26,),
                          enabledBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(30.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(30.0)),
                          contentPadding: EdgeInsets.only(
                              left: 10.0, right: 10.0),
                          labelText: "Password",
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              color:Colors.grey,
                              fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        autocorrect: false,
                        obscureText: true,
                      ),
                      SizedBox(
                      height: 30.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
          child: new InkWell(
              child: new Text("Forget password?", style: TextStyle(
                color: Colors.black45,
                fontSize: 12.0
              ),),
              onTap: () {
               
              }
          ),),
          Padding(
                      padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                    height: 45,
                    child: state is LoginLoading ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
                      height: 25.0,
                      width: 25.0,
                                        child: CupertinoActivityIndicator(),
                    )
      ],
    ))
                      ],
                    ) : 
    RaisedButton(
      color: Colors.red,
      disabledColor: Colors.red,
      disabledTextColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onLoginButtonPressed,
      child: Text("LOG IN", style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white))
    )
                  ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Or connect using", style: TextStyle(
                          color: Colors.black26,
                          fontSize: 12.0
                        ),),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
      height: 40.0,
      width: 180.0,
      child: RaisedButton(
        color: Color(0xFF385c8e),
        disabledColor: Colors.red,
        disabledTextColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        onPressed: _onLoginButtonPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(EvaIcons.facebook, color: Colors.white,),
            SizedBox(
              width: 5.0,
            ),
            Text("Facebook", style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        )
      ),
    ),
                        Container(
                          width: 180.0,
                          height: 40.0,
                          child: RaisedButton(
      color: Color(0xFFf14436),
      disabledColor: Colors.red,
      disabledTextColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(EvaIcons.google, color: Colors.white,),
            SizedBox(
              width: 5.0,
            ),
            Text("Google", style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        )
    ),
                        ),
    
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Expanded(

                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                          padding: EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account?",
                  style: TextStyle(color:Colors.grey),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.0),
                ),
                GestureDetector(
                      onTap: () {
                       
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ))
              ],
            )),
                                          ),
                    ),
                    SizedBox(
                      height: 20.0,
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}