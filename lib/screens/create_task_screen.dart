import 'package:flutter/material.dart';
import 'package:notes_keeper_provider/providers/HomeScreen_Provider.dart';
import 'package:provider/provider.dart';

class CreateTaskScreen extends StatefulWidget {
  final String title;
  final String description;
  final String createdAt;

  const CreateTaskScreen({
    required this.title,
    required this.description,
    required this.createdAt,
    super.key,
  });

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.setInitialValues(widget.title, widget.description);

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
    final provider = Provider.of<HomeProvider>(context);
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff355C7D), Color(0xff6C5B7B), Color(0xffC06C84)],
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
                    colors: [Color(0xff4169E1), Color(0xff6495ED)],
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
                    IconButton(icon: Icon(Icons.keyboard_arrow_left, size: 35, color: Colors.white), onPressed: (){
                      Navigator.pop(context);
                    }),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Note",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 26,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        controller: _descriptionController,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          widget.createdAt,
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            provider.updateTitle(widget.title);
                            provider.isEdited ? Navigator.pop(context) : null;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: provider.isEdited
                                ? Colors.red
                                : Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
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
