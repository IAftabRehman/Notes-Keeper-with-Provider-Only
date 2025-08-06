import 'package:flutter/material.dart';
import 'package:notes_keeper_provider/providers/SplashScreen_Provider.dart';
import 'package:notes_keeper_provider/providers/DashboardProvider.dart';
import 'package:notes_keeper_provider/providers/ThemeChanger_Provider.dart';
import 'package:notes_keeper_provider/screens/DashboardScreen.dart';
import 'package:notes_keeper_provider/screens/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'const/ThemeColor.dart';

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
            final homeProvider = DashboardProvider();
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
          routes: {
            '/home': (context) => DashboardScreen(),
          },
          title: 'Note Picker',
          darkTheme: ThemeColor.darkTheme,
          theme: ThemeColor.lightTheme,
          home: SplashScreen(),
        );
      })
    );
  }
}
