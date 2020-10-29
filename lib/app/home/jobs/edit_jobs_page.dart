import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/app/home/models/job.dart';
import 'package:timetrackerapp/common_widgets/platform_alert_dialog.dart';
import 'package:timetrackerapp/services/database.dart';

class EditJobPage extends StatefulWidget {
//Pour utiliser la database dans cette classe
// on le passe implecitement par le constructeur
  final Database database;
  final Job job; // Recuperation du job courant que on veut modifier
  const EditJobPage({Key key, @required this.database, this.job});

  static Future<void> show(BuildContext context, {Job job}) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => EditJobPage(database: database, job: job),
            fullscreenDialog: true
        )
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {

  final _formKey = GlobalKey<FormState>();

  String _name;
  int _ratePerHour;

  @override
  void initState() {
    super.initState();
    if(widget.job != null){
      _name = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }



  //Fonction de soumission du formulaire
  Future<void> _submit(context) async{
    if(_validateAndSaveForm()) {
      try {
        final jobs = await widget.database.jobStream().first;
        final allNames = jobs.map((job) => job.name).toList();
        if(widget.job != null){
          allNames.remove(widget.job.name);
        }
        print("all name in DB: $allNames");
        if(allNames.contains(_name)){
          PlatformAlertDialog(
            title: "This job name already used",
            content: "Please choose a different",
            defaultActionText: "OK",
          ).show(context);
        } else {
          final id = widget.job?.id ?? docementIdFromCurrentDate();
          final job = Job(id: id, name: _name, ratePerHour: _ratePerHour);
          await widget.database.setJob(job: job, context: context);
          Navigator.of(context).pop();
        }

      } on PlatformException catch (e) {
        PlatformAlertDialog(
          title: "Operation failed",
          content: "Element not added",
          defaultActionText: "OK",
        ).show(context);
      }

    }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title:  Text(widget.job == null ? "New Job" : 'Edit job'),
        actions: [
          FlatButton(
            onPressed: () =>_submit(context),
            child: Text("Save", style: TextStyle(fontSize: 18, color: Colors.white),),
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: _buildForm()
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Job name'),
        validator: (value) => value.isNotEmpty ? null : "Name can 't be empty",
        onSaved: (value) => _name = value,
        initialValue: _name,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: "Rate per hour"),
        initialValue: _ratePerHour != null ?  "$_ratePerHour" : null,
        // validator: (value) => value.isNotEmpty ? null : "Name can 't be empty",
        keyboardType: TextInputType.numberWithOptions(
            signed: false,
            decimal: false
        ),
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
      ),
    ];
  }
}
