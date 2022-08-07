

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/auth_pref.dart';
import 'package:to_do_list/model/user_model.dart';
import 'package:to_do_list/pages/home_page.dart';
import 'package:to_do_list/provider/user_provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscure = true;
  bool isNewUser = false;

  final form_key = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/background.png',
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ),
                Form(
                  key: form_key,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/app_image.png',
                            height: 150,
                            width: 90,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return null;
                            },
                            controller: userNameController,
                            decoration: InputDecoration(
                              labelText: 'User Name',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Theme.of(context).primaryColor),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'This field cannot be empty';
                              } else if (val.length < 6) {
                                return 'Password is too short';
                              }
                              return null;
                            },
                            controller: passwordController,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: (isObscure
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)),
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Theme.of(context).primaryColor),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: isNewUser ? _regUser : _loginUser,
                            child: isNewUser ? Text('Register') : Text('Login'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('New user?'),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isNewUser = !isNewUser;
                                    });
                                  },
                                  child: Text('Click here!'))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _regUser() async {
    if (form_key.currentState!.validate()) {
      final user = UserModel(
          userName: userNameController.text,
          userPassword: passwordController.text);

      final status = await Provider.of<UserProvider>(context, listen: false)
          .addNewUser(user);

      if (status) {
        setUser(userNameController.text);
        setLoginStat(true).then((value) =>
            Navigator.pushReplacementNamed(context, HomePage.routeName));
      } else {
        // throw 'User doesn\'t exist';
        SnackBar snackBar = SnackBar(content: Text('User not found'), );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void _loginUser() async {
    if (form_key.currentState!.validate()) {
      final user = UserModel(
          userName: userNameController.text,
          userPassword: passwordController.text);

      final status =
      Provider.of<UserProvider>(context, listen: false).loginUser(user);

      if (status) {
        setUser(userNameController.text);
        setLoginStat(true).then((value) =>
            Navigator.pushReplacementNamed(context, HomePage.routeName));
      } else {
        // throw 'User doesn\'t exist';
        SnackBar snackBar = SnackBar(content: Text('User not found'), );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
