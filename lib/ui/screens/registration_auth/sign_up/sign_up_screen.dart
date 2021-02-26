import 'package:antonx/core/constant/colors.dart';
import 'package:antonx/core/constant/text_style.dart';
import 'package:antonx/core/enums/view_state.dart';
import 'package:antonx/ui/custom_widget/auth_message.dart';
import 'package:antonx/ui/custom_widget/input_text_form_field.dart';
import 'package:antonx/ui/custom_widget/rectanguler_button.dart';
import 'package:antonx/ui/custom_widget/social_auth_button.dart';
import 'package:antonx/ui/screens/dashboard/dashboard_screen.dart';
import 'package:antonx/ui/screens/registration_auth/login/login_screen.dart';
import 'package:antonx/ui/screens/registration_auth/sign_up/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              ///
              /// Body Start From Here
              ///
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(25, 65, 25, 28),

                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text("Welcome abroad 👩‍✈️‍", style: headingTextStyle,),

                        SizedBox(height: 9,),

                        Text("We are happy to see you again.\nLogin to proceed.",
                          style: subHeadingTextStyle.copyWith(
                            height: 1.2,
                            fontSize: 16,
                          ),),

                        SizedBox(height: 45,),

                        ///
                        /// Name Text Field
                        ///
                        InputTextFormField(
                          hintText: "Name",
                          controller: TextEditingController(text: model.appUser.name),
                          validation: (String val) {
                            if (val == null || val.length < 1)
                              return 'Please enter FullName';
                            else
                              return null;
                          },
                          onChanged: (val) {
                            model.appUser.name = val;
                          },
                        ),

                        SizedBox(height: 10,),

                        ///
                        /// Email Text Field
                        ///
                        InputTextFormField(
                          hintText: "Email",
                          controller: TextEditingController(text: model.appUser.email),
                          validation: (String val) {
                            if (val == null || val.length < 1)
                              return 'Please enter your email';
                            else
                              return null;
                          },
                          onChanged: (val) {
                            model.appUser.email = val;
                          },
                        ),

                        SizedBox(height: 10,),

                        ///
                        /// Password Text Field
                        ///
                        InputTextFormField(
                          hintText: "Password",
                          isPasswordActive: true,
                          controller: TextEditingController(text: model.appUser.password),
                          validation: (String val) {
                            if (val == null || val.length < 6)
                              return 'Min Password length = 6 characters';
                            else
                              return null;
                          },
                          onChanged: (val) {
                            model.appUser.password = val;
                          },
                        ),

                        SizedBox(height: 92,),

                        ///
                        /// Registration Button
                        ///
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: RectangularButton(
                            onPressed: () async{
                              if(_formKey.currentState.validate()){
                                await model.createAccount();
                                if(model.authResult.status){
                                  Get.to(DashboardScreen());
                                } else{
                                  showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      title: Text('Login Error'),
                                      content: Text(
                                          model?.authResult?.errorMessage ??
                                              'Login Failed'),
                                    ),
                                  );
                                }
                              }
                            },
                            text: "Register",
                            textColor: Colors.white,
                            buttonColor: primaryColor,

                          ),
                        ),


                        ///
                        /// or Text
                        ///
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text("or",textAlign: TextAlign.center ,style: subHeadingTextStyle,),
                          ),
                        ),

                        ///
                        /// Sign Up WIth Google Button
                        ///
                        SocialAuthButton(
                          onPressed: () async{
                            await model.signInWithGoogle();
                            if(model.authResult.status){
                              Get.to(DashboardScreen());
                            } else{
                              showDialog(
                                context: context,
                                child: AlertDialog(
                                  title: Text('Login Error'),
                                  content: Text(
                                      model?.authResult?.errorMessage ??
                                          'Login Failed'),
                                ),
                              );
                            }
                          },
                          buttonName: "Sign Up with Google",
                        ),

                        SizedBox(height: 30,),

                        ///
                        /// Already Have account Button
                        ///
                        Center(
                          child: AuthMessage(
                            onPressed: () => Get.to(LoginScreen()),
                            text: "Already",
                            authText: "Login",
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),),
        ),
      ),
    );
  }
}
