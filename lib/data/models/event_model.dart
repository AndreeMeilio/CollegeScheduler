
import 'package:flutter/material.dart';

enum PRIORITY {
  selectPriority,
  low,
  medium,
  high
}

enum STATUS {
  selectStatus,
  idle,
  progress,
  done
}

class EventModelResponse{
  String? code;
  String? message;
  List<EventModel?>? data;

  EventModelResponse({
    this.code,
    this.message,
    this.data
  });
}

class EventModel {
  int? id;
  int? userId;
  String? title;
  DateTime? dateOfEvent;
  TimeOfDay? startHour;
  TimeOfDay? endHour;
  String? location;
  String? description;
  String? className;
  PRIORITY? priority;
  STATUS? status;

  EventModel({
    this.id,
    this.userId,
    this.title,
    this.dateOfEvent,
    this.startHour,
    this.endHour,
    this.location,
    this.description,
    this.className,
    this.priority,
    this.status
  });
}