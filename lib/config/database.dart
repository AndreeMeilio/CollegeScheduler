import 'package:college_scheduler/config/constants_value.dart';
import 'package:college_scheduler/config/database_version_scheme.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConfig {

  String? _databasePath;
  Database? _database;

  Future<Database> getDB() async{
    if (_database != null) return _database!;

    String pathDatabase = await getDatabasesPath();
    _databasePath = join(pathDatabase, ConstansValue.databaseFilename);
    _database = await openDatabase(
      _databasePath!,
      version: ConstansValue.databaseVersion,
      onCreate: (Database db, int version) async{
        for (int dbVersion = 0; dbVersion < version; dbVersion++){
          final databaseScheme = DatabaseVersionScheme(db, dbVersion + 1);
          await databaseScheme.databaseScheme();
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async{
        for (int version = oldVersion; version < newVersion; version++){
          final databaseScheme = DatabaseVersionScheme(db, version + 1);
          await databaseScheme.databaseScheme();
        }
      },
    );

    return _database!;
  }
}

