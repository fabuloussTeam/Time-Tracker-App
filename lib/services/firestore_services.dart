import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/common_widgets/platform_alert_dialog.dart';

class FirestoreService {

  // Definition d'un contructeur priver pour empecher l'utilisation
  // de la creation d'un instance par nimporte qui
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({String path, Map<String, dynamic> data, BuildContext context}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    //  print("$path: $data");
    print("$data");
    reference.set(data)
        .then((value) => print("Valuer added"))
        .catchError((onError) => PlatformAlertDialog(
      title: "Error",
      content: onError.toString(),
      defaultActionText: "OK",
    ).show(context));
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data)
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((snapshot) => builder(snapshot.data())).toList());
  }

}