import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = 'localhost',
      user = 'aruzab',
      password = 'david123',
      db = 'Ginnacle';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);

    var conn = await MySqlConnection.connect(settings);
  }
}