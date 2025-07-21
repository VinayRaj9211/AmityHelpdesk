import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/auth_controller.dart';
import '../utils/network_checker.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool _obscured = true;
  final textFieldFocusNode = FocusNode();

  _am_login(emp_id, emp_pass) async{

    /*var response = await AuthController.loginUser(emailCtrl.text, passCtrl.text);
      if(response.toString()=='success'){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      }else if(response.toString()=='empty'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please fill both entries..."),
        ));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong..."),
        ));
      }
*/

    final auth = Provider.of<AuthController>(context, listen: false);
    bool success = await auth.login(emailCtrl.text, passCtrl.text);

    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.errorMessage ?? "Login failed") , backgroundColor: Colors.red,),
      );
    }



    return "good";

  }
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        title: Text('Amity Engineer'),
        backgroundColor: Colors.blueAccent,
      ),*/
      body:Scaffold(
        body: Stack(
          fit: StackFit.passthrough,
          children: [
            // Background image
            Center(
              child: Image.asset(
                'assets/images/vin2.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Overlay Progress Bar

            // Blur effect
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5000, sigmaY:5000),
              child: Container(
                color: Colors.black.withOpacity(0), // Required to enable blur
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX:5000, sigmaY: 5000),
              child: Container(
                color: Colors.black.withOpacity(0), // Required to enable blur
              ),
            ),
            SingleChildScrollView(
                child: Column(
                  children: [

                    Container(
                      height: height/1.8,
                      child: Center(
                          child: Image.asset("assets/images/amitylogo.png", height: 150,)
                      ),


                    ),

                    SizedBox(height: 50),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Center(
                        child: TextField(
                          controller: emailCtrl,
                          decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.person, size: 20,),
                            filled: true,
                            //fillColor: Colors.purple.shade50,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: TextField(
                        controller: passCtrl,
                        obscureText: _obscured,
                        enableSuggestions: false,
                        autocorrect: false,
                        focusNode: textFieldFocusNode,
                        decoration: InputDecoration(
                          hintText: "Password",

                          prefixIcon: Icon(Icons.password, size: 20,),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                _obscured
                                    ?  Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                size: 24,
                              ),
                            ),
                          ),
                          filled: true,
                          //fillColor: Colors.purple.shade50,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),

                    SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: ElevatedButton(
                          onPressed: () async {
                            //checkInternet();
                            //print('✅ Internet is available');
                            if(emailCtrl.text.trim().length>0 && passCtrl.text.length>0){
                              _am_login(emailCtrl,passCtrl);
                              /* bool isOnline = await NetworkChercker.hasInternetConnection();
                              if (isOnline) {
                                //print('✅ Internet is available');

                              } else {
                                //print('❌ No internet connection');
                              }*/
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Both fields are mandatory"), backgroundColor: Colors.red,),
                              );
                            }


                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            //shape: StadiumBorder(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // or 0 for sharp corners
                              //side: BorderSide(color: Colors.black, width: 1), // the "s" you mentioned
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          child: Text("LOGIN"),
                        ),
                      ),
                    ),
                    //Expanded(child: SizedBox()),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Center(
                        child: Text('Amity IT Sec 125 Noida', style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey
                        ),),
                      ),
                    )
                  ],
                )
            ),
            // Foreground content
            if (authController.isLoading)
              authController.isLoading?Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ): Container(),
          ],
        ),
      ),


    );
  }
}





