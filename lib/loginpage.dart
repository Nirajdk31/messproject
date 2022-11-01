import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'dashboard.dart';
import 'scannerpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login(String username,String password)async{
    var url = "https://softerp.in/tiffin_test/api/login.php";
    var response = await http.post(Uri.parse(url),body: {
      "username" : user.text,
      "password" : pass.text,
    });
    var data = json.decode(response.body);
    if (data['Status_code'] =="200") {
      Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16,
      );
      Navigator.push(context,MaterialPageRoute(builder: (context) => DashboardPage()));
    }
    else {
      Fluttertoast.showToast(
        msg: "Username/Password Incorrect!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/wavybg.jpg'),
                  fit: BoxFit.fill,
                  opacity: 0.2,
              ),),
          padding: const EdgeInsets.only(left: 20, right: 20, top: 200, bottom: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                child: TextFormField(
                  controller: user,
                  autofocus: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1,color: Colors.grey.shade100,style: BorderStyle.solid)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1,color: Colors.black54,style: BorderStyle.solid)
                      ),
                      isCollapsed: true,
                      labelText: 'Username Id',
                      contentPadding: EdgeInsets.only(top: 15,bottom:15,left: 15,right: 15),
                      floatingLabelStyle: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                child: TextFormField(
                  controller: pass,
                  autofocus: false,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1,color: Colors.grey.shade100,style: BorderStyle.solid)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1,color: Colors.black54,style: BorderStyle.solid)
                      ),
                      isCollapsed: true,
                      labelText: 'Password',
                      contentPadding: EdgeInsets.only(top: 15,bottom:15,left: 15,right: 15),
                      floatingLabelStyle: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 45,
                width: 100,
                child: ElevatedButton(
                  onPressed: (){
                    login(user.text, pass.text);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF68A7AD),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  child: const Text('Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
