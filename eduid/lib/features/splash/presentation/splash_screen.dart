import 'package:eduid/core/navigation/navigator.dart';
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
      AppNavigator.pushAndReplace(context, screen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
          backgroundColor: colorScheme.background,
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              if (Theme.of(context).brightness == Brightness.light)
                Image.asset(
                  'assets/images/background_2.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    SizedBox(height: 8),
                    Text(
                      'Your Education, Your Future.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    Text(
                      'Every Step Counts',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      '© 2025 Edu ID. Sri Lankan Learning Platform.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
