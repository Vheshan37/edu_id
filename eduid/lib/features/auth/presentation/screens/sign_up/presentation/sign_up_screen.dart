import 'package:eduid/features/auth/presentation/screens/login/presentation/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              Text('Create account'),

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
                      label: Text('Name'),
                      border: OutlineInputBorder(),
                    ),
                  ),
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
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    debugPrint('Sign in button pressed');
                  },
                  child: Text('Sign Up'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    Text(
                      'login',
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
