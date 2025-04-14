
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageLocaleCubit extends Cubit<Locale>{
  Locale _languageCode = Locale("en");

  LanguageLocaleCubit(): _languageCode = Locale("en"), super(Locale("en"));

  Locale get languageCode => _languageCode;

  void changeLocale(Locale code){
    _languageCode = code;

    emit(_languageCode);
  }
}