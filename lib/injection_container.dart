
import 'package:educateu/data/repositories/authentication_repository_impl.dart';
import 'package:educateu/data/repositories/profile_repository_impl.dart';
import 'package:educateu/domain/repositories/authentication_repository.dart';
import 'package:educateu/domain/repositories/profile_repository.dart';
import 'package:educateu/domain/usecases/authentication_usecase.dart';
import 'package:educateu/domain/usecases/profile_usecase.dart';
import 'package:educateu/providers/authentication_provider.dart';
import 'package:educateu/providers/profile_provider.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

init() async {
  // Providers
  getIt.registerFactory(() => AuthenticationProvider(authenticationUseCase: getIt()));
  getIt.registerFactory(() => ProfileProvider(profileUseCase: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => AuthenticationUseCase(repository: getIt()));
  getIt.registerLazySingleton(() => ProfileUseCase(profileRepository: getIt()));

  // Repositories
  getIt.registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(),
  );
  getIt.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(),
  );
}