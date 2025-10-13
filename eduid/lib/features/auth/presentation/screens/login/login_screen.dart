import 'dart:io';

import 'package:eduid/features/auth/presentation/bloc/login/auth_bloc.dart';
import 'package:eduid/features/auth/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:eduid/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isTeacher = true;
  bool _checkedRememberMe = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // access theme instance
    final colorScheme = theme.colorScheme; // access color palette

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        children: [
          // i want to show the background image to light theme users only
          if (Theme.of(context).brightness == Brightness.light)
            Image.asset(
              'assets/images/background_2.png',
              fit: BoxFit.cover,
              height: double.infinity,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // header section
                  Image.asset(
                    'assets/images/logo.png',
                    color: colorScheme.onPrimary,
                  ),
                  Text(
                    'Edu ID',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Welcome Back',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 20),
                  // form section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isTeacher = false;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                width: 1,
                                color: _isTeacher
                                    ? colorScheme.onPrimary
                                    : colorScheme.secondary,
                              ),
                              color: _isTeacher
                                  ? Colors.transparent
                                  : colorScheme.secondary.withOpacity(0.25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                Image.asset('assets/images/teacher.png'),
                                Text(
                                  'Student',
                                  style: TextStyle(
                                    color: _isTeacher
                                        ? colorScheme.onPrimary
                                        : colorScheme.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isTeacher = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                width: 1,
                                color: _isTeacher
                                    ? colorScheme.tertiary
                                    : colorScheme.onPrimary,
                              ),
                              color: _isTeacher
                                  ? colorScheme.tertiary.withOpacity(0.25)
                                  : Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                Image.asset('assets/images/student.png'),
                                Text(
                                  'Teacher',
                                  style: TextStyle(
                                    color: _isTeacher
                                        ? colorScheme.tertiary
                                        : colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    spacing: 10,
                    children: [
                      // inputs
                      // email
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          label: Text('Email'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text('Password'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _checkedRememberMe = !_checkedRememberMe;
                              });
                            },
                            child: Row(
                              spacing: 4,
                              children: [
                                Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: _checkedRememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkedRememberMe = !_checkedRememberMe;
                                    });
                                  },
                                ),
                                Text('Remember Me'),
                              ],
                            ),
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
                        debugPrint('is teacher: $_isTeacher');
                        context.read<AuthBloc>().add(
                          RequestLogin(
                            email: emailController.text,
                            password: passwordController.text,
                            isTeacher: _isTeacher,
                          ),
                        );
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => HomeScreen()),
                        // );
                      },
                      child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is UnAuthenticated) {
                            _showAlert(context, state.title, state.message);
                          } else if (state is AuthError) {
                            _showAlert(context, 'Login Failed', state.message);
                          } else if (state is AuthAuthenticated) {
                            Navigator.of(
                              context,
                            ).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => HomeScreen(),
                            //   ),
                            // );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return CircularProgressIndicator();
                          }
                          return Text('Sign In');
                        },
                      ),
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
        ],
      ),
    );
  }

  void _showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close popup
              },
              child: const Text("Ok"),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //     // Do your action here
            //   },
            //   child: const Text("OK"),
            // ),
          ],
          backgroundColor: Colors.orange,
        );
      },
    );
  }
}
