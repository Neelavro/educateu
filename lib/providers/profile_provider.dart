import 'package:educateu/domain/entities/profile_entity.dart';
import 'package:educateu/domain/usecases/profile_usecase.dart';
import 'package:flutter/material.dart';

import '../presentation/authentication/widget/toast_widget.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileUseCase profileUseCase;

  ProfileProvider({required this.profileUseCase});

  ProfileEntity? profile;
  String? errorMessage;
  bool isLoading = false;

  Future<void> getProfile() async {
    if (isLoading) return;  // ← add this
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await profileUseCase.getProfile();

    result.fold(
          (failure) => errorMessage = failure,
          (data) {
            profile = data;
          },
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile(BuildContext context, Map<String, dynamic> payload) async {
    if (isLoading) return;  // ← add this
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await profileUseCase.updateProfile(payload);

    result.fold(
          (failure) => errorMessage = failure,
          (data) {
        showToast(context, data, isSuccess: true);
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void showToast(BuildContext context, String message, {required bool isSuccess}) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 110,
        left: 24,
        right: 24,
        child: ToastWidget(message: message, isSuccess: isSuccess),
      ),
    );

    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 3), () => entry.remove());
  }
}