import 'package:flutter/material.dart';
import 'package:simple_todo_app/app/constant/app_assets.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/model/todo_model.dart';

enum ProjectStatus { closed, inProgress }

class ProjectModel {
  String? projectId;
  late String title;
  late String description;
  Color? projectColor;
  String? imageAsset;
  ProjectStatus? status;
  List<TodoModel>? todoTaskList;

  ProjectModel({
    required this.title,
    required this.description,
    this.projectColor = AppColors.green,
    this.imageAsset = AppAssets.waveTransparent,
    this.status = ProjectStatus.inProgress,
    this.projectId = "",
    this.todoTaskList,
  });

  void setProjectId(String id) {
    projectId = id;
  }

  void setProjectTask(TodoModel todoModel) {
    todoTaskList!.add(todoModel);
  }

  void deleteProjectTask(TodoModel todoModel) {
    todoTaskList!.add(todoModel);
  }

  ProjectModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    projectColor = json['projectColor'];
    imageAsset = json['imageAsset'];
    status = json['status'];
    projectId = json['projectId'];
    todoTaskList = [];
  }

  Map<String, dynamic> toJson() => {
        'projectId': projectId,
        'title': title,
        'description': description,
        'projectColor':
            "0x${projectColor!.value.toRadixString(16).toUpperCase()}",
        'imageAsset': imageAsset,
        'status': statusToString(),
        'todoTaskList': todoTaskList,
      };

  String statusToString() {
    switch (status!) {
      case ProjectStatus.inProgress:
        return "inProgress";
      case ProjectStatus.closed:
        return "closed";
    }
  }
}
