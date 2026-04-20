import 'package:educateu/domain/entities/security_question_entity.dart';
import 'package:educateu/domain/entities/student_entity.dart';
import 'package:educateu/domain/usecases/authentication_usecase.dart';
import 'package:flutter/material.dart';

import '../presentation/onboarding/widget/toast_widget.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationUseCase authenticationUseCase;

  AuthenticationProvider({required this.authenticationUseCase});

  StudentEntity? student;
  String? errorMessage;
  bool isLoading = false;
  String? tempPassword; // store it here


  List<SecurityQuestionEntity> securityQuestions = [];

  Future<void> login(BuildContext context,Map<String, dynamic> payload) async {
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
          (data) => student = data,
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
          (failure) {
            errorMessage = failure;

          },
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
        tempPassword = null; // clear stored password
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
          (message) {
        tempPassword = null; // clear stored password
        showToast(context, message, isSuccess: true);
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void showToast(BuildContext context, String message, {required bool isSuccess}) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) =>
          Positioned(
            bottom: 60,
            left: 24,
            right: 24,
            child: ToastWidget(message: message, isSuccess: isSuccess),
          ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 3), () => entry.remove());
  }

}