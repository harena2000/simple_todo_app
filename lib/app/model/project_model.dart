import 'package:flutter/material.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';
import 'package:simple_todo_app/app/model/todo_model.dart';

enum ProjectStatus { closed, paused, inProgress }

class ProjectModel {
  final String projectId;
  final String title;
  final String description;
  final DateTime? begin;
  final DateTime? ended;
  final Color? projectColor;
  final ProjectStatus status;
  final String projectCreator;
  final List<TodoModel>? todoTaskList;

  ProjectModel({
    required this.title,
    required this.description,
    this.begin,
    this.ended,
    this.projectColor = AppColors.green,
    this.status = ProjectStatus.inProgress,
    required this.projectCreator,
    required this.projectId,
    this.todoTaskList,
  });
}
