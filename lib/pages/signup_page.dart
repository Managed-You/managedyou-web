import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:managed_web/features/authentication/auth_providers.dart';
import 'package:validators/validators.dart';

import '../responsive/responsive.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Managed You"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SignUpFields(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpFields extends StatefulWidget {
  const SignUpFields({Key? key}) : super(key: key);

  @override
  State<SignUpFields> createState() => _SignUpFieldsState();
}

class _SignUpFieldsState extends State<SignUpFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
                labelText: 'Create Password',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 5) {
                  return 'Must be more than 5 charater';
                }
                if (value != _passwordController.text) {
                  return 'Password does not match';
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
                labelText: 'Confirm Password',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: isDesktop(context, 800) ? 500 : 300,
              child: SignUpButton(
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
                  Navigator.popAndPushNamed(context, '/login');
                },
                child: Text(
                  'Login Here',
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

class SignUpButton extends ConsumerWidget {
  const SignUpButton({
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
          ref.watch(fireAuthProvider.notifier).signUpWithEmailAndPassword(
              _emailController.text, _passwordController.text, context);
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      child: const Text('Sign Up'),
    );
  }
}
