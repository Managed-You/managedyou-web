import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:managed_web/features/authentication/auth_providers.dart';
import 'package:managed_web/pages/home_page.dart';
import 'package:managed_web/pages/loading_page.dart';
import 'package:managed_web/pages/login_page.dart';
import 'package:managed_web/pages/signup_page.dart';
import 'package:managed_web/theme/theme.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Managed',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/loading': (context) => const LoadingPage(),
      },
      theme: ThemeData(colorScheme: lightColorScheme),
      darkTheme: ThemeData(colorScheme: darkColorScheme),
      initialRoute: ref.watch(fireAuthProvider).isLoggedIn ? '/login' : '/home',
    );
  }
}
