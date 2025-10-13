import 'package:eduid/core/storage/flutter_secure_storage.dart';
import 'package:eduid/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:eduid/features/auth/presentation/screens/login/login_screen.dart';
import 'package:eduid/features/student_dashaboard/presentation/student_dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
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
            screen: LoginScreen(),
          );
        } else if (state is LogoutFailed) {
          _showAlert(context, 'Logout Failed', state.messsage);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: 'Menu',
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Edu ID',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Container(
                width: 80,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade200,
                ),
              ),
            ],
          ),
          centerTitle: true, // left-aligned like standard apps
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  // Go to profile page
                  showDialog(
                    context: context,
                    builder: (context) =>
                        CupertinoAlertDialog(title: Text('Hello'), content: Text('lorem asdasd asd asd ad ad asd ada a a da dad a dasdasdasdas da'),),
                  );
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?img=3', // replace with user profile
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: StudentDashboardScreen(),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6.0)),
            child: Row(
              children: [
                Icon(Icons.home_outlined),
                Icon(Icons.groups),
                Icon(Icons.),
                Icon(Icons.home_outlined),
                Icon(Icons.home_outlined),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(items: [
        //   BottomNavigationBarItem(label: '', icon: Icon( Icons.home_outlined)),
        //   BottomNavigationBarItem(label: '',icon: Icon( Icons.home_outlined)),
        //   BottomNavigationBarItem(label: '',icon: Icon( Icons.home_outlined)),
        // ]),
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
