enum TodoFlag { urgently, important, medium, none }

class TodoModel {
  final String? taskId;
  final String title;
  final String description;
  final TodoFlag flag;
  final DateTime? taskStart;
  final bool? status;

  TodoModel({
    required this.title,
    required this.description,
    this.taskStart,
    required this.flag,
    this.taskId,
    this.status = false,
  });
}
