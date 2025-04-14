
import 'package:college_scheduler/config/database.dart';
import 'package:college_scheduler/data/models/menu_model.dart';

class MenuLocalData {
  final DatabaseConfig _database;

  MenuLocalData({
    required DatabaseConfig database
  }) : _database = database;

  Future<MenuModelResponse> getAllSettingsMenu() async{
    try {
      final db = await _database.getDB();

      final result = await db.transaction<MenuModelResponse>((trx) async{
        final query = await trx.query("menu", orderBy: 'show_order asc');

        if (query.isNotEmpty){
          return MenuModelResponse(
            code: "00",
            message: "Getting all data menu success",
            data: query.map<MenuModel>((data){
              return MenuModel(
                id: int.parse(data["id"].toString()),
                name: data["name"].toString(),
                route: data["route"].toString(),
                isIncoming: data["isIncoming"] == 1,
                parentName: data["parent_menu"].toString(),
                createdAt: DateTime.parse(data["created_at"].toString()),
                updatedAt: DateTime.parse(data["updated_at"].toString())
              );
            }).toList()
          );
        } else {
          return MenuModelResponse(
            code: "00",
            message: "Data menu is empty please wait for a while",
            data: []
          );
        }
      });

      return result;
    } catch (e){
      return MenuModelResponse(
        code: "01",
        message: "There's a problem when getting all data menu",
        data: []
      );
    }
  }
}