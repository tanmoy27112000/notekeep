class TodoModel {
  String title;
  String description;
  bool isDone;
  DateTime createdAt;
  String userId;
  TodoModel({
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
    required this.userId,
  });

  TodoModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        isDone = json['isDone'],
        createdAt = DateTime.parse(json['createdAt']),
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'isDone': isDone,
        'createdAt': createdAt.toIso8601String(),
        'userId': userId,
      };
}
