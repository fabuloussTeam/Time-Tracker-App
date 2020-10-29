import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/app/home/jobs/edit_jobs_page.dart';
import 'package:timetrackerapp/app/home/jobs/empty_content.dart';
import 'package:timetrackerapp/app/home/models/job.dart';
import 'package:timetrackerapp/common_widgets/platform_alert_dialog.dart';
import 'package:timetrackerapp/services/auth.dart';
import 'package:timetrackerapp/services/database.dart';

import 'job_list_tile.dart';

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

  Future<void>_delete(BuildContext context, Job job) async {
    try{
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: "Operation failed",
        content: e.toString(),
        defaultActionText: "OK",
      ).show(context);
    }
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
        onPressed: () => EditJobPage.show(context),
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
          if(jobs.isNotEmpty){
            final children = jobs.map((job) => Dismissible(
              key: Key("job-${job.id}"),
              background: Container(
                  color: Colors.red,
                  child: Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => _delete(context, job),
              child: JobListTile(
                job: job,
                ontap: () => EditJobPage.show(context, job: job),
              ),
            )).toList();
            return ListView(children: children);
          }
          return EmptyContent();
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
