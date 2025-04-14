
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/class_local_data.dart';
import 'package:college_scheduler/data/models/class_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListDataClassState {}
class ListDataClassInitialState extends ListDataClassState{}
class ListDataClassLoadingState extends ListDataClassState{}
class ListDataClassLoadedState extends ListDataClassState{}
class ListDataClassFailedState extends ListDataClassState{}

typedef ListDataClassStateType = StateGeneral<ListDataClassState, List<ClassModel?>>;

class ListDataClassCubit extends Cubit<ListDataClassStateType>{
  final ClassLocalData _classLocalData;

  ListDataClassCubit({
    required ClassLocalData classLocalData
  }) : _classLocalData = classLocalData,
       super(ListDataClassStateType(state: ListDataClassInitialState()));
  
  ListDataClassStateType listState = ListDataClassStateType(state: ListDataClassInitialState());
  Future<void> getAllData() async{
    try {
      listState = ListDataClassStateType(state: ListDataClassLoadingState());
      emit(listState);

      final result = await _classLocalData.getAllClass();

      if (result.code == "00"){
        if (result.data?.isNotEmpty ?? false){
          listState = ListDataClassStateType(
            state: ListDataClassLoadedState(),
            code: result.code,
            message: result.message,
            data: result.data
          );
        } else {
          listState = ListDataClassStateType(
            state: ListDataClassLoadedState(),
            code: result.code,
            message: result.message,
            data: result.data
          );
        }
      } else {
        listState = ListDataClassStateType(
          state: ListDataClassFailedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      }

      emit(listState);

    } catch (e){
      listState = ListDataClassStateType(
        state: ListDataClassFailedState(),
        code: "01",
        message: "There's a problem when getting class data",
        data: []
      );
      emit(listState);
    }
  }

  Future<void> deleteData({
    required ClassModel data
  }) async{
    try {
      listState = ListDataClassStateType(state: ListDataClassLoadingState());
      emit(listState);

      final result = await _classLocalData.delete(data: data);

      if (result.code == "00"){
        await getAllData();
      } else {
        listState = ListDataClassStateType(
          state: ListDataClassFailedState(),
          code: "01",
          message: "There's a problem when deleting class data",
          data: []
        );
        emit(listState);
      }

    } catch (e){
      listState = ListDataClassStateType(
        state: ListDataClassFailedState(),
        code: "01",
        message: "There's a problem when getting class data",
        data: []
      );
      emit(listState);
    }
  }
}