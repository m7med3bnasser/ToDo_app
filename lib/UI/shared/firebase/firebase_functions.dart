import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/UI/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTaskesCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.tojson();
      },
    );
  }

  static Stream<QuerySnapshot<TaskModel>> getTaskes(DateTime dateTime) {
    return getTaskesCollection()
        .where("date",
            isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
        .snapshots();
  }

  static void deletTask(String id) {
    getTaskesCollection().doc(id).delete();
  }

  static void updateTask(TaskModel taskModel) {
    getTaskesCollection().doc(taskModel.id).update(taskModel.tojson());
  }

  static Future<void> addTask(TaskModel taskModel) {
    var collection = getTaskesCollection();
    var docRef = collection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }
}
