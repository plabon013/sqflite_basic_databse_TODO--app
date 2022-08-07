import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/auth_pref.dart';
import 'package:to_do_list/pages/home_page.dart';
import 'package:to_do_list/pages/login_page.dart';

import '../provider/user_provider.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher_page';

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false)
        .getAllUsers()
        .then((value) {
      getLoginStat().then((value) {
        if (value) {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        } else {
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
