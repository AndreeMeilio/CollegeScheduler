
import 'package:flutter/material.dart';

enum DAYOFWEEK {
  selectDay,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

class ClassModelResponse {
  String? code;
  String? message;
  List<ClassModel?>? data;

  ClassModelResponse({
    this.code,
    this.message,
    this.data
  });
}

class ClassModel {
  int? id;
  int? userId;
  String? name;
  String? lecturerName;
  DAYOFWEEK? day;
  TimeOfDay? startHour;
  TimeOfDay? endHour;
  DateTime? createdAt;
  DateTime? updatedAt;

  ClassModel({
    this.id,
    this.userId,
    this.name,
    this.lecturerName,
    this.day,
    this.startHour,
    this.endHour,
    this.createdAt,
    this.updatedAt
  });
}