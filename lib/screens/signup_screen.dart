import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/screens/signin_screen.dart';
import 'package:habbit_breaker/widgets/custom_dropdown_field.dart';
import 'package:habbit_breaker/widgets/custom_input_field.dart';
import 'package:provider/provider.dart';
import 'layout_screen.dart';
import '../providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
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
  String? selectedGender;

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
      appBar: AppBar(
        title: null,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Text(S.of(context).sign_up,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  SizedBox(height: constraints.maxHeight * 0.05),
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
                                    return S
                                        .of(context)
                                        .please_enter_first_name;
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
                        SizedBox(height: 16.0),
                        CustomDropdownField(
                          value: selectedGender,
                          hintText: S.of(context).select_gender,
                          items: ['Male', 'Female', 'Other'],
                          fillColor: Colors.grey[200]!, // Custom fill color
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGender = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return S.of(context).please_select_gender;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
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
                        SizedBox(height: 16),
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
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                errorMessage!,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: ColorConstants.danger,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        const SizedBox(
                          width: 10,
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      errorMessage = '';
                                      _isLoading = true;
                                    });
                                    String? result =
                                        await Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .signup(
                                      emailController.text,
                                      passwordController.text,
                                      firstNameController.text,
                                      lastNameController.text,
                                      selectedGender ?? 'Other',
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
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        ColorConstants.white),
                                  ),
                                )
                              : Text(S.of(context).sign_up),
                        ),
                        const SizedBox(height: 16.0),
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
                                  style: TextStyle(
                                      color: ColorConstants.secondary),
                                ),
                              ],
                            ),
                            style: TextStyle(color: ColorConstants.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
