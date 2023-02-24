import 'package:ebook/Pages/notes_page.dart';
import 'package:ebook/Services/auth_services.dart';
import 'package:ebook/Widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
  static String routeName = '/sign-up';
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _isLogin = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  bool isLoading = false;
  _submit() async {
    dynamic authSucces;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      loadingState(true);

      if (_isLogin) {
        authSucces =
            await _authService.logIn(_email.text, _password.text, context);
      } else {
        authSucces = await _authService.signUp(
            _userName.text, _email.text, _password.text, context);
      }
      loadingState(false);
      if (authSucces == true) {
        _navigate();
      }
    }
  }

  _navigate() {
    Navigator.of(context).pushReplacementNamed(NotesPage.routeName);
  }

  loadingState(bool load) {
    setState(() {
      isLoading = load;
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _userName.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 14, 18, 26),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        _isLogin ? 'Log In' : 'Sign Up',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 50, 104, 254),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ],
                  ),
                  if (!_isLogin)
                    CustomTextField(
                      textEditingController: _userName,
                      hintText: 'User Name',
                      iconData: Icons.account_circle,
                    ),
                  CustomTextField(
                      textEditingController: _email,
                      hintText: 'Email',
                      iconData: Icons.email),
                  CustomTextField(
                      textEditingController: _password,
                      hintText: 'Password',
                      iconData: Icons.password),
                  if (_isLogin)
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 50, 104, 254)),
                            ))
                      ],
                    ),
                  SizedBox(
                    width: 135,
                    height: 40,
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 50, 104, 254),
                            ),
                          )
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 50, 104, 254)),
                            ),
                            onPressed: () {
                              _submit();
                            },
                            child: Text(
                              _isLogin ? 'Log In' : 'Sign Up',
                              style: const TextStyle(fontSize: 15),
                            )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLogin
                            ? "Don't have accout?"
                            : "Already have an account?",
                        style: const TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(
                            _isLogin ? "Sign Up" : 'Log In',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 50, 104, 254),
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
