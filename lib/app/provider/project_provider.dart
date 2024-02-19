import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/app/api/firebase_service.dart';
import 'package:simple_todo_app/app/model/project_model.dart';
import 'package:simple_todo_app/app/model/todo_model.dart';

class ProjectProvider extends ChangeNotifier {
  FirebaseService firebaseService = FirebaseService();

  List<ProjectModel> projectList = [];

  List<ProjectModel> projectListInProgress = [];
  List<ProjectModel> projectListClosed = [];

  late ProjectModel selectedProject;
  late TodoModel selectedTask;

  ProjectStatus parseProjectSnapshotToProjectStatus(String snapshot) {
    switch (snapshot) {
      case "inProgress":
        return ProjectStatus.inProgress;
      case "closed":
        return ProjectStatus.closed;
    }
    return ProjectStatus.inProgress;
  }

  void sortProjectByStatus() {
    projectListInProgress.addAll(projectList
        .where((element) => element.status == ProjectStatus.inProgress));
    projectListClosed.addAll(
        projectList.where((element) => element.status == ProjectStatus.closed));
    notifyListeners();
  }

  void clearProjectStatusList() {
    projectListInProgress.clear();
    projectListClosed.clear();
    notifyListeners();
  }

  void selectProject(ProjectModel projectModel) {
    selectedProject = projectModel;
    notifyListeners();
  }

  void selectTask(TodoModel todoModel) {
    selectedTask = todoModel;
    notifyListeners();
  }

  Future<void> getAllProjects() async {
    try {
      List<ProjectModel> list = [];
      List<QueryDocumentSnapshot?> snapshot =
          await firebaseService.loadProjectService();
      for (var index = 0; index < snapshot.length; index++) {
        ProjectModel model = ProjectModel(
          title: snapshot[index]!['title'],
          description: snapshot[index]!['description'],
          projectId: snapshot[index]!['projectId'].toString(),
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
      throw Exception(e);
    }
  }

  Future<void> addProject(ProjectModel projectModel) async {
    try {
      DocumentReference response =
          await firebaseService.addProjectService(projectModel);
      projectModel.setProjectId(response.id);
      projectList.add(projectModel);
      projectListInProgress.add(projectModel);
      await updateProject(response.id, {
        "projectId": response.id,
      });
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateProject(String id, Map<String, dynamic> data) async {
    try {
      await firebaseService.updateProjectService(id, data);
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> closeProject() async {
    try {
      await updateProject(selectedProject.projectId!, {
        "status": "closed",
      });
      projectListInProgress
          .removeWhere((element) => element == selectedProject);
      projectListClosed.add(selectedProject);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  int getRealDataIndexOnDB() {
    int index = 0;
    for (var i = 0; i < projectList.length; i++) {
      if (selectedProject == projectList[index]) {
        index = i;
      }
    }
    return index;
  }

  Future<void> addTask(TodoModel todoModel) async {
    try {
      await firebaseService.updateProjectService(selectedProject.projectId!, {
        "todoTaskList": FieldValue.arrayUnion([todoModel.toJson()])
      });
      selectedProject.setProjectTask(todoModel);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> editTask({
    required int virtualIndex,
    required TodoModel editedTask,
    required TodoModel oldTask,
  }) async {
    int index = getRealDataIndexOnDB();

    List<dynamic> data = [];

    if (selectedProject == projectList[index]) {
      for (var element in projectList[index].todoTaskList!) {
        if (element == oldTask) {
          element.setTodoModel(editedTask);
        }
      }
    }

    for (var element in projectList[index].todoTaskList!) {
      data.add(element.toJson());
    }

    try {
      await firebaseService.updateProjectService(selectedProject.projectId!, {
        "todoTaskList": data,
      });
      notifyListeners();
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> deleteTask(
    TodoModel todoModel,
  ) async {
    try {
      await firebaseService.updateProjectService(selectedProject.projectId!, {
        "todoTaskList": FieldValue.arrayRemove([todoModel.toJson()])
      });
      selectedProject.deleteProjectTask(todoModel);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> toggleTask(
      int virtualIndex, TodoModel todoModel, bool status) async {
    int index = getRealDataIndexOnDB();

    List<dynamic> data = [];

    if (selectedProject == projectList[index]) {
      for (var element in projectList[index].todoTaskList!) {
        if (element == todoModel) {
          element.toggleStatus(status);
        }
      }
    }

    for (var element in projectList[index].todoTaskList!) {
      data.add(element.toJson());
    }

    try {
      await firebaseService.updateProjectService(selectedProject.projectId!, {
        "todoTaskList": data,
      });
      notifyListeners();
    } catch (e) {
      throw Exception();
    }
  }

  ProjectProvider() {
    getAllProjects();
  }
}
