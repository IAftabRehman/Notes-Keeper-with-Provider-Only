import 'package:flutter/material.dart';
import 'package:notes_keeper_provider/providers/HomeScreen_Provider.dart';
import 'package:provider/provider.dart';
import '../providers/ThemeChanger_Provider.dart';
import '../const/app_theme.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final provider = Provider.of<HomeProvider>(context);
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final appbarColor = isDarkMode
        ? AppTheme.appBarColorDark
        : AppTheme.appBarColorLight;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: h * 0.1,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: appbarColor,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Row(
          children: [
            provider.hasSelection
                ? IconButton(
                    icon: Icon(Icons.clear, size: 30, color: Colors.white70),
                    onPressed: () {
                      provider.clearSelection();
                    },
                  )
                : const SizedBox(),
            Text(
              provider.hasSelection ? "Clear" : "    Notes Board",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            Spacer(),
            provider.hasSelection
                ? IconButton(
                    onPressed: () {
                      provider.deleteTask();
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      size: 30,
                      color: Colors.white70,
                    ),
                  )
                : IconButton(
                    icon: provider.dayMode
                        ? Icon(Icons.light_mode, size: 35, color: Colors.white)
                        : Icon(Icons.dark_mode, size: 35, color: Colors.white),
                    onPressed: () {
                      if (provider.dayMode == false) {
                        provider.changeMode(true);
                      } else {
                        provider.changeMode(false);
                      }
                      if (themeProvider.themeMode == ThemeMode.light) {
                        themeProvider.setTheme(ThemeMode.dark);
                      } else {
                        themeProvider.setTheme(ThemeMode.light);
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
