import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt locator = GetIt.instance;

@InjectableInit()
Future<void> setupLocator() async {
  // locator.init();
}