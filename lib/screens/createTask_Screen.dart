import 'package:flutter/material.dart';

class CreateTaskScreen extends StatefulWidget {
  final String title;
  final String description;

  const CreateTaskScreen({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes"), actions: [],),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              const SizedBox(height: 10),
              Text(widget.description, style: TextStyle(fontSize: 18))
            ],
          ),
        ),
      ),
    );
  }
}
