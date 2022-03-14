import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/models/user.dart';
import 'package:flutter_2dv50e/routes/routes.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  final _submit = GlobalKey<FormState>();

  void submitLogin() {
    context.read<User>().username = usernameController.text;
    Navigator.of(context).pushNamed(RouteManager.dashboard);
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

/*   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sign up',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'username'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(hintText: 'password'),
              obscureText: true,
            )
          ],
        ),
      ),
    );
  }
} */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: usernameController,
                onSubmitted: (String ye) {
                  submitLogin();
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  child: const Text('LOGIN'),
                  onPressed: submitLogin,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
