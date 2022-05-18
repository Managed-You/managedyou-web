import 'package:flutter/material.dart';
import 'package:managed_web/pages/login/widgets/fields.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Login'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [Fields()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
