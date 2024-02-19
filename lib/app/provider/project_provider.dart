import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/app/api/firebase_service.dart';
import 'package:simple_todo_app/app/model/project_model.dart';
import 'package:simple_todo_app/app/model/todo_model.dart';

class ProjectProvider extends ChangeNotifier {
  FirebaseService firebaseService = FirebaseService();

  List<ProjectModel> projectList = [];

  List<ProjectModel> projectListInProgress = [];
  List<ProjectModel> projectListOnPause = [];
  List<ProjectModel> projectListClosed = [];

  Future<void> getAllProjects() async {
    try {
      List<ProjectModel> list = [];
      List<QueryDocumentSnapshot?> snapshot =
          await firebaseService.loadProjectService();
      for (var index = 0; index < snapshot.length; index++) {
        ProjectModel model = ProjectModel(
          title: snapshot[index]!['title'],
          description: snapshot[index]!['description'],
          projectId: snapshot[index]!['projectId'],
          projectColor: Color(int.parse(snapshot[index]!['projectColor'])),
          imageAsset: snapshot[index]!['imageAsset'],
          status:
              parseProjectSnapshotToProjectStatus(snapshot[index]!['status']),
          todoTaskList: (snapshot[index]!['todoTaskList'] as List)
              .map((e) => TodoModel.fromJson(e))
              .toList(),
        );
        list.add(model);
      }
      projectList.addAll(list);
      clearProjectStatusList();
      sortProjectByStatus();
    } catch (e) {
      throw Exception();
    }
  }

  ProjectStatus parseProjectSnapshotToProjectStatus(String snapshot) {
    switch (snapshot) {
      case "inProgress":
        return ProjectStatus.inProgress;
      case "paused":
        return ProjectStatus.paused;
      case "closed":
        return ProjectStatus.closed;
    }
    return ProjectStatus.inProgress;
  }

  void sortProjectByStatus() {
    projectListInProgress.addAll(projectList
        .where((element) => element.status == ProjectStatus.inProgress));
    projectListOnPause.addAll(
        projectList.where((element) => element.status == ProjectStatus.paused));
    projectListClosed.addAll(
        projectList.where((element) => element.status == ProjectStatus.closed));
    notifyListeners();
  }

  Future<dynamic> addProject(ProjectModel projectModel) async {
    try {
      await firebaseService.addProjectService(projectModel);
      projectList.add(projectModel);
      projectListInProgress.add(projectModel);
      notifyListeners();
    } catch (e) {
      throw Exception();
    }
  }

  void clearProjectStatusList() {
    projectListInProgress.clear();
    projectListOnPause.clear();
    projectListClosed.clear();
    notifyListeners();
  }

  ProjectProvider() {
    getAllProjects();
  }
}
