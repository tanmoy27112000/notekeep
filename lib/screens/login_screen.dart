import 'package:flutter/material.dart';
import 'package:notekeep/helpers/auth_helper.dart';
import 'package:notekeep/models/login_cred_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  final LoginCredModel _loginCredModel = LoginCredModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                //email textfield
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _loginCredModel.email = newValue,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  onSaved: (newValue) => _loginCredModel.password = newValue,
                  validator: (value) => value!.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('logging in...')));
                      try {
                        AuthHelper.instance.loginEmailPassword(
                            _loginCredModel.email!, _loginCredModel.password!);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('logging successful...')));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('logging failed...')));
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ));
  }
}
