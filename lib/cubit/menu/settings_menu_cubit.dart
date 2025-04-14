
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/data/local_data/menu_local_data.dart';
import 'package:college_scheduler/data/models/menu_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef SettingsMenuStateType = StateGeneral<SettingsMenuState, List<MenuModel?>?>;

class SettingsMenuState {}
class SettingsMenuInitialState extends SettingsMenuState{}
class SettingsMenuLoadedState extends SettingsMenuState{}
class SettingsMenuFailedState extends SettingsMenuState{}
class SettingsMenuLoadingState extends SettingsMenuState{}

class SettingsMenuCubit extends Cubit<SettingsMenuStateType>{
  final MenuLocalData _menuLocalData;

  SettingsMenuCubit({
    required MenuLocalData menuLocalData
  }) : _menuLocalData = menuLocalData,
       super(SettingsMenuStateType(state: SettingsMenuInitialState()));

  SettingsMenuStateType _menuState = SettingsMenuStateType(state: SettingsMenuInitialState());  
  Future<void> getAllMenu() async{
    try {
      _menuState = SettingsMenuStateType(state: SettingsMenuLoadingState());
      emit(_menuState);

      final result = await _menuLocalData.getAllSettingsMenu();

      if (result.code == "00"){
        _menuState = SettingsMenuStateType(
          state: SettingsMenuLoadedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      } else {
        _menuState = SettingsMenuStateType(
          state: SettingsMenuFailedState(),
          code: result.code,
          message: result.message,
          data: result.data
        );
      }

      emit(_menuState);

    } catch (e){
      _menuState = SettingsMenuStateType(
        state: SettingsMenuFailedState(),
        code: "01",
        message: "There's a problem when getting all menu",
        data: []
      );

      emit(_menuState);
    }
  }
}