import 'package:flutter/material.dart';
import 'package:notes_keeper_provider/screens/createTask_Screen.dart';
import 'package:provider/provider.dart';

import '../providers/HomeScreen_Provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final provider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Home Screen"),
        actions: [
          if (provider.hasSelection)
            IconButton(
              onPressed: () {
                provider.clearSelection();
              },
              icon: Icon(Icons.delete_outline_rounded, size: 30),
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: 19,
        itemBuilder: (context, index) {
          final isSelected = provider.isSelected(index);
          return GestureDetector(
            onLongPress: () {
              provider.toggleSelection(index);
            },
            onTap: () {
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
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: h * 0.1,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.teal : Colors.green,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: Colors.black54,
                      offset: Offset(5, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text("Hello"),
                  subtitle: Text("World"),
                  trailing: provider.hasSelection
                      ? IconButton(
                          onPressed: () {
                            provider.toggleSelection(index);
                          },
                          icon: isSelected
                              ? Icon(Icons.check_box, color: Colors.green)
                              : Icon(Icons.square_outlined, color: Colors.grey),
                        )
                      : null,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                content: SizedBox(
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
                        decoration: InputDecoration(labelText: "Title"),
                      ),
                      const SizedBox(height: 10),
                      TextField(
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
                            onPressed: () {},
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
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
