class Patient {
  int numExp;
  String name;
  String lastNameP;
  String lastNameM;
  String tel;
  // String age;
  // String weight;
  // String fum;
  // String active;
  // String blood;
  // String alergies;
  // String pregnant;
  // String diagnostic;

  Patient({this.numExp, this.name, this.lastNameP, this.lastNameM, this.tel});

  Map<String, dynamic> toMap() {
    return {
      'id': numExp,
      'nombre': name,
      'apellidop': lastNameP,
      'apellidom': lastNameM,
      'tel': tel
    };
  }
}
