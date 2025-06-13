
import 'package:do_it_fixed_fixed/main/bloc/auth/auth_bloc.dart';
import 'package:do_it_fixed_fixed/main/pages/private_pages/create_project.dart';
import 'package:do_it_fixed_fixed/main/pages/private_pages/dashboard_page.dart';
import 'package:do_it_fixed_fixed/main/pages/private_pages/project_page.dart';
import 'package:do_it_fixed_fixed/main/pages/public_pages/explore_page.dart';
import 'package:do_it_fixed_fixed/main/pages/public_pages/login_page.dart';
import 'package:do_it_fixed_fixed/main/pages/public_pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final prefs = await SharedPreferences.getInstance();
  // await prefs.remove('users');
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Do It',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue
        ),
        initialRoute: '/explore',
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/dashboard': (context) => const DashboardPage(),
          '/projects': (context) => const ProjectsPage(),
          '/explore': (context) => const ExplorePage(),
          '/create-project': (context) => const ProjectCreationPage(),
        },
      ),
    );
  }
}
