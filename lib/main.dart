import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:managed_web/features/authentication/auth_providers.dart';
import 'package:managed_web/pages/error_screen.dart';
import 'package:managed_web/pages/loading_page.dart';
import 'package:managed_web/theme/theme.dart';

import 'features/authentication/auth_checker.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseinitializerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Managed',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF774A9B),
          foregroundColor: Colors.white,
        ),
        colorScheme: lightColorScheme,
        fontFamily: "Coda",
      ),
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF774A9B),
          foregroundColor: Colors.black,
        ),
        colorScheme: darkColorScheme,
        fontFamily: "Coda",
      ),
      home: initialize.when(data: (data) {
        return const AuthChecker();
      }, error: (e, stackTrace) {
        ErrorScreen(e, stackTrace);
        return null;
      }, loading: () {
        return const LoadingPage();
      }),
    );
  }
}
