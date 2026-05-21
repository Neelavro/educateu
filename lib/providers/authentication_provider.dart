import 'dart:convert';
import 'package:educateu/domain/entities/security_question_entity.dart';
import 'package:educateu/domain/entities/student_entity.dart';
import 'package:educateu/domain/usecases/authentication_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/helper.dart';
import '../presentation/authentication/widget/toast_widget.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationUseCase authenticationUseCase;

  AuthenticationProvider({required this.authenticationUseCase});

  StudentEntity? student;
  String? errorMessage;
  bool isLoading = false;
  String? tempPassword;

  List<SecurityQuestionEntity> securityQuestions = [];

  static const String _studentKey = 'saved_student';

  Future<void> loadSavedStudent() async {
    final prefs = await SharedPreferences.getInstance();
    final studentJson = prefs.getString(_studentKey);
    if (studentJson != null) {
      final map = jsonDecode(studentJson) as Map<String, dynamic>;
      student = StudentEntity.fromJson(map);
      currentStudent.value = student!;
      notifyListeners();
    }
  }

  Future<void> _saveStudent(StudentEntity s) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_studentKey, jsonEncode(s.toJson()));
  }

  Future<void> _clearStudent() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_studentKey);
  }

  Future<void> logout() async {
    await _clearStudent();
    student = null;
    tempPassword = null;
    notifyListeners();
  }

  Future<void> login(BuildContext context, Map<String, dynamic> payload) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    tempPassword = payload['password'];

    final result = await authenticationUseCase.login(payload);

    result.fold(
          (failure) {
        errorMessage = failure;
        showToast(context, errorMessage!, isSuccess: false);
      },
          (data) async {
        student = data;
        if (data.mfaEnabled == false) {
          currentStudent.value = data;
          await _saveStudent(data);
        }
        showToast(context, 'Login Successful', isSuccess: true);
      },
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> getSecurityQuestions() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await authenticationUseCase.getSecurityQuestions();

    result.fold(
          (failure) => errorMessage = failure,
          (data) => securityQuestions = data,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> changePassword(BuildContext context, Map<String, dynamic> payload) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await authenticationUseCase.changePassword(payload);

    result.fold(
          (failure) {
        errorMessage = failure;
        showToast(context, failure, isSuccess: false);
      },
          (message) {
        tempPassword = null;
        showToast(context, message, isSuccess: true);
      },
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> loginOtp(BuildContext context, Map<String, dynamic> payload) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await authenticationUseCase.loginOtp(payload);

    result.fold(
          (failure) {
        errorMessage = failure;
        showToast(context, failure, isSuccess: false);
      },
          (data) async {
        tempPassword = null;
        currentStudent.value = data;
        await _saveStudent(data);
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void showToast(BuildContext context, String message, {required bool isSuccess}) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100,
        left: 24,
        right: 24,
        child: ToastWidget(message: message, isSuccess: isSuccess),
      ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 3), () => entry.remove());
  }
}