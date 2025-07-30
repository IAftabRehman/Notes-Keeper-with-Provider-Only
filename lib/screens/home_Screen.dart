import 'package:flutter/material.dart';
import 'package:notes_keeper_provider/screens/createTask_Screen.dart';
import 'package:provider/provider.dart';
import '../providers/HomeScreen_Provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final provider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.blue,
        backgroundColor: Colors.black54,
        leading: provider.hasSelection
            ? IconButton(
                onPressed: () {
                  provider.clearSelection();
                },
                icon: Icon(Icons.close, size: 30),
              )
            : null,
        title: provider.hasSelection ? Text("Clear") : Text("Home Screen"),
        actions: [
          if (provider.hasSelection)
            IconButton(
              onPressed: () {
                provider.clearSelection();
              },
              icon: IconButton(
                onPressed: () {
                  provider.deleteTask();
                },
                icon: Icon(Icons.delete_outline_rounded, size: 30),
              ),
            ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.greenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.tasks.length,
              itemBuilder: (context, index) {
                final task = provider.tasks[index];
                final isSelected = provider.isSelected(index);
                return GestureDetector(
                  onLongPress: () {
                    provider.toggleSelection(index);
                  },
                  onTap: () {
                    if (!provider.hasSelection) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateTaskScreen(
                            title: "Name",
                            description:
                                "This is the description of notes picker app which is provided by Marfah Technologies",
                          ),
                        ),
                      );
                    } else {
                      provider.toggleSelection(index);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: h * 0.11,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff005aa7), Color(0xff7F7E72)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        color: isSelected ? Colors.teal : Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            color: Colors.black54,
                            offset: Offset(5, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        subtitle: Text(
                          task.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        trailing: provider.hasSelection
                            ? InkWell(
                                onTap: () => provider.toggleSelection(index),
                                child: Icon(
                                  isSelected
                                      ? Icons.check_box
                                      : Icons.square_outlined,
                                  color: isSelected ? Colors.green : Colors.grey,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20,
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                height: 400,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Created Task",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(labelText: "Title"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(labelText: "Note Down"),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            final title = titleController.text.trim();
                            final desc = descriptionController.text.trim();

                            if (title.isNotEmpty && desc.isNotEmpty) {
                              Provider.of<HomeProvider>(
                                context,
                                listen: false,
                              ).addTask(title, desc);
                              Navigator.pop(context); // close bottom sheet
                            }
                          },
                          icon: Icon(
                            Icons.done_all_outlined,
                            size: 40,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ), // Custom Widget
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
