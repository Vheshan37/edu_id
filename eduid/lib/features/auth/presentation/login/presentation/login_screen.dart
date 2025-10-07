import 'package:eduid/features/auth/presentation/sign_up/presentation/sign_up_screen.dart';
import 'package:eduid/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // header section
              Image.asset('assets/images/logo.png'),
              Text('Edu ID'),
              Text('Welcome Back'),

              // form section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1),
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        Image.asset('assets/images/teacher.png'),
                        Text('Teacher'),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1),
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        Image.asset('assets/images/student.png'),
                        Text('Teacher'),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 10,
                children: [
                  // inputs
                  // email
                  TextField(
                    decoration: InputDecoration(
                      label: Text('Email'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Checkbox(
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: false,
                            onChanged: (value) => () {
                              debugPrint(
                                'check box onchange method not implemented',
                              );
                            },
                          ),
                          Text('Remember Me'),
                        ],
                      ),
                      Text('Forgot password?'),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    debugPrint('Sign in button pressed');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Text('Sign In'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    Text(
                      'Register',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
