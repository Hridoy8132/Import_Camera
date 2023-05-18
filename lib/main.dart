import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  
  runApp(new MaterialApp(
    title: "Camera App",
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

   PickedFile? pickedImage;
   late File imageFile;
   bool _load = false;


  _openGallery(BuildContext context) async {
   var picture = (await ImagePicker().pickImage(source: ImageSource.gallery)) as File;
   this.setState(() {
     imageFile = picture;
     _load = false;

   });

   Navigator.of(context).pop();

  }
  _openCamera( BuildContext context) async {
    var picture = (await ImagePicker().pickImage(source: ImageSource.camera)) as File;
    this.setState(() {
      imageFile = picture;
      _load = false;
    });

    Navigator.of(context).pop();

  }

  Future<void> _showChoicedialog(BuildContext context){
    return showDialog(context: context, builder:(BuildContext context){
      return AlertDialog(
        title: Text("Make a Choice!"),
        content: SingleChildScrollView(
          child:ListBody(
            children:<Widget> [
              GestureDetector(
                child: Text("Gallery"),
                onTap: (){

                  _openGallery(context);
                },
              ),
             Padding(padding: EdgeInsets.all(8.0)),
             GestureDetector(
               child: Text("Camera"),
               onTap: (){

                _openCamera(context);
               },
             )

            ],

          )
        ),
      );
    });
  }

  Widget_decideImageView(){

    if(imageFile == null){
      return Text("No Image Selected");
    }else {
      Image.file(imageFile,width: 400, height: 400);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mian Screen"),

      ),

      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Widget_decideImageView(),
              Image.file(imageFile,width: 400,height: 400,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  _showChoicedialog(context);
                },
                child: Text('Select Image'),
              )




            ],
          ),
        ),
      ),

    );
  }
}

