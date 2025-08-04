import 'package:flutter/material.dart';
import 'package:notes_keeper_provider/providers/SplashScreen_Provider.dart';
import 'package:notes_keeper_provider/providers/HomeScreen_Provider.dart';
import 'package:notes_keeper_provider/providers/ThemeChanger_Provider.dart';
import 'package:notes_keeper_provider/screens/home_screen.dart';
import 'package:notes_keeper_provider/screens/splash_Screen.dart';
import 'package:provider/provider.dart';
import 'const/app_theme.dart';

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
        ChangeNotifierProvider(
          create: (_) {
            final homeProvider = HomeProvider();
            homeProvider.loadTasks();
            return homeProvider;
          },
        ),
        ChangeNotifierProvider(create: (_) => ThemeChangerProvider()),
      ],
      child: Builder(builder: (BuildContext context){
        final provider = Provider.of<ThemeChangerProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: provider.themeMode,
          initialRoute: '/',
          routes: {'/home': (context) => HomeScreen()},
          title: 'Flutter Demo',
          // theme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // ),
          darkTheme: AppTheme.darkTheme,
          theme: AppTheme.lightTheme,
          home: SplashScreen(),
        );
      })
    );
  }
}
