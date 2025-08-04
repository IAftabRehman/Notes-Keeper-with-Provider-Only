import 'package:flutter/material.dart';
import 'package:notes_keeper_provider/screens/create_task_screen.dart';
import 'package:notes_keeper_provider/widgets/appBar_widget.dart';
import 'package:provider/provider.dart';
import '../const/app_theme.dart';
import '../providers/HomeScreen_Provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDarkMode
        ? AppTheme.backGround_dark
        : AppTheme.backGround_light;
    // final selectedTaskColor = isDarkMode
    //     ? AppTheme.taskSelected_Dark
    //     : AppTheme.taskSelected_Light;
    // final UnSelectedTaskColor = isDarkMode
    //     ? AppTheme.taskUnSelected_Dark
    //     : AppTheme.taskUnSelected_Light;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const AppBarWidget(),
              Expanded(
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
                                    index: index,
                                    title: task.title,
                                    description: task.description,
                                    createdAt: task.createdAt,
                                  ),
                                ),
                              );
                            } else {
                              provider.toggleSelection(index);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            child: Container(
                              height: h * 0.105,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xff5D8AA8)
                                    : const Color(0xff0071c5),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 1,
                                    color: Colors.black54,
                                    offset: Offset(5, 4),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    task.title,
                                    style: const TextStyle(
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
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: provider.hasSelection
                                    ? InkWell(
                                        onTap: () =>
                                            provider.toggleSelection(index),
                                        child: Icon(
                                          isSelected
                                              ? Icons.check_box
                                              : Icons.square_outlined,
                                          color: isSelected
                                              ? const Color(0xff004d00)
                                              : Colors.grey,
                                          size: 30,
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
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
                    const Text(
                      "Created Task",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: "Title"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(labelText: "Note Down"),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            titleController.clear();
                            descriptionController.clear();
                          },
                          icon: const Icon(
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
                              Navigator.pop(context);
                              titleController.clear();
                              descriptionController.clear();
                            }
                          },
                          icon: const Icon(
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
