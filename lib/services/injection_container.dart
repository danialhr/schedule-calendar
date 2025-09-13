import 'package:get_it/get_it.dart';
import 'package:schedule_calendar/services/airtable_service.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(() => AirtableService());
}
