import 'package:flutter/material.dart';
import 'patientsbd.dart';
import 'db.dart';

class ConsultPatient extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final numexpController = TextEditingController();
  final nameController = TextEditingController();
  final lastNamePController = TextEditingController();
  final lastNameMController = TextEditingController();
  final telController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Patient patient = ModalRoute.of(context).settings.arguments;
    // nameController.text = patient.name;
    // lastNamePController.text = patient.lastNameP;
    // lastNameMController.text = patient.lastNameM;

    return Scaffold(
        appBar: AppBar(title: Text("Guardar")),
        body: Container(
            child: Padding(
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                TextFormField(
                  controller: numexpController,
                  validator: (value) {
                    if (value.isEmpty) return "La numexp es obligatoria";
                  },
                  decoration: InputDecoration(labelText: "N. Expediente"),
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) return "El name es obligatorio";
                  },
                  onSaved: (String value) {
                    patient.name = value;
                    return patient.name;
                  },
                  decoration: InputDecoration(labelText: "Nombre(s)"),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                TextFormField(
                  controller: lastNamePController,
                  validator: (value) {
                    if (value.isEmpty) return "La lastNameP es obligatoria";
                  },
                  onSaved: (String value) {
                    patient.lastNameP = value;
                    return patient.lastNameP;
                  },
                  decoration: InputDecoration(labelText: "Apellido Paterno"),
                ),
                TextFormField(
                  controller: lastNameMController,
                  validator: (value) {
                    if (value.isEmpty) return "La lastNameM es obligatoria";
                  },
                  onSaved: (String value) {
                    patient.lastNameM = value;
                    return patient.lastNameM;
                  },
                  decoration: InputDecoration(labelText: "Apellido Materno"),
                ),
                TextFormField(
                  controller: telController,
                  validator: (value) {
                    if (value.isEmpty) return "La tel es obligatoria";
                  },
                  onSaved: (String value) {
                    patient.tel = value;
                    return patient.tel;
                  },
                  decoration: InputDecoration(labelText: "Teléfono"),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        if (patient.numExp > 0) {
                          print(patient.name);
                          // patient.numExp = int.parse(numexpController.text);
                          // patient.name = nameController.text;
                          // patient.lastNameP = lastNamePController.text;
                          // patient.lastNameM = lastNameMController.text;
                          // patient.tel = telController.text;
                          DB.update(patient);
                        } else {
                          DB.insert(Patient(
                              numExp: int.parse(numexpController.text),
                              name: nameController.text,
                              lastNameP: lastNamePController.text,
                              lastNameM: lastNameMController.text,
                              tel: telController.text));
                          print("Paciente:\n" +
                              patient.name +
                              "," +
                              patient.lastNameP +
                              ", " +
                              patient.lastNameP);
                        }
                        Navigator.pushNamed(context, "/");
                      }
                    },
                    child: Text("Save"))
              ])),
          padding: EdgeInsets.all(15),
        )));
  }
}
