import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_management_app/backend_integration/services/api_service.dart';
import 'package:school_management_app/components/custom_button.dart';
import 'package:school_management_app/constants/constants.dart';
import 'package:school_management_app/screens/login_screen/login_screen.dart';

class SignUpAsStudent extends StatefulWidget {
  static const routeName = 'signUpAsStudent';

  const SignUpAsStudent({super.key});

  @override
  _SignUpAsStudentState createState() => _SignUpAsStudentState();
}

class _SignUpAsStudentState extends State<SignUpAsStudent> {
  final _formKey = GlobalKey<FormState>();
  final APIService _apiService = APIService();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _stdController = TextEditingController();
  final TextEditingController _dateOfJoiningController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _fathersNameController = TextEditingController();
  final TextEditingController _mothersNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _regNoController.dispose();
    _rollNoController.dispose();
    _stdController.dispose();
    _dateOfJoiningController.dispose();
    _dateOfBirthController.dispose();
    _fathersNameController.dispose();
    _mothersNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOtherColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        title: const Text(
          'Sign Up as Student',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _firstNameController,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle:
                      const TextStyle(color: kPrimaryColor, fontSize: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: kDefaultPadding),
              TextFormField(
                controller: _lastNameController,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle:
                      const TextStyle(color: kPrimaryColor, fontSize: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              // const SizedBox(height: kDefaultPadding),
              // TextFormField(
              //   controller: _regNoController,
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 16.0,
              //   ),
              //   decoration: InputDecoration(
              //     labelText: 'Registration Number',
              //     labelStyle:
              //         const TextStyle(color: kPrimaryColor, fontSize: 16.0),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(color: kPrimaryColor),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your registration number';
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: kDefaultPadding),
              // TextFormField(
              //   controller: _rollNoController,
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 16.0,
              //   ),
              //   decoration: InputDecoration(
              //     labelText: 'Roll Number',
              //     labelStyle:
              //         const TextStyle(color: kPrimaryColor, fontSize: 16.0),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(color: kPrimaryColor),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your roll number';
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: kDefaultPadding),
              // TextFormField(
              //   controller: _stdController,
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 16.0,
              //   ),
              //   decoration: InputDecoration(
              //     labelText: 'Standard (e.g., 12th)',
              //     labelStyle:
              //         const TextStyle(color: kPrimaryColor, fontSize: 16.0),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(color: kPrimaryColor),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your standard';
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: kDefaultPadding),
              // TextFormField(
              //   controller: _dateOfJoiningController,
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 16.0,
              //   ),
              //   decoration: InputDecoration(
              //     labelText: 'Date of Joining (DD-MM-YYYY)',
              //     labelStyle:
              //         const TextStyle(color: kPrimaryColor, fontSize: 16.0),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(color: kPrimaryColor),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your date of joining';
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: kDefaultPadding),
              TextFormField(
                controller: _dateOfBirthController,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Date of Birth (DD-MM-YYYY)',
                  labelStyle:
                      const TextStyle(color: kPrimaryColor, fontSize: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your date of birth';
                  }
                  return null;
                },
              ),
              // const SizedBox(height: kDefaultPadding),
              // TextFormField(
              //   controller: _fathersNameController,
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 16.0,
              //   ),
              //   decoration: InputDecoration(
              //     labelText: "Father's Name",
              //     labelStyle:
              //         const TextStyle(color: kPrimaryColor, fontSize: 16.0),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(color: kPrimaryColor),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Please enter your father's name";
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: kDefaultPadding),
              // TextFormField(
              //   controller: _mothersNameController,
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 16.0,
              //   ),
              //   decoration: InputDecoration(
              //     labelText: "Mother's Name",
              //     labelStyle:
              //         const TextStyle(color: kPrimaryColor, fontSize: 16.0),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: const BorderSide(color: kPrimaryColor),
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Please enter your mother's name";
              //     }
              //     return null;
              //   },
              // ),
              const SizedBox(height: kDefaultPadding),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle:
                      const TextStyle(color: kPrimaryColor, fontSize: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: kDefaultPadding),
              TextFormField(
                controller: _passwordController,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle:
                      const TextStyle(color: kPrimaryColor, fontSize: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  // RegExp regExp = RegExp(emailPattern);
                  if (value == null || value.isEmpty) {
                    return "Password Field cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: kDefaultPadding),
              TextFormField(
                controller: _phoneController,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle:
                      const TextStyle(color: kPrimaryColor, fontSize: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  RegExp regExp = RegExp(mobilePattern);
                  if (value == null || value.isEmpty) {
                    return "Mobile Number Field cannot be empty";
                  } else if (!regExp.hasMatch(value)) {
                    return "Please enter a valid mobile number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: kDefaultPadding),
              CustomButton(
                title: 'Sign Up',
                onPress: _signUp,
                // onPress: () {
                //   if (_formKey.currentState!.validate()) {
                //     String firstName = _firstNameController.text;
                //     String lastName = _lastNameController.text;
                //     String regNo = _regNoController.text;
                //     String rollNo = _rollNoController.text;
                //     String std = _stdController.text;
                //     String dateOfJoining = _dateOfJoiningController.text;
                //     String dateOfBirth = _dateOfBirthController.text;
                //     String fathersName = _fathersNameController.text;
                //     String mothersName = _mothersNameController.text;
                //     String email = _emailController.text;
                //     String password = _passwordController.text;
                //     String phone = _phoneController.text;
                //   }
                // },
                iconData: Icons.app_registration_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      final fname = _firstNameController.text;
      final lname = _lastNameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final contact = _phoneController.text;
      final dob = _dateOfBirthController.text;

      String userType = _getUserType(email);

      try {
        print("userType: $userType");
        print("Email: $email");
        print("Password: $password");
        print("fname: $fname");
        print("lname: $lname");
        print("contact: $contact");
        print("date of birth: $dob");

        final response = await _apiService.register(userType, {
          'email': email,
          'password': password,
          'fname': fname,
          'lname': lname,
          'contact': contact,
          'DateOfBirth': dob,
        });
        final jsonResponse = jsonDecode(response);
        print("Response: ${jsonResponse['status']}");

        if (jsonResponse['status'] == 'success') {
          _navigateToLoginScreen(userType);
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

  void _navigateToLoginScreen(String userType) {
    switch (userType) {
      case 'student':
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (route) => false,
        );
        break;
      default:
        break;
    }
  }
}
