import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2_f/auth/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://media4.giphy.com/media/3o6vXTpomeZEyxufGU/giphy.gif"),
            fit: BoxFit.cover
            )

        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 25,),
                  SizedBox(height: 25,),
                  SizedBox(height: 25,),
                  SizedBox(height: 25,),
                  SizedBox(height: 25,),
                  Image.asset("assets/icons/audiow.png", width: 100, height: 100),
                  //Image.network("https://cdn-icons.flaticon.com/png/512/1760/premium/1760921.png?token=exp=1650412950~hmac=ab2cb0dd0a2f45fdeb8664786a8f2a13"),
                  Text("Sign in", 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24, 
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25,),

                  MaterialButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(GoogleAuthEvent());
                    },
                    color: Colors.red,
                    child: Text("Login con Google"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}