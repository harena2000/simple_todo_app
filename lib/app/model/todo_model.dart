enum TodoFlag { urgently, important, medium, none }

class TodoModel {
  late String title;
  late String description;
  TodoFlag? flag;
  bool? status;
  DateTime? dateCreated;

  TodoModel({
    required this.title,
    required this.description,
    this.flag = TodoFlag.none,
    this.status = false,
    this.dateCreated,
  });

  TodoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    flag = parseTodoFlagSnapshotToFlagTask(json['flag']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'flag': flagToString(),
        'status': status,
      };

  void toggleStatus(bool status) {
    this.status = status;
  }

  void setTodoModel(TodoModel todoModel) {
    title = todoModel.title;
    description = todoModel.description;
    flag = todoModel.flag;
    status = todoModel.status;
    dateCreated = todoModel.dateCreated;
  }

  String flagToString() {
    switch (flag!) {
      case TodoFlag.none:
        return "none";
      case TodoFlag.medium:
        return "medium";
      case TodoFlag.important:
        return "important";
      case TodoFlag.urgently:
        return "urgently";
    }
  }

  TodoFlag parseTodoFlagSnapshotToFlagTask(String snapshot) {
    switch (snapshot) {
      case "none":
        return TodoFlag.none;
      case "medium":
        return TodoFlag.medium;
      case "important":
        return TodoFlag.important;
      case "urgently":
        return TodoFlag.urgently;
    }
    return TodoFlag.none;
  }
}
