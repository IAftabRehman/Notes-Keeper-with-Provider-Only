import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_keeper_provider/const/Fonts.dart';
import 'package:notes_keeper_provider/providers/DashboardProvider.dart';
import 'package:notes_keeper_provider/screens/DashboardScreen.dart';
import 'package:provider/provider.dart';
import '../const/ThemeColor.dart';
import '../providers/ThemeChanger_Provider.dart';

class NoteOpenScreen extends StatefulWidget {
  final String title;
  final String description;
  final DateTime createdAt;
  final int index;

  const NoteOpenScreen({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.index,
    super.key,
  });

  @override
  State<NoteOpenScreen> createState() => _NoteOpenScreenState();
}

class _NoteOpenScreenState extends State<NoteOpenScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(context, listen: false)
          .setInitialValues(widget.title, widget.description);
    });

    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);

    _titleController.addListener(() {
      provider.updateTitle(_titleController.text);
    });
    _descriptionController.addListener(() {
      provider.updateDescription(_descriptionController.text);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    final provider = Provider.of<DashboardProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? ThemeColor.backgroundDark
        : ThemeColor.backgroundLight;
    final appbarColor = isDarkMode
        ? ThemeColor.appBarColorDark
        : ThemeColor.appBarColorLight;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: backgroundColor,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
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
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        size: 35,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Note",
                          style: AppFont.appBarText
                        ),
                      ),
                    ),
                    const Spacer(),
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
                                ? Icon(
                                    Icons.light_mode,
                                    size: 35,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.dark_mode,
                                    size: 35,
                                    color: Colors.white,
                                  ),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _titleController,
                        style: AppFont.openNoteTitle,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _descriptionController,
                        style: AppFont.openNoteDescription,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.7, color: Colors.blue),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            DateFormat('d - MMMM').format(widget.createdAt),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.white),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            if (provider.isEdited) {
                              provider.applyTaskUpdate(widget.index);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardScreen(),
                                ),
                              );
                            }
                            provider.isEdited ? Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen())) : null;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: provider.isEdited
                                ? Colors.blue
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(130, 45),
                          ),
                          child: const Text(
                            "Update",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
