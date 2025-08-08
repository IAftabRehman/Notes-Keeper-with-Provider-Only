import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/SplashScreen_Provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SplashScreenProvider>(context, listen: false).moveToHome(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SplashScreenProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 900),
          height: provider.height,
          width: provider.width,
          child: Image.asset(
            "assets/images/splash_Logo.png",
            height: 150,
            width: 150,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
