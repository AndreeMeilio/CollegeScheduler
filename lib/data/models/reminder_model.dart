
class ReminderResponseModel{
  String? code;
  String? message;
  ReminderModel? data;

  ReminderResponseModel({
    this.code,
    this.message,
    this.data
  });
}

class ReminderModel {
  int? id;
  bool? isNotificationOn;
  int? numberBeforeType;
  String? typeNotification;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  String? typeHour;

  ReminderModel({
    this.id,
    this.isNotificationOn,
    this.numberBeforeType,
    this.typeNotification,
    this.userId,
    this.typeHour,
    this.createdAt,
    this.updatedAt
  });
}