import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrackerapp/services/database.dart';

class AddJobPage extends StatefulWidget {

  final Database database;
  const AddJobPage({Key key, @required this.database});

  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => AddJobPage(database: database),
            fullscreenDialog: true
        )
    );
  }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {

  final _formKey = GlobalKey<FormState>();

  String _name;
  int _ratePerHour;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void _submit(){
    //TODO: Validate & save form
    if(_validateAndSaveForm()) {
      print("form saved ++++:name: $_name, rateper hour : $_ratePerHour");
      //TODO: submit data to Firestore

    }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text("New Job"),
        actions: [
          FlatButton(
            onPressed: _submit,
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
      ),
      TextFormField(
        decoration: InputDecoration(labelText: "Rate per hour"),
        keyboardType: TextInputType.numberWithOptions(
            signed: false,
            decimal: false
        ),
        onSaved: (value) => _ratePerHour = int.parse(value) ?? 0,
      ),
    ];
  }
}
