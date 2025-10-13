import 'package:eduid/core/storage/flutter_secure_storage.dart';
import 'package:eduid/features/auth/presentation/bloc/logout/logout_bloc.dart';
import 'package:eduid/features/auth/presentation/screens/login/login_screen.dart';
import 'package:eduid/features/home/presentation/provider/navigationProvider.dart';
import 'package:eduid/features/student_dashaboard/presentation/student_dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const List<Widget> homePageList = [
    StudentDashboardScreen(),
    Home2(),
    Home3(),
    Home4(),
    Home5(),
  ];

  get storage => SecureStorage.instance.storage;

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    int currentIndex = 0;

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
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
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
                    builder: (context) => CupertinoAlertDialog(
                      title: Text('Hello'),
                      content: Text(
                        'lorem asdasd asd asd ad ad asd ada a a da dad a dasdasdasdas da',
                      ),
                    ),
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
              SizedBox(height: double.infinity,),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Center(child: homePageList[navigationProvider.currentIndex]),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    navigationProvider.navigate(index: 0);
                  },
                  child: Image.asset(
                    'assets/icons/home.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigationProvider.navigate(index: 1);
                  },
                  child: Image.asset(
                    'assets/icons/classroom.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigationProvider.navigate(index: 2);
                  },
                  child: Image.asset(
                    'assets/icons/graduation.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigationProvider.navigate(index: 3);
                  },
                  child: Image.asset(
                    'assets/icons/notification.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    navigationProvider.navigate(index: 4);
                  },
                  child: Image.asset(
                    'assets/icons/posts.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _displayHome(int i) {}

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

class Home2 extends StatelessWidget {
  const Home2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page 2'));
  }
}

class Home3 extends StatelessWidget {
  const Home3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page 3'));
  }
}

class Home4 extends StatelessWidget {
  const Home4({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page 4'));
  }
}

class Home5 extends StatelessWidget {
  const Home5({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Page 5'));
  }
}
