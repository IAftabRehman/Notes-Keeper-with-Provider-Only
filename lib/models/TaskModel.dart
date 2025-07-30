class TaskModel {
  final String title;
  final String description;

  TaskModel({required this.title, required this.description});

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
  };

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    title: json['title'],
    description: json['description'],
  );
}
