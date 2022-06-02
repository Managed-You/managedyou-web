import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:managed_web/pages/account_page.dart';
import 'package:managed_web/pages/create_event_page.dart';
import 'package:managed_web/responsive/responsive.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              actions: [
                isDesktop(context, 900)
                    ? const SizedBox()
                    : IconButton(
                        tooltip: "Account",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccountPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          CupertinoIcons.person_crop_circle,
                        ),
                      )
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: const Text("Create Event"),
              icon: const Icon(Icons.add),
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateEventPage(),
                  ),
                );
              },
            ),
          ),
        ),
        isDesktop(context, 900)
            ? Flexible(
                flex: 1,
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 26,
                      bottom: 26,
                      left: 20,
                      right: 20,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const AccountPage(),
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
