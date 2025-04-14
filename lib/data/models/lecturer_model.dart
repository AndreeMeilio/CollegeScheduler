
class LecturerModelResponse {
  String? code;
  String? message;
  List<LecturerModel?>? data;

  LecturerModelResponse({
    this.code,
    this.message,
    this.data
  });
}

class LecturerModel {
  int? id;
  int? userId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  LecturerModel({
    this.id,
    this.userId,
    this.name,
    this.createdAt,
    this.updatedAt
  });
}