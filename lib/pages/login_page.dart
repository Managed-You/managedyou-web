import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:managed_web/features/authentication/auth_providers.dart';
import 'package:managed_web/pages/home_page.dart';
import 'package:managed_web/pages/loading_page.dart';
import 'package:managed_web/pages/signup_page.dart';
import 'package:managed_web/widgets/social_buttons.dart';
import 'package:validators/validators.dart';

import '../responsive/responsive.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Back to Managed You"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(alignment: Alignment.center, children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                LoginFields(),
              ],
            ),
          ),
          const SocialButtons(),
        ]),
      ),
    );
  }
}

class LoginFields extends StatefulWidget {
  const LoginFields({Key? key}) : super(key: key);

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: SizedBox(
        width: isDesktop(context, 800)
            ? MediaQuery.of(context).size.width * 0.50
            : MediaQuery.of(context).size.width * 0.70,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              validator: (val) => !isEmail(val!) ? "Invalid Email" : null,
              autocorrect: false,
              decoration: InputDecoration(
                focusColor: Colors.black,
                floatingLabelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Email ID',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 5) {
                  return 'Must be more than 5 charater';
                }
                return null;
              },
              obscureText: true,
              autocorrect: false,
              decoration: InputDecoration(
                focusColor: Colors.black,
                floatingLabelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Password',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: isDesktop(context, 800) ? 500 : 300,
              child: LoginButton(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: isDesktop(context, 800) ? 500 : 300,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        )),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: Text(
                  'Sign Up Here',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoadingPage()),
          );
          ref.read(fireAuthProvider.notifier).signInWithEmailAndPassword(
              _emailController.text, _passwordController.text, context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false,
          );
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      child: const Text('Login'),
    );
  }
}
