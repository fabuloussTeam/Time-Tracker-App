
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/app/home/models/job.dart';
import 'package:timetrackerapp/common_widgets/platform_alert_dialog.dart';
import 'package:timetrackerapp/services/firestore_services.dart';

import 'api_path.dart';


abstract class Database {
  Future<void> createJob({Job job, BuildContext context});
  Stream<List<Job>> jobStream();

}

String docementIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
// UID de l'utilisateur connecté.
  final String uid;
  FirestoreDatabase({@required this.uid})  : assert(uid != null);

  // Creation d'un constructeur priver
  final _service = FirestoreService.instance;

  Future<void> createJob({Job job, BuildContext context}) async => await _service.setData (
      path: APIPath.job(uid, docementIdFromCurrentDate()),
      data: job.toMap(),
      context: context
  );

  Stream<List<Job>> jobStream() => _service.collectionStream(
    path: APIPath.jobs(uid),
    builder: ((data, id) => Job.fromMap(data, id)),
  );



}

