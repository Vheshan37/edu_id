import 'package:eduid/features/splash/presentation/bloc/authorization_bloc.dart';
import 'package:eduid/features/auth/presentation/screens/login/login_screen.dart';
import 'package:eduid/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool _hasNavigate = false;

  void _navigateTo(Widget screen) {
    if (!_hasNavigate && mounted) {
      _hasNavigate = true;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => screen));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthorizationBloc, AuthorizationState>(
      listener: (context, state) {
        if (_hasNavigate) return;
        if (state is Authorized) {
          debugPrint('User Authorized');
          Future.delayed(const Duration(seconds: 2), () {
            _navigateTo(HomeScreen());
          });
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomeScreen()),
          // );
        } else if (state is UnAuthorized) {
          Future.delayed(const Duration(seconds: 2), () {
            _navigateTo(LoginScreen());
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                Text('Edu ID'),
                Text('Your Education, Your Future.'),
                Text('Every Step Counts'),
              ],
            ),
          ),
        );
      },
    );
  }
}
