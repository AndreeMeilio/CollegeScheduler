
import 'package:college_scheduler/config/constants_value.dart';
import 'package:college_scheduler/config/database.dart';
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/data/models/logs_model.dart';

class LogsLocalData {
  final DatabaseConfig _database;

  LogsLocalData({
    required DatabaseConfig database
  }) : _database = database;

  Future<LogsModelResponse> getLogs({
    String? actionName,
    String? tableAction
  }) async{
    final db = await _database.getDB();
    final shared = SharedPreferenceConfig();

    try {
      final result = await db.transaction((trx) async{
        final userId = await shared.getInt(key: ConstansValue.user_id);

        String whereQuery = 'user_id = ?';
        List<Object> whereArgsList = List.from([userId]);

        if (actionName?.isNotEmpty ?? false){
          whereQuery += " and action_name = ?";
          whereArgsList.add(actionName!);
        } else if (tableAction?.isNotEmpty ?? false){
          whereQuery += " and table_action = ?";
          whereArgsList.add(tableAction!);
        }

        final resultQuery = await trx.query("logs", where: whereQuery, orderBy: 'created_at desc', whereArgs: whereArgsList);

        return resultQuery;
      });

      if (result.isNotEmpty){
        return LogsModelResponse(
          code: "00",
          message: "Getting data login history success",
          data: result.map<LogsModel>((data){
            return LogsModel(
              id: int.parse(data["id"].toString()),
              actionName: data["action_name"].toString(),
              description: data["description"].toString(),
              tableAction: data["table_action"].toString(),
              userId: int.parse(data["user_id"].toString()),
              createdAt: DateTime.parse(data["created_at"].toString()),
              updatedAt: DateTime.parse(data["updated_at"].toString())
            );
          }).toList()
        );
      } else {
        return LogsModelResponse(
          code: "00",
          message: "You don't have any data on login history",
          data: []
        );
      }
    } catch (e){
      return LogsModelResponse(
        code: "01",
        message: "There's a problem when getting the data",
        data: []
      );
    }
  }

  Future<ResponseGeneral<int>> createLogs({
    required LogsModel data
  }) async{
    final db = await _database.getDB();
    final shared = SharedPreferenceConfig();

    try {
      final result = await db.transaction((trx) async{
        final userId = await shared.getInt(key: ConstansValue.user_id);
        final resultQuery = await trx.insert("logs", {
          "user_id" : userId,
          "action_name": data.actionName,
          "table_action": data.tableAction,
          "description": data.description,
          "created_at": DateTime.now().toString(),
          "updated_at": DateTime.now().toString()
        });

        return resultQuery;
      });

      if (result >= 1){
        return ResponseGeneral(
          code: "00",
          message: "Creating log success",
          data: result
        );
      } else {
        return ResponseGeneral(
          code: "01",
          message: "There's a problem creating log",
          data: -1
        );
      }
    } catch (e){
      return ResponseGeneral(
        code: "01",
        message: "There's a problem creating log",
        data: -1
      );
    }
  }
}