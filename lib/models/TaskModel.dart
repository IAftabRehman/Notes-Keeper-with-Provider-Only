class NotesModel {
  final String title;
  final String description;
  final DateTime createdAt;

  NotesModel({
    required this.title,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'createdAt': createdAt.toIso8601String()
  };

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
    title: json['title'],
    description: json['description'],
    createdAt: DateTime.parse(json['createdAt'])
  );
}
