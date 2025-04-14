
import 'package:college_scheduler/config/response_general.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/class_local_data.dart';
import 'package:college_scheduler/data/models/class_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAndUpdateDataClassState {}
class CreateAndUpdateDataClassInitialState extends CreateAndUpdateDataClassState {}
class CreateAndUpdateDataClassSuccessState extends CreateAndUpdateDataClassState {}
class CreateAndUpdateDataClassFailedState extends CreateAndUpdateDataClassState {}
class CreateAndUpdateDataClassLoadingState extends CreateAndUpdateDataClassState {}

typedef CreateAndUpdateDataClassStateType = StateGeneral<CreateAndUpdateDataClassState, int>;

class CreateAndUpdateDataClassCubit extends Cubit<CreateAndUpdateDataClassStateType>{
  final ClassLocalData _classLocalData;

  CreateAndUpdateDataClassCubit({
    required ClassLocalData classLocalData
  }) : _classLocalData = classLocalData,
       super(CreateAndUpdateDataClassStateType(state: CreateAndUpdateDataClassInitialState()));

  CreateAndUpdateDataClassStateType createAndUpdateState = CreateAndUpdateDataClassStateType(state: CreateAndUpdateDataClassInitialState());
  Future<void> createAndUpdateClass({
    required String name,
    required DAYOFWEEK dayofweek,
    required TimeOfDay startHour,
    TimeOfDay? endHour,
    String? lecturerName,
    bool? isEdit,
    int? idClass
  }) async{
    try {
      createAndUpdateState = CreateAndUpdateDataClassStateType(state: CreateAndUpdateDataClassLoadingState());

      final dataRequest = ClassModel(
        name: name,
        lecturerName: lecturerName,
        startHour: startHour,
        endHour: endHour,
        day: dayofweek,
      );

      late ResponseGeneral<int> result;

      if ((isEdit ?? false) && idClass != null){
        dataRequest.id = idClass;

        result = await _classLocalData.createAndUpdateClass(data: dataRequest);
      } else {
        result = await _classLocalData.createAndUpdateClass(data: dataRequest);
      }

      if (result.code == "00"){
        createAndUpdateState = CreateAndUpdateDataClassStateType(
          state: CreateAndUpdateDataClassSuccessState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      } else {
        createAndUpdateState = CreateAndUpdateDataClassStateType(
          state: CreateAndUpdateDataClassFailedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      }

      emit(createAndUpdateState);
    } catch (e){
      createAndUpdateState = CreateAndUpdateDataClassStateType(
        state: CreateAndUpdateDataClassFailedState(),
        code: "01",
        message: "There's something wrong when creating data class",
        data: -1
      );
      emit(createAndUpdateState);
    }   
  }
}