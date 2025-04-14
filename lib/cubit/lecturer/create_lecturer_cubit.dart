import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/lecturer_local_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef CreateLecturerStateType = StateGeneral<CreateLecturerState, int>;

class CreateLecturerState{}
class CreateLecturerInitialState extends CreateLecturerState{}
class CreateLecturerLoadingState extends CreateLecturerState{}
class CreateLecturerSuccessState extends CreateLecturerState{}
class CreateLecturerFailedState extends CreateLecturerState{}

class CreateLecturerCubit extends Cubit<CreateLecturerStateType>{
  final LecturerLocalData _lecturerLocalData;

  CreateLecturerCubit({
    required LecturerLocalData lecturerLocalData
  }) : _lecturerLocalData = lecturerLocalData,
       super(CreateLecturerStateType(state: CreateLecturerInitialState()));


  CreateLecturerStateType _createState = CreateLecturerStateType(state: CreateLecturerInitialState());
  Future<void> createLecturer({
    required String lecturerName,
    bool? isEditData = false,
    int? idLecturer
  }) async{
    try {
      _createState = CreateLecturerStateType(state: CreateLecturerLoadingState());
      emit(_createState);

      final result = await _lecturerLocalData.createLecturer(
        name: lecturerName, 
        idLecturer: idLecturer, 
        isEditData: isEditData
      );

      if (result.code == "00"){
        _createState = CreateLecturerStateType(
          state: CreateLecturerSuccessState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      } else {
        _createState = CreateLecturerStateType(
          state: CreateLecturerFailedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      }

      emit(_createState);

    } catch (e){
      _createState = CreateLecturerStateType(
        state: CreateLecturerFailedState(),
        code: "01",
        message: "There's a problem when creating lecturer data",
        data: -1
      );

      emit(_createState);
    }
  }

}