
import 'package:educateu/domain/entities/student_entity.dart';
import 'package:educateu/domain/usecases/authentication_usecase.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationUseCase authenticationUseCase;

  AuthenticationProvider({required this.authenticationUseCase});

  StudentEntity? student;
  String? errorMessage;
  bool isLoading = false;

  Future<void> login(Map<String, dynamic> payload) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await authenticationUseCase.login(payload);

    result.fold(
          (failure) => errorMessage = failure,
          (data) => student = data,
    );

    isLoading = false;
    notifyListeners();
  }
}