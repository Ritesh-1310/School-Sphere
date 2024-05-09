import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:school_management_app/components/custom_button.dart';
import 'package:school_management_app/constants/constants.dart';
import 'package:school_management_app/screens/admin/Home_Screen/admin_home_screen.dart';
import 'package:school_management_app/screens/signup_screen/SignUp_Screen.dart';
import 'package:school_management_app/screens/students/home_screen/home_screen.dart';
import 'package:school_management_app/screens/teachers/Home_Screen/home_screen.dart';
import '../../backend_integration/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/splash.png',
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hi",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("User", style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                  const SizedBox(
                    height: kDefaultPadding / 6,
                  ),
                  Text("Sign In To Continue",
                      style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kDefaultPadding * 3),
                  topRight: Radius.circular(kDefaultPadding * 3),
                ),
                color: kOtherColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: kDefaultPadding),
                          buildEmailField(),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          buildPasswordField(),
                          SizedBox(height: kDefaultPadding),
                          CustomButton(
                            onPress: _signIn,
                            title: "Sign In",
                            iconData: Icons.arrow_forward_outlined,
                          ),
                          SizedBox(height: kDefaultPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, SignUpScreen.routeName);
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 18.0),
                                ),
                              ),
                              const SizedBox(width: kDefaultPadding / 2),
                              TextButton(
                                onPressed: () {
                                  // Navigate to forgot password screen
                                },
                                child: const Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                      color: kPrimaryColor, fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      String userType = _getUserType(email);

      try {
        final response = await _authService.login(userType, email, password);
        final jsonResponse = jsonDecode(response);

        if (jsonResponse['status'] == 'success') {
          _navigateToHomeScreen(userType, jsonResponse['data']);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid credentials. Please try again.'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again later.'),
          ),
        );
      }
    }
  }

  String _getUserType(String email) {
    if (email == 'admin@iiitkalyani.ac.in') {
      return 'admin';
    } else if (email == 'director@iiitkalyani.ac.in') {
      return 'director';
    } else if (email.contains('@iiitkalyani.ac.in')) {
      if (_isStudentEmail(email)) {
        return 'student';
      } else {
        return 'teacher';
      }
    } else {
      return 'student';
    }
  }

  bool _isStudentEmail(String email) {
    final parts = email.split('@');
    final emailPrefix = parts[0];

    // Check if the emailPrefix contains a digit
    if (RegExp(r'\d').hasMatch(emailPrefix)) {
      return true; // If it contains a digit, consider it as a student email
    } else {
      return false; // Otherwise, it's not a student email
    }
  }

  void _navigateToHomeScreen(String userType, Map<String, dynamic> userData) {
    switch (userType) {
      case 'director':
      case 'admin':
        Navigator.pushReplacementNamed(
          context,
          AdminHomeScreen.routeName,
          arguments: userData,
        );
        break;
      case 'student':
        Navigator.pushReplacementNamed(
          context,
          StudentHomeScreen.routeName,
          arguments: userData,
        );
        break;
      case 'teacher':
        Navigator.pushReplacementNamed(
          context,
          TeacherHomeScreen.routeName,
          arguments: userData,
        );
        break;
      default:
        break;
    }
  }

  TextFormField buildEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 18.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.email,
        ),
        labelText: "Enter Email",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isDense: true,
      ),
      controller: _emailController,
      validator: (value) {
        RegExp regExp = RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return "This field is required";
        } else if (!regExp.hasMatch(value)) {
          return "Enter a valid email address";
        }
        return null;
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      obscureText: !_passwordVisible,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 18.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        labelText: "Enter Password",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isDense: true,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          iconSize: kDefaultPadding,
        ),
      ),
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        return null;
      },
    );
  }
}
