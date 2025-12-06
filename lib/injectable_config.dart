import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';

import 'injectable_config.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
