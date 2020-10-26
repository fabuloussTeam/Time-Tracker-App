import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/app/home/models/job.dart';
import 'package:timetrackerapp/common_widgets/platform_alert_dialog.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'package:timetrackerapp/services/database.dart';

class JobsPage extends StatelessWidget {

// Initialisation de la callback function qui est appele pr la déconnection

  // Fonction de deconnection.
  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
         await auth.signOut();
    } catch (e) {
      print("${e.toString()}");
    }
  }


  Future<void> confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: "Logout",
      content: "Are you sure you want to logout?",
      cancelActionText: "Cancel",
      defaultActionText: "Logout",
    ).show(context);
    print(didRequestSignOut);
    if(didRequestSignOut == true){
      _signOut(context);
    }
  }

  Future<void> _createJob(BuildContext context) async {
      final database = Provider.of<Database>(context, listen: false);
      await database.createJob(
        job: Job(name: "Dev WordPress", ratePerHour: 24),
        context: context
       );
      print("On a clicker ici");
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs"),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () => confirmSignOut(context),
              child: Text("Logout", style: TextStyle(fontSize: 18.0, color: Colors.white)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createJob(context),
      ),
      body: _buildcontents(context),
    );
  }

  Widget _buildcontents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobStream(),
      builder: (context, snapshot){
        if(snapshot.hasData) {
          final jobs = snapshot.data;
          final children = jobs.map((job) => Text(job.name)).toList();
          return ListView(children: children);
        }
        if(snapshot.hasError){
          return Center(
            child: Text("Some error occured"),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }


}
