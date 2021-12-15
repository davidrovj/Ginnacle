import 'package:flutter/material.dart';

class UpdateRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UpdateRegisterState();
  }
}

//r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"

class UpdateRegisterState extends State<UpdateRegister> {
  String _numExp;
  String _name;
  String _lastNameP;
  String _lastNameM;
  String _tel;
  String _age;
  String _weight;
  String _fum;
  String _active;
  String _blood;
  String _alergies;
  String _pregnant;
  String _diagnostic;

  String _value;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNumExp() {
    return TextFormField();
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nombre(s)'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildLastNameP() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Apellido Paterno'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
      },
      onSaved: (String value) {
        _lastNameP = value;
      },
    );
  }

  Widget _buildLastNameM() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Apellido Materno'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
      },
      onSaved: (String value) {
        _lastNameM = value;
      },
    );
  }

  Widget _buildTel() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Teléfono'),
      validator: (String value) {
        if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(value)) {
          return 'Inserte un número de teléfono válido';
        }
      },
      onSaved: (String value) {
        _tel = value;
      },
    );
  }

  Widget _buildAge() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Edad'),
      validator: (String value) {
        if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(value) ||
            value.isEmpty) {
          return 'Inserte una edad válida';
        }
      },
      onSaved: (String value) {
        _age = value;
      },
    );
  }

  Widget _buildWeight() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Peso en kilogramos'),
      validator: (String value) {
        if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(value) ||
            value.isEmpty) {
          return 'Inserte un peso válido';
        }
      },
      onSaved: (String value) {
        _weight = value;
      },
    );
  }

  Widget _buildFum() {
    return TextFormField();
  }

  Widget _buildActive() {
    return TextFormField();
  }

  Widget _buildBlood() {
    return TextFormField();
  }

  Widget _buildAlergies() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Peso en kilogramos'),
      validator: (String value) {
        if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(value) ||
            value.isEmpty) {
          return 'Inserte un peso válido';
        }
      },
      onSaved: (String value) {
        _weight = value;
      },
    );
  }

  Widget _buildPregnant() {
    return TextFormField();
  }

  Widget _buildDiagnostic() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Peso en kilogramos'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Campo obligatorio';
        }
      },
      onSaved: (String value) {
        _weight = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Paciente')),
      body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //_buildNumExp(),
                  _buildName(),
                  _buildLastNameP(),
                  _buildLastNameM(),
                  _buildTel(),
                  _buildAge(),
                  _buildWeight(),
                  _buildFum(),
                  // _buildActive(),
                  // _buildBlood(),
                  // _buildAlergies(),
                  // _buildPregnant(),
                  // _buildDiagnostic(),
                  SizedBox(height: 20),
                  RaisedButton(
                      child: Text(
                        'Actualizar',
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          return;
                        }

                        _formKey.currentState.save();
                        print(_name);
                      })
                ],
              ))),
    );
  }
}
