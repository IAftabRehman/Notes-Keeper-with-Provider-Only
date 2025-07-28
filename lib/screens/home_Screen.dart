import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Home Screen"),
      ),
      body: ListView.builder(
        itemCount: 19,
        itemBuilder: (context, index) {
          // final item = yourList[index];
          return ListTile(
            title: Text("Aftab"),
            subtitle: Text("Rehman"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
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
                    Text("Created Task", style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Title"
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Sub-Title"
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Write Something",
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.cancel_outlined, size: 40, color: Colors.red)),
                        IconButton(onPressed: (){}, icon: Icon(Icons.done_all_outlined, size: 40, color: Colors.green))
                      ],
                    )
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
