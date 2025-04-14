
class LogsModelResponse {
  String? code;
  String? message;
  List<LogsModel?>? data;

  LogsModelResponse({
    this.code,
    this.message,
    this.data
  });
}

class LogsModel {
  int? id;
  int? userId;
  String? actionName;
  String? tableAction;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  LogsModel({
    this.id,
    this.userId,
    this.actionName,
    this.tableAction,
    this.description,
    this.createdAt,
    this.updatedAt
  });
}