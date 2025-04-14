
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/lecturer_local_data.dart';
import 'package:college_scheduler/data/models/lecturer_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ListLecturerStateType = StateGeneral<ListLecturerState, List<LecturerModel?>?>;

class ListLecturerState {}
class ListLecturerInitialState extends ListLecturerState {}
class ListLecturerLoadingState extends ListLecturerState {}
class ListLecturerLoadedState extends ListLecturerState {}
class ListLecturerFailedState extends ListLecturerState {}

class ListLecturerCubit extends Cubit<ListLecturerStateType>{
  final LecturerLocalData _lecturerLocalData;

  ListLecturerCubit({
    required LecturerLocalData lecturerLocalData
  }) : _lecturerLocalData = lecturerLocalData,
       super(ListLecturerStateType(state: ListLecturerInitialState()));


  ListLecturerStateType _dataState = ListLecturerStateType(state: ListLecturerInitialState());
  Future<void> getAllData() async{
    try {
      _dataState = ListLecturerStateType(state: ListLecturerLoadingState());
      emit(_dataState);

      final resultData = await _lecturerLocalData.getAllData();
      if (resultData.code == "00"){
        _dataState = ListLecturerStateType(
          state: ListLecturerLoadedState(),
          code: resultData.code,
          message: resultData.message,
          data: resultData.data
        );
      } else {
        _dataState = ListLecturerStateType(
          state: ListLecturerFailedState(),
          code: resultData.code,
          message: resultData.message,
          data: []
        );
      }

      emit(_dataState);
    } catch (e){
      _dataState = ListLecturerStateType(
        state: ListLecturerFailedState(),
        code: "01",
        data: [],
        message: "There's a problem when getting data Lecturer"
      );

      emit(_dataState);
    }
  }

  Future<void> deleteData({
    required LecturerModel data
  }) async{
    try {
      _dataState = ListLecturerStateType(state: ListLecturerLoadingState());
      emit(_dataState);

      final resultDelete = await _lecturerLocalData.delete(data: data);

      if (resultDelete.code == "00"){
        await getAllData();
      } else {
        _dataState = ListLecturerStateType(
          state: ListLecturerFailedState(),
          code: resultDelete.code,
          message: resultDelete.message,
          data: []
        );
      }

      emit(_dataState);
      
    } catch (e){
      _dataState = ListLecturerStateType(
        state:  ListLecturerFailedState(),
        code: "01",
        message: "There's a problem deleting data Lecturer",
        data: []
      );

      emit(_dataState);
    }
  }
}