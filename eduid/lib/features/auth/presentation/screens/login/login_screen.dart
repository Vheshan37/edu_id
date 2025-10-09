import 'package:eduid/features/auth/presentation/bloc/login/auth_bloc.dart';
import 'package:eduid/features/auth/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:eduid/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    context.read<AuthBloc>().add(
                      RequestLogin(
                        email: emailController.text,
                        password: passwordController.text,
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
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
