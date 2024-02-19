import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_todo_app/app/model/project_model.dart';

class FirebaseService {
  final database = FirebaseFirestore.instance;

  Future<dynamic> addProjectService(ProjectModel projectModel) async {
    try {
      var response =
          await database.collection('project').add(projectModel.toJson());
      return response;
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<QueryDocumentSnapshot?>> loadProjectService() async {
    try {
      var response = await database.collection('project').snapshots().first;
      List<QueryDocumentSnapshot?> data = response.docs.toList();
      return data;
    } catch (e) {
      throw Exception();
    }
  }
}
