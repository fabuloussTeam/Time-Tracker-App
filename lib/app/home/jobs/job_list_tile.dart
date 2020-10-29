import 'package:flutter/material.dart';
import 'package:timetrackerapp/app/home/models/job.dart';

class JobListTile extends StatelessWidget {

  final Job job;
  final VoidCallback ontap;

  JobListTile({Key key, @required this.job, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      trailing: Icon(Icons.chevron_right),
      onTap: ontap,
    );

  }
}
