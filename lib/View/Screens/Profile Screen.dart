import 'package:currencyapp/View%20Model/Provider/Photo%20Provider.dart';
import 'package:currencyapp/View%20Model/Provider/Theme%20provider.dart';
import 'package:currencyapp/View%20Model/Provider/auth_provider.dart';
import 'package:currencyapp/core/themes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class Profile_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userprovider =Provider.of<Auth_Provider>(context);
    var profileimage = Provider.of<PhotoProvider>(context).imagefile;
    return Consumer<Auth_Provider>(builder: (context, value, child) {
      value.getuser();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () => VoidCallbackAction(
                            ),
                            child: Ink.image(
                                height: 150,
                                width: 150,
                                fit: BoxFit.fill,
                                image:userprovider.user.image==null?FileImage(profileimage!) as ImageProvider:NetworkImage(userprovider.user.image)
                            )
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(context: context, builder: (context) => AlertDialog(
                          elevation: 25,
                          title: Text('Edit photo'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<PhotoProvider>(context,listen: false).getimage(ImageSource.camera);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt,color: Colors.black,),
                                  SizedBox(width: 5,),
                                  Text("From Camera",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                                ],
                              ),
                              style: ButtonStyle(
                                  fixedSize: MaterialStatePropertyAll(Size(200,30)),
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                  backgroundColor: MaterialStatePropertyAll(Colors.blue)
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<PhotoProvider>(context,listen: false).getimage(ImageSource.gallery);

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo,color: Colors.black,),
                                  SizedBox(width: 5,),
                                  Text("From Gallery",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                                ],
                              ),
                              style: ButtonStyle(
                                  fixedSize: MaterialStatePropertyAll(Size(200,30)),
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                  backgroundColor: MaterialStatePropertyAll(Colors.blue)
                              ),
                            ),

                          ],
                          shape: RoundedRectangleBorder(),
                        ),);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 20,
                        child: Icon(Icons.add_a_photo_rounded,color: Colors.white,),
                      ),
                    ),
                  ]
              ),
              SizedBox(height: 20,),
              Text(userprovider.user.name,style: TextStyle(fontSize: 25),),
              SizedBox(height: 10,),
              Text(userprovider.user.email,style: TextStyle(color: Colors.grey,fontSize: 15),),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) =>AlertDialog(
                    elevation: 25,
                    title: Text('Change Theme',style: TextStyle(color: Themes.isDarkMode(context)?Colors.white:Colors.black),),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<Theme_Provider>(context,listen: false).saveThemeModetoSharePref(ThemeMode.light);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Light Theme",style: TextStyle(color: Colors.black),),
                            Icon(Icons.light_mode_outlined,color: Colors.black,),
                          ],
                        ),
                        style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(Size(200,30)),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            backgroundColor: MaterialStatePropertyAll(Colors.white)
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<Theme_Provider>(context,listen: false).saveThemeModetoSharePref(ThemeMode.dark);
                        },
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Dark Theme",style: TextStyle(color: Colors.white),),
                            Icon(Icons.dark_mode,color: Colors.white,),
                          ],
                        ),
                        style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(Size(200,30)),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            backgroundColor: MaterialStatePropertyAll(Colors.black)
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<Theme_Provider>(context,listen: false).saveThemeModetoSharePref(ThemeMode.system);
                        },
                        child: Text("System Theme",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                        style: ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(Size(200,30)),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            backgroundColor: MaterialStatePropertyAll(Colors.blue)
                        ),
                      ),
                    ],
                    shape: RoundedRectangleBorder(),
                  ),);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lightbulb,),
                    SizedBox(width: 5,),
                    Text("Theme Mode",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                  ],
                ),
                style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size(200,30)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  Provider.of<Auth_Provider>(context,listen: false).logout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout,),
                    SizedBox(width: 5,),
                    Text("Logout",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
                  ],
                ),
                style: ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size(200,30)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)
                ),
              ),
            ],
          ),
        ),
      );
    },);
  }
}
