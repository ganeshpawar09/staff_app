import 'package:flutter/material.dart';
import 'package:staff_flutter_app/screens/const/font.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/screens/home/home_screen.dart';
import 'package:staff_flutter_app/state/user_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';
  bool visibility = true;
  FocusNode focusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  void toggleVisibility() {
    setState(() {
      visibility = !visibility;
    });
  }

  void loginNew(BuildContext context) async {
    var isvalid = _formKey.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _formKey.currentState!.save();
    bool istoken = await Provider.of<UserState>(
      context,
      listen: false,
    ).loginNow(_usernameController.text, _passwordController.text);
    if (istoken) {
      navig();
    } else {
      if (context.mounted) {
        showErrorMessage(context, 'Incorrect username or password');
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showErrorMessage(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void navig() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  "Login to",
                  style: AppStyles.mondaB.copyWith(fontSize: 35),
                ),
                Text(
                  "your account",
                  style: AppStyles.mondaB.copyWith(fontSize: 35),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textformfield(_usernameController, "Username",
                            visibility, toggleVisibility),

                        const SizedBox(height: 16.0),
                        textformfield(_passwordController, "Password",
                            visibility, toggleVisibility),

                        // const SizedBox(height: 32.0),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Text(
                        //       "Forgot Password?",
                        //       textAlign: TextAlign.center,
                        //       style: GoogleFonts.monda(
                        //         textStyle: const TextStyle(
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.w600,
                        //           fontSize: 13,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                focusNode.unfocus();
                                loginNew(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Text(
                                  "LOG IN",
                                  textAlign: TextAlign.center,
                                  style: AppStyles.mondaB.copyWith(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget textformfield(TextEditingController controller, String labelText,
    bool visibility, VoidCallback toggleVisibility) {
  return TextFormField(
      obscureText: (labelText == "Password") ? visibility : false,
      controller: controller,
      cursorColor: Colors.black,
      style: AppStyles.mondaN.copyWith(fontSize: 18),
      decoration: InputDecoration(
        suffixIcon: (labelText == "Password")
            ? IconButton(
                onPressed: toggleVisibility,
                icon: Icon(visibility
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
              )
            : const SizedBox(),
        labelStyle: AppStyles.mondaN.copyWith(fontSize: 18),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        labelText: labelText,
      ),
      validator: (value) {
        if (value.toString().isEmpty) {
          return 'Please enter your ${labelText.toLowerCase()}';
        }
        return null;
      });
}
