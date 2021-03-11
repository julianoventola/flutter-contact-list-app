import 'package:helioaula/app/database/sqlite/script.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqLiteConnection {
  static Database _database;

  static Future<Database> get() async {
    if (_database == null) {
      var path = join(await getDatabasesPath(), 'contact');
      //deleteDatabase(path);
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (_database, version) {
          _database.execute(createTable);
          _database.execute(insert1);
          _database.execute(insert2);
          _database.execute(insert3);
        },
      );
    }

    return _database;
  }
}
