import 'package:get_it/get_it.dart';
import 'package:iverson/application/bloc.dart';
import 'domain/services/services.dart';
import 'infrastructure/infrastructure.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static ProductBloc get productBloc {
    final iversonService = getIt<IversonService>();
    final dataService = getIt<DataService>();
    return ProductBloc(iversonService, dataService);
  }

  static Future<void> init() async {
    final deviceInfoService = DeviceInfoServiceImpl();
    getIt.registerSingleton<DeviceInfoService>(deviceInfoService);
    await deviceInfoService.init();

    final loggingService = LoggingServiceImpl();
    getIt.registerSingleton<LoggingService>(loggingService);

    final authService = AuthServiceImpl();
    getIt.registerSingleton<AuthService>(authService);

    final settingsService = SettingsServiceImpl(loggingService);
    await settingsService.init();
    getIt.registerSingleton<SettingsService>(settingsService);
    
    getIt.registerSingleton<IversonService>(IverServiceImpl());

    final dataService = DataServiceImpl(getIt<IversonService>());
    await dataService.init();
    getIt.registerSingleton<DataService>(dataService);
  }
}