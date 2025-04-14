
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/event_local_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef StatusEventsStateType = StateGeneral<StatusEventsState, Map<String, int>>;

class StatusEventsState{}
class StatusEventsInitialState extends StatusEventsState{}
class StatusEventsLoadingState extends StatusEventsState{}
class StatusEventsLoadedState extends StatusEventsState{}
class StatusEventsFailedState extends StatusEventsState{}

class StatusEventsCubit extends Cubit<StatusEventsStateType>{
  final EventLocalData _eventLocalData;

  StatusEventsCubit({
    required EventLocalData eventLocalData
  }) : _eventLocalData = eventLocalData,
       super(StatusEventsStateType(state: StatusEventsInitialState()));

  StatusEventsStateType _statusAllState = StatusEventsStateType(state: StatusEventsInitialState());
  Future<void> getStatusAllEvents() async{
    try {
      _statusAllState = StatusEventsStateType(state: StatusEventsLoadingState());
      emit(_statusAllState);

      final result = await _eventLocalData.getStatusAllEvent();

      if (result.code == "00"){
        _statusAllState = StatusEventsStateType(
          state: StatusEventsLoadedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      } else {
        _statusAllState = StatusEventsStateType(
          state: StatusEventsFailedState(),
          code: result.code,
          message: result.message,
          data: {}
        );
      }
      emit(_statusAllState);
    } catch (e){
      _statusAllState = StatusEventsStateType(
        state: StatusEventsFailedState(),
        code: "01",
        message: "There's a problem when getting status all events",
        data: {}
      );
      emit(_statusAllState);
    }
  }
} 