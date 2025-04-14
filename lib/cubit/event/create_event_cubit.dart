
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/event_local_data.dart';
import 'package:college_scheduler/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


typedef EventStateType = StateGeneral<CreateAndUpdateEventState, int>;

class CreateAndUpdateEventState {}
class CreateAndUpdateEventInitialState extends CreateAndUpdateEventState{}
class CreateAndUpdateEventLoadingState extends CreateAndUpdateEventState{}
class CreateAndUpdateEventSuccessState extends CreateAndUpdateEventState{}
class CreateAndUpdateEventFailedState extends CreateAndUpdateEventState{}

class CreateAndUpdateEventCubit extends Cubit<EventStateType>{
  final EventLocalData _eventLocalData;

  CreateAndUpdateEventCubit({
    required EventLocalData eventLocalData
  }) : _eventLocalData = eventLocalData,
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
      
      late ResponseGeneral result;
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
        emit(eventState);
      } else {
        eventState = EventStateType(
          state: CreateAndUpdateEventFailedState(),
          code: result.code,
          message: result.message,
          data: -1
        );
        emit(eventState);
      }

    } catch (e){
      eventState = EventStateType(
        state: CreateAndUpdateEventFailedState(),
        code: "01",
        message: "There's a problem creating new event i am sorry );",
        data: -1
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