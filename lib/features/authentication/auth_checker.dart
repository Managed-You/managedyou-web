import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:managed_web/features/authentication/auth_providers.dart';
import 'package:managed_web/pages/home_page.dart';
import 'package:managed_web/pages/loading_page.dart';
import 'package:managed_web/pages/login_page.dart';

import '../../pages/error_screen.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);
  //  So if any data changes in the state, the widget will be updated.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (data) {
        if (data != null) return const HomePage();
        return const LoginPage();
      },
      loading: () => const LoadingPage(),
      error: (e, trace) => ErrorScreen(e, trace),
    );
  }
}
