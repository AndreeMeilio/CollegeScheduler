
class MenuModelResponse {
  String? code;
  String? message;
  List<MenuModel?>? data;

  MenuModelResponse({
    this.code,
    this.message,
    this.data
  });
}

class MenuModel {
  int? id;
  String? name;
  String? route;
  String? parentName;
  bool? isIncoming;
  int? showOrder;
  DateTime? createdAt;
  DateTime? updatedAt;

  MenuModel({
    this.id,
    this.name,
    this.route,
    this.parentName,
    this.isIncoming,
    this.showOrder,
    this.createdAt,
    this.updatedAt
  });
}