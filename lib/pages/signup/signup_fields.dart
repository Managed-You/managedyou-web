import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../responsive/responsive.dart';
import '../login/widgets/login_button.dart';

class SignUpFields extends StatefulWidget {
  const SignUpFields({Key? key}) : super(key: key);

  @override
  State<SignUpFields> createState() => _SignUpFieldsState();
}

class _SignUpFieldsState extends State<SignUpFields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              validator: (val) => !isEmail(val!) ? "Invalid Email" : null,
              autocorrect: false,
              decoration: InputDecoration(
                focusColor: Theme.of(context).colorScheme.primary,
                floatingLabelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
                focusColor: Theme.of(context).colorScheme.primary,
                floatingLabelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
                  // Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   // MaterialPageRoute(builder: (context) => const SignUpPage()),
                  // );
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
