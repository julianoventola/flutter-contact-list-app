import 'package:get_it/get_it.dart';
import 'package:helioaula/app/database/sqlite/dao/contact_dao_impl.dart';
import 'package:helioaula/app/domain/interfaces/contact_dao.dart';
import 'package:helioaula/app/domain/services/contact_service.dart';

setupInjection() {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<ContactDAO>(ContactDAOImpl());
  getIt.registerSingleton<ContactService>(ContactService());
}
