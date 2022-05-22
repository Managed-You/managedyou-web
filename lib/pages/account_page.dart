import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/authentication/auth_providers.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        actions: [
          IconButton(
            tooltip: "Settings",
            icon: const Icon(CupertinoIcons.settings),
            onPressed: () async {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          IconButton(
            tooltip: "Logout",
            icon: const Icon(Icons.logout),
            onPressed: () async {
              ref.read(fireAuthProvider.notifier).signOut(context);
            },
          )
        ],
      ),
    );
  }
}
