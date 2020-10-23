
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/app/home/models/job.dart';

abstract class Database {
  Future<void> createJob(Job job);

}

class FirestoreDatabase implements Database {
// UID de l'utilisateur connecté.
  final String uid;
  FirestoreDatabase({@required this.uid})  : assert(uid != null);

  Future<void> createJob(Job job) async {
    final path = '/users/$uid/jobs/job_abc';
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(job.toMap());

  }

}

