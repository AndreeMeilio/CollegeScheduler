
import 'package:college_scheduler/config/constants_value.dart';
import 'package:college_scheduler/config/database.dart';
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/data/models/class_model.dart';
import 'package:flutter/material.dart';

class ClassLocalData {
  final DatabaseConfig _database;

  ClassLocalData({
    required DatabaseConfig database
  }) : _database = database;

  Future<ResponseGeneral<int>> createAndUpdateClass({
    required ClassModel data
  }) async{
    try {
      final db = await _database.getDB();
      final shared = SharedPreferenceConfig();

      final result = await db.transaction((trx) async{
        final userIdShared = await shared.getInt(key: ConstansValue.user_id);
        final startHourFirstPart = (data.startHour?.hour ?? 0) < 10 ? "0${data.startHour?.hour}" : data.startHour?.hour;
        final startHourSecondPart = (data.startHour?.minute ?? 0) < 10 ? "0${data.startHour?.minute}" : data.startHour?.minute;

        final endHourFirstPart = (data.endHour?.hour ?? 0) < 10 ? "0${data.endHour?.hour}" : data.endHour?.hour;
        final endHourSecondPart = (data.endHour?.minute ?? 0) < 10 ? "0${data.endHour?.minute}" : data.endHour?.minute;

        late int resultQuery;

        if (data.id != null && data.id != 0){
          resultQuery = await trx.update("class", {
            "user_id" : userIdShared,
            "name" : data.name ?? "",
            "start_hour" : "$startHourFirstPart:$startHourSecondPart:00",
            "end_hour": "$endHourFirstPart:$endHourSecondPart:00",
            "day" : data.day?.name,
            "lecturer_name": data.lecturerName,
            "updated_at" : DateTime.now().toString()
          }, where: "id = ?", whereArgs: [data.id]);
        } else {
          resultQuery = await trx.insert("class", {
            "user_id" : userIdShared,
            "name" : data.name ?? "",
            "start_hour" : "$startHourFirstPart:$startHourSecondPart:00",
            "end_hour": "$endHourFirstPart:$endHourSecondPart:00",
            "day" : data.day?.name,
            "lecturer_name": data.lecturerName,
            "created_at" : DateTime.now().toString(),
            "updated_at" : DateTime.now().toString()
          });
        }

        return resultQuery;
      });

      if (result >= 1){
        return ResponseGeneral(
          code: "00",
          message: "Creating new data class successfully",
          data: result
        );
      } else {
        return ResponseGeneral(
          code: "01",
          message: "There's a problem creating new data class! sorry );",
          data: -1
        );
      }
    } catch (e){
      return ResponseGeneral(
        code: "01",
        message: "There's a problem creating new data class! sorry );",
        data: -1
      );
    }
  }

  Future<ResponseGeneral<int>> delete({
    required ClassModel data
  }) async{
    try {
      final db = await _database.getDB();
      final shared = SharedPreferenceConfig();

      final result = await db.transaction((trx) async{
        final resultQuery = await trx.delete("class", where: 'id = ?', whereArgs: [data.id]);

        return resultQuery;
      });

      if (result >= 1){
        return ResponseGeneral(
          code: "00",
          message: "deleting data class successfully",
          data: result
        );
      } else {
        return ResponseGeneral(
          code: "01",
          message: "There's a problem deleting data class! sorry );",
          data: -1
        );
      }
    } catch (e){
      return ResponseGeneral(
        code: "01",
        message: "There's a problem deleting data class! sorry );",
        data: -1
      );
    }
  }

  Future<ClassModelResponse> getAllClass() async{
    try {
      final db = await _database.getDB();
      final shared = SharedPreferenceConfig();

      final result = await db.transaction<List<Map>>((trx) async{
        final userIdShared = await shared.getInt(key: ConstansValue.user_id);
        final resultQuery = await trx.query("class", where: 'user_id = ?', whereArgs: [userIdShared]);

        return resultQuery;
      });

      if (result.isNotEmpty){

        return ClassModelResponse(
          code: "00",
          message: "Get class data success",
          data: result.map<ClassModel>((data) {
            DAYOFWEEK? dayofweek;

            switch(data["day"]){
              case "monday":
                dayofweek = DAYOFWEEK.monday;
                break;
              case "tuesday":
                dayofweek = DAYOFWEEK.tuesday;
                break;
              case "wednesday":
                dayofweek = DAYOFWEEK.wednesday;
                break;
              case "thursday":
                dayofweek = DAYOFWEEK.thursday;
                break;
              case "friday":
                dayofweek = DAYOFWEEK.friday;
                break;
              case "saturday":
                dayofweek = DAYOFWEEK.saturday;
                break;
              case "sunday":
                dayofweek = DAYOFWEEK.sunday;
                break; 
              default:
                dayofweek = DAYOFWEEK.selectDay; 
            }

            return ClassModel(
              id: data["id"],
              userId: data["user_id"],
              name: data["name"],
              lecturerName: data["lecturer_name"],
              day: dayofweek,
              startHour: TimeOfDay.fromDateTime(DateTime.parse("0001-01-01 ${data["start_hour"]}")),
              endHour: TimeOfDay.fromDateTime(DateTime.parse("0001-01-01 ${data["end_hour"]}")),
              createdAt: DateTime.parse(data["created_at"]),
              updatedAt: DateTime.parse(data["updated_at"])
            );
          }).toList()
        );
      } else {
        return ClassModelResponse(
          code: "00",
          message: "You don't have any data on class",
          data: []
        );
      }
    } catch (e){
      return ClassModelResponse(
        code: "01",
        message: "There's a problem creating new data class! sorry );",
        data: []
      );
    }
  }
}