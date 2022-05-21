import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:managed_web/features/authentication/fire_auth.dart';

final fireAuthProvider = ChangeNotifierProvider<FireAuth>((ref) {
  return FireAuth();
});
