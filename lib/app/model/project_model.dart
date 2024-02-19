import 'package:flutter/material.dart';
import 'package:simple_todo_app/app/constant/app_assets.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/model/todo_model.dart';

enum ProjectStatus { closed, paused, inProgress }

class ProjectModel {
  late int projectId;
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
    required this.projectId,
    this.todoTaskList,
  });

  ProjectModel.fromJson(Map<String, dynamic> json) {
    title = json['id'];
    description = json['title'];
    projectColor = json['price'];
    imageAsset = json['description'];
    status = json['category'];
    projectId = json['image'];
    todoTaskList = [];
  }

  Map<String, dynamic> toJson() => {
        'projectId': projectId,
        'title': title,
        'description': description,
        'projectColor':
            "0x${projectColor!.value.toRadixString(16).toUpperCase()}",
        'imageAsset': imageAsset,
        'status': status.toString(),
        'todoTaskList': todoTaskList,
      };

  String statusToString() {
    switch (status!) {
      case ProjectStatus.inProgress:
        return "inProgress";
      case ProjectStatus.paused:
        return "paused";
      case ProjectStatus.closed:
        return "closed";
    }
  }
}
