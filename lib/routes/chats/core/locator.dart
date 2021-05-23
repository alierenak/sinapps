import 'package:get_it/get_it.dart';
import 'package:sinapps/routes/chats/core/services/firestoreDb.dart';
import 'package:sinapps/routes/chats/models/chatsmodel.dart';

GetIt getIt = GetIt.instance;

setupLocators() {
  getIt.registerLazySingleton(() => FirestoreDb());

  getIt.registerFactory(() => ChatsModel());
}
