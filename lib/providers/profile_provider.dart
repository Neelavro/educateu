import 'package:educateu/domain/entities/profile_entity.dart';
import 'package:educateu/domain/usecases/profile_usecase.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileUseCase profileUseCase;

  ProfileProvider({required this.profileUseCase});

  ProfileEntity? profile;
  String? errorMessage;
  bool isLoading = false;

  Future<void> getProfile() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final result = await profileUseCase.getProfile();

    result.fold(
          (failure) => errorMessage = failure,
          (data) => profile = data,
    );

    isLoading = false;
    notifyListeners();
  }
}