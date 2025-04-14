
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceConfig {
  SharedPreferences? _pref;

  Future<SharedPreferences> get() async{
    if (_pref != null) return _pref!;

    _pref = await SharedPreferences.getInstance();

    return _pref!;
  }

  Future<void> setInt({
    required String key,
    required int value,
  }) async{
    final SharedPreferences pref = await get();

    await pref.setInt(key, value);
  }

  Future<void> setString({
    required String key,
    required String value,
  }) async{
    final SharedPreferences pref = await get();

    await pref.setString(key, value);
  }

  Future<int?> getInt({required String key}) async{
    final SharedPreferences pref = await get();

    return pref.getInt(key);
  }
  Future<String?> getString({required String key}) async{
    final SharedPreferences pref = await get();

    return pref.getString(key);
  }

  Future<void> clearShared() async{
    final SharedPreferences pref = await get();

    await pref.clear();
  }
}