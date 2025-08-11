
import 'package:college_scheduler/config/constants_value.dart';
import 'package:college_scheduler/config/database.dart';
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/data/models/reminder_model.dart';
import 'package:sqflite/sqlite_api.dart';

class ReminderLocalData {
  final DatabaseConfig _database;

  ReminderLocalData({
    required DatabaseConfig database
  }) : _database = database;

  Future<ResponseGeneral<ReminderModel?>> getReminderData() async{
    try {
      final db = await _database.getDB();
      final shared = SharedPreferenceConfig();

      final result = db.transaction<ResponseGeneral<ReminderModel?>>((trx) async {
        final userId = await shared.getInt(key: ConstansValue.user_id);

        final data = await trx.query("notification_settings", where: "user_id = ?", whereArgs: [userId], limit: 1);

        if (data.isNotEmpty){
          final dataReminder = data.first;

          return ResponseGeneral(
            code: "00", 
            message: "Get Data Reminder Event Setting Success", 
            data: ReminderModel(
              id: int.parse(dataReminder["id"].toString()),
              isNotificationOn: int.parse(dataReminder["is_notification_on"].toString()) == 1 ? true : false,
              typeHour: dataReminder["type_hour"].toString(),
              numberBeforeType: int.parse(dataReminder["number_before_type"].toString()),
              typeNotification: dataReminder["type_notification"].toString()
            )
          );
        } else {
          return ResponseGeneral(
            code: "00", 
            message: "Data is not found", 
            data: null
          );
        }
      });

      return result;
    } catch (e){
      return ResponseGeneral(
        code: "01", 
        message: "There's a problem when setting reminder event", 
        data: null
      );
    }
  }

  Future<ResponseGeneral<int>> createReminderData({required ReminderModel dataRequest}) async{
    try {
      final db = await _database.getDB();
      final shared = SharedPreferenceConfig();

      final result = db.transaction<ResponseGeneral<int>>((trx) async{
        final userId = await shared.getInt(key: ConstansValue.user_id);

        final checkIfDataExist = await trx.query("notification_settings", where: "user_id = ?", whereArgs: [userId]);

        late int query;
        if (checkIfDataExist.isNotEmpty){
          query = await trx.update("notification_settings", {
            "is_notification_on" : dataRequest.isNotificationOn ?? false ? 1 : 0,
            "number_before_type" : dataRequest.numberBeforeType,
            "type_notification" : dataRequest.typeNotification,
            "type_hour": dataRequest.typeHour,
            "user_id" : userId,
            "updated_at" : DateTime.now().toString()
          }, where: "user_id = ?", whereArgs: [userId]);
        } else {
          query = await trx.insert("notification_settings", {
            "is_notification_on" : dataRequest.isNotificationOn ?? false ? 1 : 0,
            "number_before_type" : dataRequest.numberBeforeType,
            "type_notification" : dataRequest.typeNotification,
            "type_hour": dataRequest.typeHour,
            "user_id" : userId,
            "create_at" : DateTime.now().toString(),
            "updated_at" : DateTime.now().toString()
          });
        }

        if (query >= 1){
          return ResponseGeneral(
            code: "00",
            message: "Setting data reminder successfully",
            data: query
          );
        } else {
          return ResponseGeneral(
            code: "01",
            message: "Setting data reminder failed, i am sorry!",
            data: -1
          );
        }
      });

      return result;
    } catch (e){
      return ResponseGeneral(
        code: "01", 
        message: "There's a problem when setting reminder event", 
        data: -1
      );
    }
  } 
}