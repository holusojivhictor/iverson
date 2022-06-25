import 'package:get_it/get_it.dart';
import 'package:iverson/domain/services/auth_service.dart';
import 'package:iverson/infrastructure/auth_service.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static Future<void> init() async {
    final authService = AuthServiceImpl();
    getIt.registerSingleton<AuthService>(authService);
  }
}