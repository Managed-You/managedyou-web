// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:managed_web/features/authentication/auth_providers.dart';
import 'package:managed_web/features/users/user_database_provider.dart';
import 'package:managed_web/pages/home_page.dart';

import '../features/users/user_model.dart';
import '../pages/loading_page.dart';

class SocialButtons extends ConsumerWidget {
  const SocialButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: 10,
      child: Row(
        children: [
          IconButton(
            tooltip: "Sign in with Google",
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoadingPage(),
                ),
              );
              await ref
                  .watch(fireAuthProvider.notifier)
                  .signInWithGoogle(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false,
              );
            },
            icon: const FaIcon(FontAwesomeIcons.google),
          ),
          IconButton(
            tooltip: "Sign in with Facebook",
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoadingPage()),
              );
              await ref
                  .watch(fireAuthProvider.notifier)
                  .signInWithFacebook(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false,
              );
            },
            icon: const FaIcon(FontAwesomeIcons.facebook),
          ),
          IconButton(
            tooltip: "Sign in with Apple",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Apple sign in is not supported yet.'),
              ));
            },
            icon: const FaIcon(FontAwesomeIcons.apple),
          ),
          IconButton(
            tooltip: "Sign in with GitHub",
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoadingPage()),
              );
              await ref
                  .watch(fireAuthProvider.notifier)
                  .signInWithGitHub(context);
              //delay 5 seconds
              await Future.delayed(const Duration(seconds: 2));
              if (!await ref.watch(userDatabaseProvider.notifier).checkEmail(
                  "${ref.watch(fireAuthProvider.notifier).user?.email}")) {
                await ref.watch(userDatabaseProvider.notifier).addNewUser(Users(
                      email:
                          "${ref.watch(fireAuthProvider.notifier).user?.email}",
                    ));
              }
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false,
              );
            },
            icon: const FaIcon(FontAwesomeIcons.github),
          ),
        ],
      ),
    );
  }
}
