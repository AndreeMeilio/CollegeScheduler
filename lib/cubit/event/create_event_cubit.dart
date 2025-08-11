
import 'package:college_scheduler/config/notification_config.dart';
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/event_local_data.dart';
import 'package:college_scheduler/data/local_data/reminder_local_data.dart';
import 'package:college_scheduler/data/models/event_model.dart';
import 'package:college_scheduler/data/models/reminder_model.dart';
import 'package:college_scheduler/utils/date_format_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


typedef EventStateType = StateGeneral<CreateAndUpdateEventState, EventModel>;

class CreateAndUpdateEventState {}
class CreateAndUpdateEventInitialState extends CreateAndUpdateEventState{}
class CreateAndUpdateEventLoadingState extends CreateAndUpdateEventState{}
class CreateAndUpdateEventSuccessState extends CreateAndUpdateEventState{}
class CreateAndUpdateEventFailedState extends CreateAndUpdateEventState{}

class CreateAndUpdateEventCubit extends Cubit<EventStateType>{
  final EventLocalData _eventLocalData;
  final ReminderLocalData _reminderLocalData;

  CreateAndUpdateEventCubit({
    required EventLocalData eventLocalData,
    required ReminderLocalData reminderLocalData
  }) : _eventLocalData = eventLocalData,
       _reminderLocalData = reminderLocalData,
       super(StateGeneral(state: CreateAndUpdateEventInitialState()));

  EventStateType eventState = EventStateType(state: CreateAndUpdateEventInitialState());
  Future<void> insertAndUpdateEvent({
    required DateTime dateOfEvent,
    required String title,
    required TimeOfDay startHour,
    TimeOfDay? endHour,
    String? description,
    PRIORITY? priority,
    String? location,
    String? className,
    STATUS? status,
    bool? isEdit,
    int? idEvent
  }) async{
    try {
      eventState = EventStateType(state: CreateAndUpdateEventLoadingState());
      emit(eventState);
  
      final modelRequest = EventModel(
        title: title,
        dateOfEvent: dateOfEvent,
        startHour: startHour,
        endHour: endHour,
        location: location,
        className: className,
        description: description,
        priority: priority,
        status: status
      );
      
      late ResponseGeneral<EventModel> result;
      if ((isEdit ?? false) && idEvent != null){
        modelRequest.id = idEvent;
        result = await _eventLocalData.insertAndUpdate(data: modelRequest);
      } else {
        result = await _eventLocalData.insertAndUpdate(data: modelRequest);
      }

      if (result.code == "00"){
        eventState = EventStateType(
          state: CreateAndUpdateEventSuccessState(),
          code: result.code,
          message: result.message,
          data: result.data
        );

        // Creating notification
        final reminderEventSetting = await _reminderLocalData.getReminderData();
        if (reminderEventSetting.data?.isNotificationOn ?? false){
          await NotificationConfig.cancelEventNotification(id: result.data.id ?? 0);

          if (result.data.status != STATUS.done){
            Duration subtractDuration = Duration(days: reminderEventSetting.data?.numberBeforeType ?? 0);
            if (reminderEventSetting.data?.typeNotification == "Hours"){
              subtractDuration = Duration(hours: reminderEventSetting.data?.numberBeforeType ?? 0);
            }

            DateTime dateTimeForNotification = result.data.dateOfEvent!;

            if (reminderEventSetting.data?.typeHour == "Start Hour") {
              dateTimeForNotification = DateTime.parse("${DateFormatUtils.dateFormatyMMdd(date: dateTimeForNotification)} ${(result.data.startHour?.hour ?? 0) < 10 ? "0${result.data.startHour?.hour}" : result.data.startHour?.hour}:${(result.data.startHour?.minute ?? 0) < 10 ? "0${result.data.startHour?.minute}" : result.data.startHour?.minute}:00");
            } else if (reminderEventSetting.data?.typeHour == "End Hour"){
              dateTimeForNotification = DateTime.parse("${DateFormatUtils.dateFormatyMMdd(date: dateTimeForNotification)} ${(result.data.endHour?.hour ?? 0) < 10 ? "0${result.data.endHour?.hour}" : result.data.endHour?.hour}:${(result.data.endHour?.minute ?? 0) < 10 ? "0${result.data.endHour?.minute}" : result.data.endHour?.minute}:00");
            }

            if (dateTimeForNotification.subtract(subtractDuration).compareTo(DateTime.now()) != -1){
              dateTimeForNotification = dateTimeForNotification.subtract(subtractDuration);
            }

            await NotificationConfig.scheduleEventNotification(
              id: result.data.id ?? 0,
              dateTime: dateTimeForNotification,
              titleNotification: "You have an upcoming event",
              descNotification: "You have an upcoming event with Title ${result.data.title} and ${reminderEventSetting.data?.typeHour == "Start Date" ? "Start Date Time" : "End Date Time"} ${DateFormatUtils.dateFormatddMMMMykkiiss(date: dateTimeForNotification)}, Check it out!",
            );
          }
        }

        emit(eventState);
      } else {
        eventState = EventStateType(
          state: CreateAndUpdateEventFailedState(),
          code: result.code,
          message: result.message,
          data: null
        );
        emit(eventState);
      }

    } catch (e){
      print(e);
      eventState = EventStateType(
        state: CreateAndUpdateEventFailedState(),
        code: "01",
        message: "There's a problem creating new event i am sorry );",
        data: null
      );
      emit(eventState);
    }
  }


  EventModel? tempDataEvent;
  void setTempDataEvent({
    required EventModel data
  }) {
    tempDataEvent = data;
  }

  void clearTempDataEvent(){
    tempDataEvent = null;
  }
}