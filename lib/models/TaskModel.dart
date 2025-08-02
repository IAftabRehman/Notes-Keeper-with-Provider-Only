class TaskModel {
  final String title;
  final String description;
  final DateTime createdAt;

  TaskModel({required this.title, required this.description, required this.createdAt});

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'createdAt' : createdAt
  };

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    title: json['title'],
    description: json['description'],
    createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String())
  );
}
