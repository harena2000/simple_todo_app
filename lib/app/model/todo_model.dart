enum TodoFlag { urgently, important, medium, none }

class TodoModel {
  String? taskId;
  late String title;
  late String description;
  TodoFlag? flag;
  bool? status;

  TodoModel({
    required this.title,
    required this.description,
    this.flag = TodoFlag.none,
    this.taskId,
    this.status = false,
  });

  TodoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    flag = json['flag'];
    status = json['status'];
    taskId = json['taskId'];
  }

  Map<String, dynamic> toJson() => {
        'taskId': taskId,
        'title': title,
        'description': description,
        'flag': title,
        'status': status,
      };
}
