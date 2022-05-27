import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:managed_web/features/authentication/fire_auth.dart';

import '../../firebase_options.dart';

final fireAuthProvider = ChangeNotifierProvider<FireAuth>((ref) {
  return FireAuth();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(fireAuthProvider).authStateChange;
});

final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
});
