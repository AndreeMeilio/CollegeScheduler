import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/event_local_data.dart';
import 'package:college_scheduler/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ListEventStateType = StateGeneral<ListEventState, List<EventModel?>>;

class ListEventState {}

class ListEventInitialState extends ListEventState{}
class ListEventLoadingState extends ListEventState{}
class ListEventLoadedState extends ListEventState{}
class ListEventFailedState extends ListEventState{}


class ListEventCubit extends Cubit<ListEventStateType>{
  late EventLocalData _eventLocalData;

  ListEventCubit({
    required EventLocalData eventLocalData,
  }) : _eventLocalData = eventLocalData,
       super(ListEventStateType(state: ListEventInitialState()));

  ListEventStateType listState = ListEventStateType(state: ListEventInitialState());
  Future<void> getAllEvent({
    String? searchItem,
    PRIORITY? priorty,
    STATUS? status,
    DateTimeRange? dateRangeEvent,
    int? limit,
  }) async{
    try {
      listState = ListEventStateType(state: ListEventLoadingState());
      emit(listState);

      final result = await _eventLocalData.getAllEvent(
        searchItem: searchItem,
        priority: priorty,
        status: status,
        dateRangeEvent: dateRangeEvent,
        limit: limit
      );

      if (result.code == "00"){
        listState = ListEventStateType(
          state: ListEventLoadedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      } else {
        listState = ListEventStateType(
          state: ListEventFailedState(),
          code: "",
          message: "There's a problem when getting your event data!",
          data: []
        );
      }
      emit(listState);

    } catch (e){
      listState = ListEventStateType(
        state: ListEventFailedState(),
        code: "",
        message: "There's a problem when getting your event data!",
        data: []
      );
      emit(listState);
    }
  }

  Future<void> deleteEvent({
    required EventModel data
  }) async{
    try {
      listState = ListEventStateType(state: ListEventLoadingState());
      emit(listState);

      final result = await _eventLocalData.deleteEvent(data: data);

      if (result.code == "00"){
        getAllEvent();
      } else {
        listState = ListEventStateType(
          state: ListEventFailedState(),
          code: "",
          message: "There's a problem when deleting event data!",
          data: []
        );
        emit(listState);
      }
    } catch (e){
      listState = ListEventStateType(
        state: ListEventFailedState(),
        code: "",
        message: "There's a problem when getting your event data!",
        data: []
      );
      emit(listState);
    }
  }
}