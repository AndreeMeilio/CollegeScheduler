
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/logs_local_data.dart';
import 'package:college_scheduler/data/models/logs_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef EventsLogsStateType = StateGeneral<EventsLogsState, List<LogsModel?>?>;

class EventsLogsState {}
class EventsLogsInitialState extends EventsLogsState{}
class EventsLogsLoadingState extends EventsLogsState{}
class EventsLogsLoadedState extends EventsLogsState{}
class EventsLogsFailedState extends EventsLogsState{}

class EventsLogsCubit extends Cubit<EventsLogsStateType>{
  final LogsLocalData _logsLocalData;

  EventsLogsCubit({
    required LogsLocalData logsLocalData
  }) : _logsLocalData = logsLocalData,
       super(EventsLogsStateType(state: EventsLogsInitialState()));

  EventsLogsStateType _logsState = EventsLogsStateType(state: EventsLogsInitialState());
  Future<void> getLogs() async{
    try {
      _logsState = EventsLogsStateType(state: EventsLogsLoadingState());
      emit(_logsState);

      final result = await _logsLocalData.getLogs(
        tableAction: "events"
      );

      if (result.code == "00"){
        _logsState = EventsLogsStateType(
          state: EventsLogsLoadedState(),
          message: result.message,
          code: result.code,
          data: result.data
        );
      } else {
        _logsState = EventsLogsStateType(
          state: EventsLogsFailedState(),
          code: result.code,
          message: result.message,
          data: []
        );
      }

      emit(_logsState);

    } catch (e){
      _logsState = EventsLogsStateType(
        state: EventsLogsFailedState(),
        code: "01",
        message: "There's a problem when getting data logs",
        data: []
      );
      emit(_logsState);
    }
  }
}