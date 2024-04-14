import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chip_list/chip_list.dart';
import '../../../../../theme/theme.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/sign_up_use_case.dart';
import '../blocs/email_status.dart';
import '../blocs/form_status.dart';
import '../blocs/password_status.dart';
import '../blocs/sign_up/sign_up_cubit.dart';
import 'dashboard_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(
        signUpUseCase: SignUpUseCase(
          authRepository: context.read<AuthRepository>(),
        ),
      ),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  Timer? debounce;
  TextEditingController nameController = TextEditingController(); // Add TextEditingController for the name field

  @override
  void dispose() {
    debounce?.cancel();
    nameController.dispose(); // Dispose the TextEditingController
    super.dispose();
  }
  final List<String> _gender = [
    'Men',
    'Women',
    'Other',
  ];
  int _currentIndex = 0;
  @override
  var size,height,width;
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          // Check if sign up is successful, then navigate to DashboardScreen
          if (state.formStatus == FormStatus.submissionSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => DashboardScreen(
                userName: nameController.text,
                // You might have to retrieve user email from state or other source
                // userEmail: userEmail,
              ),
            ));
          }
        },
        builder: (context, state) {
          return

            Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child:  Center(
                    child: SizedBox(
                      height: height/1,
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Spacer(),
                                Image(
                                  image: AssetImage('assets/logo-name.png',),fit: BoxFit.fill,
                                  height: width/10,
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(left:30.0),
                                  child: Align(alignment: Alignment.topLeft,
                                      child: Text("SignUp",style:TextStyle(fontWeight: FontWeight.w900,fontSize: 30,color: Colors.black))),
                                ),
                                //
                                Padding(
                                  padding: const EdgeInsets.only(left:30.0,top:15,right: 30),
                                  child: Align(alignment: Alignment.topLeft,
                                      child: Text("Please enter details",
                                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:30.0,top:15,right: 30),
                                  child: TextFormField(
                                    key: const Key('signUp_nameInput_textField'), // Key for the name field
                                    controller: nameController,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      border:  OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                            color: Colors.blue.shade50,
                                          )
                                      ),
                                      labelText: 'Enter name',
                                      labelStyle: TextStyle(color:Colors.black54,fontWeight: FontWeight.w300,fontSize: 16,),
                                      hintText: 'Name',
                                      hintStyle: TextStyle(color:Colors.black54,fontWeight: FontWeight.w300,fontSize: 16,),
                                      filled: true,
                                      fillColor: Colors.teal.shade50,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: Colors.teal.shade50, width: 1.2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: Colors.teal.shade100, width: 1.6),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:30.0,top:5,right: 30),
                                  child: TextFormField(
                                    key: const Key('signUp_emailInput_textField'),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      errorText: state.emailStatus == EmailStatus.invalid
                                                    ? 'Invalid email'
                                                    : null,
                                      border:  OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                            color: Colors.blue.shade50,
                                          )
                                      ),
                                      labelStyle: TextStyle(color:Colors.black54,fontWeight: FontWeight.w300,fontSize: 16,),
                                      hintText: 'Email',
                                      hintStyle: TextStyle(color:Colors.black54,fontWeight: FontWeight.w300,fontSize: 16,),
                                      filled: true,
                                      fillColor: Colors.teal.shade50,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: Colors.teal.shade50, width: 1.2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: Colors.teal.shade50, width: 1.6),
                                      ),
                                    ),
                                    onChanged: (String value) {
                                      if (debounce?.isActive ?? false) debounce?.cancel();
                                      debounce = Timer(const Duration(milliseconds: 500), () {
                                        context.read<SignUpCubit>().emailChanged(value);
                                      });
                                      },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:30.0,top:5,right: 30),
                                  child: TextFormField(
                                    key: const Key('signUp_passwordInput_textField'),
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                                labelText: 'Password',
                                                errorText: state.passwordStatus == PasswordStatus.invalid
                                                    ? 'Invalid password'
                                                    : null,
                                      border:  OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                            color: Colors.blue.shade50,
                                          )
                                      ),
                                      labelStyle: TextStyle(color:Colors.black54,fontWeight: FontWeight.w300,fontSize: 16,),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(color:Colors.black54,fontWeight: FontWeight.w300,fontSize: 16,),
                                      filled: true,
                                      fillColor: Colors.teal.shade50,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: Colors.teal.shade50, width: 1.2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: Colors.teal.shade50, width: 1.6),
                                      ),
                                    ),
                                    onChanged: (String value) {
                                      context.read<SignUpCubit>().passwordChanged(value);
                                      },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:30.0,top:15,right: 30),
                                  child: Align(alignment: Alignment.topLeft,
                                      child: Text("Select your gender",
                                          style:TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.black))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:30,top:10),
                                  child: Align(alignment: Alignment.topLeft,
                                    child: ChipList(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      checkmarkColor: Colors.blue,
                                      listOfChipNames: _gender,
                                      padding: EdgeInsets.all(3),
                                      activeBgColorList: [MyColors.constantColor],
                                      inactiveBgColorList: [Colors.white],
                                      activeTextColorList: [Colors.white],
                                      inactiveTextColorList: [MyColors.constantColor],
                                      borderRadiiList: [30.0],
                                      listOfChipIndicesCurrentlySeclected: [_currentIndex],
                                      extraOnToggle: (val) {
                                        _currentIndex = val;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 10, right: 10),
                                  child: SizedBox(
                                    width: width/2.5,
                                    height: 43,
                                    child: MaterialButton(
                                        key: const Key('signUp_continue_elevatedButton'),
                                        onPressed: state.formStatus == FormStatus.submissionInProgress
                                            ? null
                                            : () {
                                          context.read<SignUpCubit>().signUp(
                                            // nameController.text,
                                            email: state.email!, // Provide email value here
                                            name: nameController.text,
                                            gender: _gender[_currentIndex],
                                          );
                                        },
                                        textColor: Colors.white,
                                        color: MyColors.constantColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0)),
                                        child: const Text(
                                          "Signup",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ),
                                ),
                                Spacer(),
                                Spacer(),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),));
        },
      ),
    );
  }
}
