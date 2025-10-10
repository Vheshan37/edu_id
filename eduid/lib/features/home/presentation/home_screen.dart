import 'package:eduid/app/flutter_secure_storage.dart';
import 'package:eduid/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:eduid/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:eduid/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  get storage => SecureStorage.instance.storage;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          _showAlert(
            context,
            'Logout Success',
            'We hope you come back soon',
            screen: SplashScreen(),
          );
        } else if (state is LogoutFailed) {
          _showAlert(context, 'Logout Failed', state.messsage);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Home Page'),
              TextButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(Logout());
                },
                child: BlocBuilder<LogoutBloc, LogoutState>(
                  builder: (context, state) {
                    if (state is LogoutLoading) {
                      return CircularProgressIndicator();
                    }
                    return Text('Logout');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlert(
    BuildContext context,
    String title,
    String message, {
    Widget? screen,
  }) {
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

                if (screen != null) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => screen),
                    (route) => false, // this removes all previous routes
                  );
                }
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
