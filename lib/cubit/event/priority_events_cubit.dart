
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/cubit/event/status_events_cubit.dart';
import 'package:college_scheduler/data/local_data/event_local_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef PriorityEventsStateType = StateGeneral<PriorityEventsState, Map<String, int>>;

class PriorityEventsState {}
class PriorityEventsInitialState extends PriorityEventsState{}
class PriorityEventsLoadingState extends PriorityEventsState{}
class PriorityEventsFailedState extends PriorityEventsState{}
class PriorityEventsLoadedState extends PriorityEventsState{}

class PriorityEventsCubit extends Cubit<PriorityEventsStateType>{
  final EventLocalData _eventLocalData;

  PriorityEventsCubit({
    required EventLocalData eventLocalData
  }) : _eventLocalData = eventLocalData,
       super(PriorityEventsStateType(state: PriorityEventsInitialState()));

  PriorityEventsStateType _priorityState = PriorityEventsStateType(state: PriorityEventsInitialState());
  Future<void> getPriorityAllEvents() async{
    try {
      _priorityState = PriorityEventsStateType(state: PriorityEventsLoadingState());
      emit(_priorityState);

      final result = await _eventLocalData.getPriorityAllEvent();

      if (result.code == "00"){
        _priorityState = PriorityEventsStateType(
          state: PriorityEventsLoadedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      } else {
        _priorityState = PriorityEventsStateType(
          state: PriorityEventsFailedState(),
          code: result.code,
          message: result.message,
          data: {}
        );
      }
      emit(_priorityState);
    } catch (e){
      _priorityState = PriorityEventsStateType(
        state: PriorityEventsFailedState(),
        code: "01",
        message: "There's a problem when getting status all events",
        data: {}
      );
      emit(_priorityState);
    }
  }  
}