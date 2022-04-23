import 'package:flutter/material.dart';
import 'package:practica2_f/FavPages/bloc/deleteitem_bloc.dart';
import 'package:practica2_f/FavPages/bloc/favitems_bloc.dart';
import 'package:practica2_f/auth/bloc/auth_bloc.dart';
import 'package:practica2_f/blocfav/bloc/favorite_bloc.dart';
import 'package:practica2_f/home_page.dart';
import 'package:practica2_f/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloclistening/bloc/listen_bloc.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
runApp(
  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(VerifyAuthEvent()),
        ),
        BlocProvider(
          create: (context) => ListenBloc(),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider(
          create: (context) => FavitemsBloc()..add(GetMyFavorites()),
        ),
        BlocProvider(
          create: (context) => DeleteitemBloc(),
        )
      ],
      child: MyApp(),
    ),


); }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.indigo),
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Favor de autenticarse"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccessState) {
            return HomePage();
          } else if (state is UnAuthState || state is AuthErrorState) {
            return LoginPage();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}