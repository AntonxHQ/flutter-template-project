
import 'package:antonx/core/services/auth_services.dart';
import 'package:antonx/core/services/database_services.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerSingleton(AuthService());
  locator.registerSingleton(DatabaseService());
//  locator.registerSingleton(NotificationsStatusProvider());
}
