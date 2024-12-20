import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/widgets/custom_input_field.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String? errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isAuthenticated()) {
        Navigator.pushReplacementNamed(context, "/layout");
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Dimensions.lgHeight,
            Text(S.of(context).sign_up,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            Dimensions.lgHeight,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomInputField(
                          controller: firstNameController,
                          hintText: S.of(context).first_name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).please_enter_first_name;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: CustomInputField(
                          controller: lastNameController,
                          hintText: S.of(context).last_name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).please_enter_last_name;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Dimensions.smHeight,
                  CustomInputField(
                    controller: emailController,
                    hintText: S.of(context).email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).please_enter_email;
                      }
                      return null;
                    },
                  ),
                  Dimensions.smHeight,
                  CustomInputField(
                    controller: passwordController,
                    hintText: S.of(context).password,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).please_enter_password;
                      }
                      return null;
                    },
                  ),
                  if (errorMessage != null)
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          errorMessage!,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: ColorConstants.danger,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  Dimensions.mdHeight,
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                errorMessage = null;
                                _isLoading = true;
                              });
                              String? result = await Provider.of<AuthProvider>(
                                      context,
                                      listen: false)
                                  .signup(
                                emailController.text,
                                passwordController.text,
                                firstNameController.text,
                                lastNameController.text,
                              );
                              if (result == null) {
                                Navigator.pushReplacementNamed(
                                    context, '/layout');
                              } else {
                                setState(() {
                                  errorMessage = result;
                                  _isLoading = false;
                                });
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: ColorConstants.primary,
                      foregroundColor: ColorConstants.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: const StadiumBorder(),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  ColorConstants.white),
                            ),
                          )
                        : Text(S.of(context).sign_up),
                  ),
                  Dimensions.mdHeight,
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/signin');
                    },
                    child: Text.rich(
                      TextSpan(
                        text: S.of(context).have_account,
                        children: [
                          TextSpan(
                            text: S.of(context).sign_in,
                            style: const TextStyle(
                                color: ColorConstants.secondary),
                          ),
                        ],
                      ),
                      style: const TextStyle(color: ColorConstants.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
