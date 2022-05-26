import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:managed_web/features/users/user_database.dart';

final userDatabaseProvider = ChangeNotifierProvider<UserDatabase>((ref) {
  return UserDatabase();
});
