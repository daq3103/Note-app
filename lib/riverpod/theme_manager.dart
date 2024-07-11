import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_application_1/theme/theme_constants.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  String _currentFontFamily = 'Roboto'; // Lưu trữ font hiện tại

  ThemeNotifier() : super(lightTheme);
// .apply: áp dụng style cho tất cả các text trong theme
// .copyWith: áp dụng style cho theme
  void toggleTheme(bool isDarkMode) {
    state = (isDarkMode ? darkTheme : lightTheme).copyWith(
      textTheme: state.textTheme.apply(
          fontFamily: _currentFontFamily,
          bodyColor: isDarkMode ? Colors.white : Colors.black),
          // màu nền icon
          // tại sao khi lightMode thì màu icon lại màu xanh 
          // còn darkMode thì màu icon lại màu trắng
      iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
    );
  }

  void toggleFont(bool useRoboto) {
    // Cập nhật font và giữ nguyên cài đặt theme
    _currentFontFamily = useRoboto ? 'Roboto' : 'BaskervvilleSC-Regular';
    state = state.copyWith(
        textTheme: state.textTheme.apply(
            fontFamily: useRoboto ? 'Roboto' : 'BaskervvilleSC-Regular'));
  }
}
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) => ThemeNotifier());
