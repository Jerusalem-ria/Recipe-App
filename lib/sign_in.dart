import 'package:flutter/material.dart';
import 'home.dart';
import 'sign_up.dart';
import 'animation.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  bool _isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? emailError;
  String? passwordError;
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool _validateEmail(String email) {
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= 8; // Password must be at least 8 characters
  }

  void _focusNextField(
      {required FocusNode currentFocus,
      required FocusNode nextFocus,
      required Function validator}) {
    if (validator()) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  void _handleSignIn() {
    setState(() {
      emailError =
          _validateEmail(emailController.text) ? null : 'Invalid email';
      passwordError = _validatePassword(passwordController.text)
          ? null
          : 'Password cannot be empty';
    });

    if (emailError == null && passwordError == null) {
      setState(() {
        _isLoading = true;
      });
      // Simulate a delay for loading
      Future.delayed(Duration(seconds: 2), () {
        if (!mounted) return; // Check if the widget is still mounted
        setState(() {
          _isLoading = false;
        });
        // Handle actual sign in logic here
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // Removes shadow
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Text(
                'Hello,',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 20, // Adjusted the font size
                  fontWeight: FontWeight.normal, // Adjusted the font weight
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 40),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Enter Email',
                    errorText: emailError,
                    labelStyle: TextStyle(
                        color: const Color.fromARGB(91, 0, 8, 7), fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      emailError =
                          _validateEmail(text) ? null : 'Invalid email';
                    });
                  },
                  onEditingComplete: () {
                    _focusNextField(
                      currentFocus: emailFocusNode,
                      nextFocus: passwordFocusNode,
                      validator: () {
                        bool isValid = emailController.text.isNotEmpty &&
                            emailError == null;
                        setState(() {
                          emailError = isValid ? null : 'Invalid email';
                        });
                        return isValid;
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                    labelStyle: TextStyle(
                        color: const Color.fromARGB(91, 0, 8, 7), fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    errorText: passwordError,
                  ),
                  textInputAction: TextInputAction.done,
                  onChanged: (text) {
                    setState(() {
                      passwordError = _validatePassword(text)
                          ? null
                          : 'Password must be at least 8 characters';
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
              ),
              SizedBox(height: 20),
              AnimatedButton(
                onPressed: _handleSignIn, // Handle sign in
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: const Color.fromARGB(255, 5, 38, 7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Sign In',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: const Color.fromARGB(255, 10, 159, 141),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Or Sign in With',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: const Color.fromARGB(255, 10, 159, 141),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle Google sign in
                    },
                    icon: Icon(Icons.login),
                    color: Colors.red,
                    iconSize: 40,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      // Handle Facebook sign in
                    },
                    icon: Icon(Icons.facebook),
                    color: Colors.blue,
                    iconSize: 40,
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Sign up',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
