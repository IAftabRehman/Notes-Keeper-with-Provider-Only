import 'package:flutter/material.dart';
import 'package:notes_keeper_provider/providers/SplashScreen_Provider.dart';
import 'package:notes_keeper_provider/providers/HomeScreen_Provider.dart';
import 'package:notes_keeper_provider/screens/home_Screen.dart';
import 'package:notes_keeper_provider/screens/splash_Screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
        // ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final homeProvider = HomeProvider();
            homeProvider.loadTasks();
            return homeProvider;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/home': (context) => HomeScreen(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

