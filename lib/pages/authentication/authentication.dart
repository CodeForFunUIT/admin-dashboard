import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/constants/controllers.dart';
import 'package:flutter_web_dashbard/constants/style.dart';
import 'package:flutter_web_dashbard/routing/routes.dart';
import 'package:flutter_web_dashbard/widgets/custom_text.dart';
import 'package:flutter_web_dashbard/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late TextEditingController username;
  late TextEditingController password;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    username = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Do not empty';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      "Login",
                      style: GoogleFonts.roboto(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "Welcome back to the admin panel.",
                      color: lightGrey,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    labelText: "User name",
                    hintText: "Enter your username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: validateEmpty,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: validateEmpty,
                ),
                const SizedBox(
                  height: 15,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Row(
                //       children: [
                //         Checkbox(value: true, onChanged: (value) {}),
                //         const CustomText(
                //           text: "Remeber Me",
                //         ),
                //       ],
                //     ),
                //     CustomText(
                //       text: "Forgot password?",
                //       color: active,
                //     )
                //   ],
                // ),
                // const SizedBox(
                //   height: 15,
                // ),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      Loading.startLoading(context);
                      await authController.login(username.text, password.text);
                      Loading.stopLoading();
                      if (authController.admin != null) {
                        Get.offAllNamed(rootRoute);

                        final snackBar = GetSnackBar(
                          backgroundColor: Colors.green.withOpacity(.6),
                          messageText: const Center(
                            child: CustomText(
                              text: "Login Success!",
                              color: Colors.white,
                            ),
                          ),
                          duration: const Duration(seconds: 2),
                        );
                        Get.showSnackbar(snackBar);
                      } else {
                        final snackBar = GetSnackBar(
                          backgroundColor: Colors.red.withOpacity(.6),
                          messageText: const Center(
                            child: CustomText(
                              text: "Login Failed!",
                              color: Colors.white,
                            ),
                          ),
                          duration: const Duration(seconds: 2),
                        );
                        Get.showSnackbar(snackBar);
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: active,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const CustomText(
                      text: "Login",
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text("Do not have admin credentials? "),
                    InkWell(
                      onTap: () {
                        final snackBar = GetSnackBar(
                          backgroundColor: Colors.red.withOpacity(.6),
                          message: "This feature haven't finish yet!",
                          duration: const Duration(seconds: 2),
                        );
                        Get.showSnackbar(snackBar);
                      },
                      child: Text(
                        "Request Credentials! ",
                        style: TextStyle(color: active),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
