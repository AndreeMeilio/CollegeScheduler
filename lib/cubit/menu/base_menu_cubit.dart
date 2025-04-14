
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseMenuCubit extends Cubit<int>{
  BaseMenuCubit() : super(0);

  int indexActiveMenu = 0;

  changeIndexActiveMenu(int index){
    indexActiveMenu = index;

    emit(indexActiveMenu);
  }
}