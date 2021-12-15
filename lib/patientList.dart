import 'dart:core';
import 'patientsbd.dart';
import 'db.dart';
import 'package:flutter/material.dart';

class PatientList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Patients"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "/editar",
                arguments: Patient(
                    numExp: 0,
                    name: "",
                    lastNameP: "",
                    lastNameM: "",
                    tel: ""));
          },
        ),
        body: Container(child: Lista()));
  }
}

class Lista extends StatefulWidget {
  @override
  _MiLista createState() => _MiLista();
}

class _MiLista extends State<Lista> {
  List<Patient> patients = [];

  @override
  void initState() {
    loadPatients();
    super.initState();
  }

  loadPatients() async {
    List<Patient> auxPatient = await DB.patients();

    setState(() {
      patients = auxPatient;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, i) => Dismissible(
            key: Key(i.toString()),
            direction: DismissDirection.startToEnd,
            background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(left: 5),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.delete, color: Colors.white))),
            onDismissed: (direction) {
              DB.delete(patients[i]);
            },
            child: ListTile(
                title: Text(patients[i].name),
                trailing: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/consult",
                          arguments: patients[i]);
                    },
                    child: Icon(Icons.edit)))));
  }
}
