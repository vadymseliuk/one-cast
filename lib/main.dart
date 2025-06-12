import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/splash/splash_screen.dart';
import 'screens/welcome/welcome_screen.dart';
import 'screens/signin/signin_screen.dart';
import 'screens/collection/collection_screen.dart';
import 'screens/details/details_screen.dart';

import 'blocs/collection/collection_bloc.dart';
import 'blocs/auth/auth_bloc.dart';

import 'widgets/app_background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CollectionBloc()..add(LoadCollectionEvent()),
          ),
          BlocProvider(create: (_) => AuthBloc()),
        ],
        child: MaterialApp(
          title: 'Bottle App',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.transparent,
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
              displayLarge: TextStyle(color: Colors.white),
              displayMedium: TextStyle(color: Colors.white),
              displaySmall: TextStyle(color: Colors.white),
              headlineLarge: TextStyle(color: Colors.white),
              headlineMedium: TextStyle(color: Colors.white),
              headlineSmall: TextStyle(color: Colors.white),
              titleLarge: TextStyle(color: Colors.white),
              titleMedium: TextStyle(color: Colors.white),
              titleSmall: TextStyle(color: Colors.white),
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              bodySmall: TextStyle(color: Colors.white70),
              labelLarge: TextStyle(color: Colors.white),
              labelMedium: TextStyle(color: Colors.white70),
              labelSmall: TextStyle(color: Colors.white70),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/welcome': (context) => const WelcomeScreen(),
            '/signin': (context) => const SignInScreen(),
            '/collection': (context) => const CollectionScreen(),
            '/details': (context) => const DetailsScreen(),
          },
        ),
      ),
    );
  }
}
