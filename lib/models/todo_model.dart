class TodoModel {
  String title;
  String description;
  bool isDone;
  DateTime createdAt;
  TodoModel({
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
  });
}
