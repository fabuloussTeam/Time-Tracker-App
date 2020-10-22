
import 'package:flutter/cupertino.dart';

abstract class Database {


}

class FirestoreDatabase implements Database {
// UID de l'utilisateur connecté.
  final String uid;
  FirestoreDatabase({@required this.uid});

}

