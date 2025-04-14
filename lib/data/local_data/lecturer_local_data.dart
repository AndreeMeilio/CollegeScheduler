
import 'package:college_scheduler/config/constants_value.dart';
import 'package:college_scheduler/config/database.dart';
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/data/models/lecturer_model.dart';

class LecturerLocalData {
  final DatabaseConfig _database;

  LecturerLocalData({
    required DatabaseConfig database
  }) : _database = database;

  Future<ResponseGeneral<int>> createLecturer({
    required String name,
    bool? isEditData,
    int? idLecturer
  }) async {
    final db = await _database.getDB();
    final shared = SharedPreferenceConfig();

    try {

      final result = await db.transaction<ResponseGeneral<int>>((trx) async{
        final userId = await shared.getInt(key: ConstansValue.user_id);

        late int query;

        if ((isEditData ?? false) && idLecturer != null) {
          query = await trx.update("lecturer", {
            "user_id" : userId,
            "name": name,
            "created_at": DateTime.now().toString(),
            "updated_at" : DateTime.now().toString()
          }, where: 'id = ?', whereArgs: [idLecturer]);
        } else {
          query = await trx.insert("lecturer", {
            "user_id" : userId,
            "name": name,
            "created_at": DateTime.now().toString(),
            "updated_at" : DateTime.now().toString()
          });
        }

        if (query >= 1){
          return ResponseGeneral(
            code: "00",
            message: "Create data lecturer successfully",
            data: query
          );
        } else {
          return ResponseGeneral(
            code: "01",
            message: "Creating data lecturer failed, i am sorry!",
            data: -1
          );
        }
      });

      return result;

    } catch (e){
      return ResponseGeneral(
        code: "01",
        message: "There's a problem when creating data lecturer",
        data: -1
      );
    }
  }

  Future<ResponseGeneral<int>> delete({
    required LecturerModel data
  }) async {
    try {
      final db = await _database.getDB();
      final shared = SharedPreferenceConfig();

      final result = await db.transaction<ResponseGeneral<int>>((trx) async{
        final query = await trx.delete('lecturer', where: 'id = ?', whereArgs: [data.id]);

        if (query >= 1){
          return ResponseGeneral(
            code: "00",
            message: "Deleting data Lecturer success",
            data: query
          );
        } else {
          return ResponseGeneral(
            code: "01",
            message: "Deleting data Lecturer failed, i am sorry!",
            data: query
          );
        }
      });

      return result;
    } catch (e){
      return ResponseGeneral(
        code: "01",
        message: "There's a problem deleting data Lecturer",
        data: -1
      );
    }
  }

  Future<LecturerModelResponse> getAllData() async{
    try {
      final db = await _database.getDB();
      final shared = SharedPreferenceConfig();

      final getData = await db.transaction<LecturerModelResponse>((trx) async{
        final userId = await shared.getInt(key: ConstansValue.user_id);

        final queryGet = await trx.query("lecturer", where: 'user_id = ?', whereArgs: [userId]);

        if (queryGet.isNotEmpty){
          return LecturerModelResponse(
            code: "00",
            message: "Getting data lecturer successfully",
            data: queryGet.map<LecturerModel>((data){
              return LecturerModel(
                id: int.parse(data["id"].toString()),
                userId: int.parse(data["user_id"].toString()),
                name: data["name"].toString(),
                createdAt: DateTime.parse(data["created_at"].toString()),
                updatedAt: DateTime.parse(data["updated_at"].toString())
              );
            }).toList()
          );
        } else {
          return LecturerModelResponse(
            code: "00",
            message: "You don't have any data on lecturer",
            data: []
          );
        }
      });

      return getData;

    } catch (e){
      return LecturerModelResponse(
        code: "01",
        message: "There's a problem getting data lecturer!",
        data: []
      );
    }
  }
}