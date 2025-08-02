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
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                style: const TextStyle(fontSize: 18),
                maxLines: null,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(widget.createdAt, style: const TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    provider.isEdited ? Navigator.pop(context) : null;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    provider.isEdited ? Colors.red : Colors.blue,
                    minimumSize: const Size(130, 35),
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
    );
  }
}
