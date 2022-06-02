// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:managed_web/pages/loading_page.dart';
import 'package:managed_web/pages/login_page.dart';
import 'package:managed_web/pages/settings_page.dart';

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          IconButton(
            tooltip: "Logout",
            icon: const Icon(Icons.logout),
            onPressed: () async {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoadingPage(),
                ),
              );
              await ref.read(fireAuthProvider.notifier).signOut(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
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
            (ref.read(fireAuthProvider.notifier).user?.photoURL == null)
                ? IconButton(
                    iconSize: 40,
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.person_alt_circle),
                  )
                : CircleAvatar(
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
              subtitle: Text(ref.watch(fireAuthProvider).user?.displayName ??
                  "No Username"),
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
