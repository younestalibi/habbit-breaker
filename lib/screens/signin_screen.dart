import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:habbit_breaker/constants/color_constants.dart';
import 'package:habbit_breaker/constants/image_constants.dart';
import 'package:habbit_breaker/generated/l10n.dart';
import 'package:habbit_breaker/utils/dimensions.dart';
import 'package:habbit_breaker/widgets/custom_dialog.dart';
import 'package:habbit_breaker/widgets/custom_input_field.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = 'younessetalibi8@gmail.com';
    _passwordController.text = '123456';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Image.asset(
                    ImageConstants.logo,
                    height: 100,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Text(
                    S.of(context).sign_in,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomInputField(
                          controller: _emailController,
                          hintText: S.of(context).email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).please_enter_email;
                            }
                            return null;
                          },
                          icon: Icons.email,
                          label: S.of(context).email,
                        ),
                        Dimensions.smHeight,
                        CustomInputField(
                          controller: _passwordController,
                          hintText: S.of(context).password,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).please_enter_password;
                            }
                            return null;
                          },
                          icon: Icons.lock,
                          label: S.of(context).password,
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
                        Dimensions.mdHeight,
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
                                            .login(
                                      _emailController.text,
                                      _passwordController.text,
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
                              : Text(S.of(context).sign_in),
                        ),
                        Dimensions.mdHeight,
                        TextButton(
                          onPressed: () {
                            _showForgotPasswordDialog(context);
                          },
                          child: Text(S.of(context).forget_password,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text.rich(
                              TextSpan(
                                text: S.of(context).have_no_account,
                                children: [
                                  TextSpan(
                                    text: S.of(context).sign_up,
                                    style: TextStyle(
                                        color: ColorConstants.secondary),
                                  ),
                                ],
                              ),
                              style: TextStyle(color: ColorConstants.grey)),
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

  void _showForgotPasswordDialog(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    CustomDialog.show(
      context,
      title: S.of(context).reset_password,
      textConfirm: S.of(context).send_reset_link,
      content: TextField(
        controller: _emailController,
        decoration: InputDecoration(hintText: S.of(context).enter_email),
        keyboardType: TextInputType.emailAddress,
      ),
      dialogType: DialogType.confirmation,
      onConfirm: () async {
        String? result = await Provider.of<AuthProvider>(context, listen: false)
            .resetPassword(_emailController.text);
        if (result == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).password_reset_sent)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result)),
          );
        }
      },
    );
  }
}
