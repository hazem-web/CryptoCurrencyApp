import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../View Model/Provider/auth_provider.dart';
import '../../../core/themes.dart';
import 'Register_Screen.dart';

class  LoginScreen extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _password = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign in",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
              Text("Welcome Back",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                validator: (value) {
                  if(value!.isEmpty || !value.contains("@")){
                    return "Please enter your email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('Email',),
                  prefixIcon: Icon(Icons.email,color: Colors.grey,),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,style: BorderStyle.solid)
                  ),
                  border:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,style: BorderStyle.solid)
                  ),

                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _password,
                obscureText:Provider.of<Auth_Provider>(context).obscure_text ,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if(value!.isEmpty || value.length < 3){
                    return "Please enter your password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  label: Text('Password',),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,style: BorderStyle.solid)
                  ),
                  border:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,style: BorderStyle.solid)
                  ),
                  prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                  suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye),onPressed: () {
                    Provider.of<Auth_Provider>(context,listen: false).password();
                  },),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      Provider.of<Auth_Provider>(context,listen: false).login(email: _email.text, password: _password.text);
                    }
                  },
                  child: Text('Sign in',style: TextStyle(fontSize: 20),),
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?',),
                  TextButton(
                    onPressed: () {
                      Get.to(RegisterScreen());
                    },
                    child: Text('Sign Up',style: TextStyle(color: Colors.teal),),
                  ),
                ],
              ),
              // Sign in with google logo
              SizedBox(height: 40,),
              GestureDetector(
                  onTap: (){
                    Provider.of<Auth_Provider>(context,listen: false).googlesignin();
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Themes.isDarkMode(context)?Colors.grey:Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/google.png',height: 20,),
                        SizedBox(width: 10,),
                        Text('Sign in with Google',),
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
