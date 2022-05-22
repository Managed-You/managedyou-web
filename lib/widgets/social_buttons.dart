import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:managed_web/features/authentication/auth_providers.dart';

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
            onPressed: () {
              ref.watch(fireAuthProvider.notifier).signInWithGoogle(context);
            },
            icon: const FaIcon(FontAwesomeIcons.google),
          ),
          IconButton(
            tooltip: "Sign in with Facebook",
            onPressed: () {
              ref.watch(fireAuthProvider.notifier).signInWithFacebook(context);
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
            onPressed: () {
              ref.watch(fireAuthProvider.notifier).signInWithGitHub(context);
            },
            icon: const FaIcon(FontAwesomeIcons.github),
          ),
        ],
      ),
    );
  }
}
