import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_management_app/backend_integration/services/api_service.dart';
import 'package:school_management_app/components/custom_button.dart';
import 'package:school_management_app/constants/constants.dart';
import 'package:school_management_app/screens/admin/Home_Screen/admin_home_screen.dart';
import 'package:school_management_app/screens/signup_screen/SignUp_Screen.dart';
import 'package:school_management_app/screens/students/home_screen/home_screen.dart';
import 'package:school_management_app/screens/teachers/Home_Screen/home_screen.dart';

late bool _passwordVisible;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final APIService _apiService = APIService();

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          children: [
            // dividing the screen into two half
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
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("User", style: Theme.of(context).textTheme.bodyLarge)
                    ],
                  ),
                  const SizedBox(
                    height: kDefaultPadding / 6,
                  ),
                  Text("Sign In To Continue",
                      style: Theme.of(context).textTheme.titleSmall),
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
                          sizedBox,
                          buildEmailField(),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          buildPasswordField(),
                          sizedBox,
                          CustomButton(
                            onPress: _signIn,
                            title: "Sign In",
                            iconData: Icons.arrow_forward_outlined,
                          ),
                          sizedBox,
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
        print("userType: $userType");
        print("Email: $email");
        print("Password: $password");
        final response = await _apiService.login(userType, email, password);
        final jsonResponse = jsonDecode(response);
        print("Response: ${jsonResponse['status']}");

        if (jsonResponse['status'] == 'success') {
          _navigateToHomeScreen(userType);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid credentials. Please try again.'),
            ),
          );
        }
      } catch (e) {
        print('Error: $e');
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
  }
  else if (email == 'director@iiitkalyani.ac.in') {
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


  void _navigateToHomeScreen(String userType) {
    switch (userType) {
      case 'director':
        Navigator.pushNamedAndRemoveUntil(
          context,
          AdminHomeScreen.routeName,
          (route) => false,
        );
        break;
      case 'admin':
        Navigator.pushNamedAndRemoveUntil(
          context,
          AdminHomeScreen.routeName,
          (route) => false,
        );
        break;
      case 'student':
        Navigator.pushNamedAndRemoveUntil(
          context,
          StudentHomeScreen.routeName,
          (route) => false,
        );
        break;
      case 'teacher':
        Navigator.pushNamedAndRemoveUntil(
          context,
          TeacherHomeScreen.routeName,
          (route) => false,
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
        prefixIcon: Icon(Icons.email),
        labelText: "Enter Email",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isDense: true,
      ),
      controller: _emailController,
      validator: (value) {
        RegExp regExp = RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return "Email Field cannot be empty";
        } else if (!regExp.hasMatch(value)) {
          return "Please enter a valid email address";
        }
        return null;
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      obscureText: _passwordVisible,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(
        color: kTextBlackColor,
        fontSize: 18.0,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.password),
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
            _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          iconSize: kDefaultPadding,
        ),
      ),
      controller: _passwordController,
      validator: (value) {
        if (value!.length < 7) {
          return "Password must be more than 7 characters";
        }
        return null;
      },
    );
  }
}
