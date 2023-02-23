import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../Models/Task_Model.dart';

class remort_services {
  final ref = FirebaseFirestore.instance;

  Future<bool> Insert(TaskModel dm) async {
    final insert = ref.collection("ToDo");
    try {
      insert.add({
        "TaskDes": dm.description,
        "Status": dm.status,
        "Task": dm.title,
        "Date": dm.date,
        "DeadLine": dm.deadline,
        "IsDeleted": '0'
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<TaskModel>> getPosts() async {
    final snapshot = await ref.collection("ToDo").get();
    final tasks = snapshot.docs.map((e) => TaskModel.fromSnapshot(e)).toList();
    //print(userData);
    return tasks;
  }

  Future<bool> UpDate(TaskModel dm) async {
    final update = ref.collection("ToDo");
    print(dm.id);
    try {
      update.doc(dm.id).update({
        "TaskDes": dm.description,
        "Status": dm.status,
        "Task": dm.title,
        "Date": dm.date,
        "DeadLine": dm.deadline,
        "IsDeleted": dm.isDeleted
      }).then((value) => print("Good hogya!"));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> Delete(String id) async {
    final delete = ref.collection("ToDo");
    try {
      delete.doc(id).delete().then((value) => print('deleted'));
      return true;
    } catch (e) {
      return false;
    }
  }
}
