import 'package:flutter/material.dart';
import 'package:simple_todo_app/app/api/firebase_service.dart';
import 'package:simple_todo_app/app/model/project_model.dart';

class TodoProvider extends ChangeNotifier {
  FirebaseService firebaseService = FirebaseService();
  Future<dynamic> addProject(ProjectModel projectModel) async {
    var response = firebaseService.addProjectService(projectModel);
    print(response);
  }
}
