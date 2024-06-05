import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scrollx/frontend/register_contact.dart';
import 'package:scrollx/frontend/register_name_surname.dart';
import 'package:scrollx/frontend/reset_password.dart';

import 'continue_watching.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 60, 0, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 175,
                        height: 175,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/img/logo.png'
                                )
                            )
                        )
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(left: 10),
                    //   child: Text(
                    //     "Login",
                    //     style: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: 46
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                  color: Colors.white
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 75),
                      height: 100,
                      width: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hoverColor: Colors.black,
                          prefixIcon: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.email_outlined,
                              size: 50,

                            ),
                          ),
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.blue[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 20
                            )
                          )
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 300,
                      child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              filled: true,
                              fillColor: Colors.blue[100],
                              prefixIcon: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(
                                  Icons.key,
                                  size: 50,

                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 20
                                  )
                              )
                          ),
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 75, vertical: 15)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          )
                        ),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ContinueWatching()), (Route<dynamic> route) => false);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 75, 90, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12
                                ),
                              )
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()));
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Reset here',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.blue
                                  ),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 90, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                              child: Text(
                                'New here?',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12
                                ),
                              )
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterNameSurname()));
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Sign up here',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.blue
                                  ),
                                )
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
