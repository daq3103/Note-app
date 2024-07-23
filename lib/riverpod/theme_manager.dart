import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  String _currentFontFamily = 'Roboto'; // Lưu trữ font hiện tại

  ThemeNotifier() : super(lightTheme) {
    _loadThemePreference();
  }
  void toggleTheme(bool isDarkMode) async {
    state = (isDarkMode ? darkTheme : lightTheme).copyWith(
      textTheme: state.textTheme.apply(
          fontFamily: _currentFontFamily,
          bodyColor: isDarkMode ? Colors.white : Colors.black),
      iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  void toggleFont(bool useRoboto) async {
    // Cập nhật font và giữ nguyên cài đặt theme
    _currentFontFamily = useRoboto ? 'Roboto' : 'BaskervvilleSC-Regular';
    state = state.copyWith(
        textTheme: state.textTheme.apply(
            fontFamily: useRoboto ? 'Roboto' : 'BaskervvilleSC-Regular'));
    final preft = await SharedPreferences.getInstance();
      //  lưu trữ giá trị boolean Font-Family vào SharedPreferences
    await preft.setBool('isRegular', useRoboto);
  }

   Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false; 
    final fontFamily = prefs.getBool('isRegular') ?? false;
    toggleTheme(isDarkMode);
    toggleFont(fontFamily);
  }
}

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) => ThemeNotifier());
