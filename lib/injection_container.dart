
import 'package:educateu/data/repositories/authentication_repository_impl.dart';
import 'package:educateu/domain/repositories/authentication_repository.dart';
import 'package:educateu/domain/usecases/authentication_usecase.dart';
import 'package:educateu/providers/authentication_provider.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

init() async {
  // Providers
  getIt.registerFactory(() => AuthenticationProvider(authenticationUseCase: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => AuthenticationUseCase(repository: getIt()));

  // Repositories
  getIt.registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(),
  );
}