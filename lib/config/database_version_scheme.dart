
import 'package:sqflite/sqflite.dart';

class DatabaseVersionScheme {

  late Database _db;
  late int _version;

  DatabaseVersionScheme(Database db, int version): _db = db, _version = version;

  Future<void> databaseScheme() async{
    switch(_version){
      case 1:
        await databaseVersion_1();
        break;
    }
  }

  Future<void> databaseVersion_1() async{
    await _db.execute(
      """
        create table users(
          id integer primary key autoincrement,
          device_id text,
          fullname text,
          username text,
          password text,
          salt text,
          created_at text,
          updated_at text
        )
      """
    );
    await _db.execute(
      """
        create table events(
          id integer primary key autoincrement,
          user_id integer,
          date_of_event text,
          title text,
          start_hour text,
          end_hour text,
          location text,
          class_name text,
          description text,
          priority text,
          status text,
          created_at text,
          updated_at text
        )
      """
    );
    await _db.execute(
      """
        create table class(
          id integer primary key autoincrement,
          user_id integer,
          name text,
          start_hour text,
          end_hour text,
          day text,
          lecturer_name text,
          created_at text,
          updated_at text
        )
      """
    );
    await _db.execute(
      """
        create table logs(
          id integer primary key autoincrement,
          user_id integer,
          action_name text,
          table_action text,
          description text,
          created_at text,
          updated_at text
        )
      """
    );
    await _db.execute(
      """
        create table lecturer(
          id integer primary key autoincrement,
          user_id integer,
          name text,
          created_at text,
          updated_at text
        )
      """
    );

    await _db.execute(
      """
        create table menu(
          id integer primary key autoincrement,
          name text,
          route text,
          isIncoming integer,
          parent_menu string,
          show_order integer,
          created_at text,
          updated_at text
        )
      """
    );

    await _db.execute(
      """
        create table notification_settings(
          id integer primary key autoincrement,
          is_notification_on integer,
          number_before_type integer,
          type_notification text,
          type_hour text,
          user_id integer,
          create_at text,
          updated_at text
        )
      """
    );

    await _db.transaction((trx) async{
      Batch batch = trx.batch();

      // MENU DATA  
      batch.insert("menu", {
        "name": "menuDataClass",
        "route": "/class",
        "isIncoming": 0,
        "show_order": 1,
        "parent_menu": "data",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "menuDataLecturer",
        "route": "/lecturer",
        "isIncoming": 0,
        "show_order": 2,
        "parent_menu": "data",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "menuEventHistory",
        "route": "/events/history",
        "isIncoming": 0,
        "show_order": 3,
        "parent_menu": "data",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });

      //MENU NOTIFICATION
      batch.insert("menu", {
        "name": "menuReminderEvent",
        "route": "/reminder-event",
        "isIncoming": 0,
        "show_order": 101,
        "parent_menu": "notification",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "menuPendingNotification",
        "route": "/pending-notification",
        "isIncoming": 0,
        "show_order": 102,
        "parent_menu": "notification",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });


      //MENU ACCOUNT
      batch.insert("menu", {
        "name": "menuChangePassword",
        "route": "/change-password",
        "isIncoming": 0,
        "show_order": 201,
        "parent_menu": "account",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "menuChangeFullnameOrUsername",
        "route": "/change-fullname-or-username",
        "isIncoming": 0,
        "show_order": 202,
        "parent_menu": "account",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "menuLoginHistory",
        "route": "/login/history",
        "isIncoming": 0,
        "show_order": 203,
        "parent_menu": "account",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "menuExportDatabase",
        "route": "/export-db",
        "isIncoming": 1,
        "show_order": 204,
        "parent_menu": "account",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "menuImportDatabase",
        "route": "/import-db",
        "isIncoming": 1,
        "show_order": 205,
        "parent_menu": "account",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });
      batch.insert("menu", {
        "name": "menuLogout",
        "route": "/logout",
        "isIncoming": 0,
        "show_order": 299,
        "parent_menu": "account",
        "created_at": DateTime.now().toString(),
        "updated_at": DateTime.now().toString()
      });

      await batch.commit();
    });
  }
}