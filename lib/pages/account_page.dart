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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 40,
              foregroundImage: NetworkImage(
                '${ref.read(fireAuthProvider.notifier).user?.photoURL}',
                scale: 40,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: const Text("Email"),
              subtitle: Text(ref.watch(fireAuthProvider).user?.email ?? ""),
            ),
            ListTile(
              title: const Text("Username"),
              subtitle:
                  Text(ref.watch(fireAuthProvider).user?.displayName ?? ""),
            ),
            ListTile(
              title: const Text("Email Verified"),
              subtitle: Text(
                ref.watch(fireAuthProvider).user!.emailVerified ? "Yes" : "No",
              ),
              trailing: ref.watch(fireAuthProvider).user!.emailVerified
                  ? const SizedBox()
                  : IconButton(
                      tooltip: "Send Verification Email",
                      icon: const Icon(CupertinoIcons.mail),
                      onPressed: () {
                        ref.watch(fireAuthProvider).verifyUser();
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
