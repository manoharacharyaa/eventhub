import 'package:eventhub/colors/colors.dart';
import 'package:eventhub/containers/custom_input_form.dart';
import 'package:eventhub/views/login.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              const CustomInputForm(
                icon: Icons.person,
                label: 'Name',
                hint: 'Enter your name',
              ),
              const SizedBox(height: 20),
              const CustomInputForm(
                icon: Icons.email,
                label: 'Email',
                hint: 'Enter your email',
              ),
              const SizedBox(height: 20),
              const CustomInputForm(
                icon: Icons.lock,
                obscureText: true,
                label: 'Password',
                hint: 'Enter your password',
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(kPrimary),
                  minimumSize: MaterialStatePropertyAll(
                    Size(double.infinity, height * 0.065),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already A User? ',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
