import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mysql1/mysql1.dart';

class ConsultPatient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConsultPatientState();
  }
}

//r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"

class ConsultPatientState extends State<ConsultPatient> {
  String _numExp;
  var _controller = TextEditingController();

  String datosPaciente = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _consultPatient() {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(labelText: 'ID del paciente'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
      },
      onSaved: (String value) {
        _numExp = value;
      },
    );
  }

  Future _getPatient() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'aruzab',
        db: 'Ginnacle',
        password: 'david123'));

    var userId = 1;
    var results = await conn.query(
        'select NumExpediente from Pacientes where NumExpediente = ?',
        [userId]);

    for (var row in results) {
      print('ID: ${row[0]}');
    }

    await conn.close();
  }

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: true, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Datos del paciente'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: const <Widget>[
  //               Text("datosPaciente"),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Approve'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consultar Paciente')),
      body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _consultPatient(),
                  SizedBox(height: 20),
                  RaisedButton(
                      child: Text(
                        'Realizar Consulta',
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                      onPressed: () {
                        _getPatient();
                        //_showMyDialog();
                        if (_formKey.currentState.validate()) {
                          _controller.clear();
                        }
                        _formKey.currentState.save();
                      })
                ],
              ))),
    );
  }
}
