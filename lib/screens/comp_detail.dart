import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/colors.dart';



class CompDetail extends StatefulWidget {
  const CompDetail({super.key});

  @override
  State<CompDetail> createState() => _CompDetailState();
}

class _CompDetailState extends State<CompDetail> {


  bool _isStart = false;
  bool _isHold= false;
  bool _isForwarded= false;
  bool _isClose= false;
  File? _imageFile;


  final List<String> items = [
    'System Display Problem',
    'RAM issue',
    'HDD issue',
    'Printer need to connect',
    'Internet Problem',
    'Mail Problem',
  ];
  String? selectedValue;


  Future<void> _captureImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isStart= false;
    _isHold= false;
    _isForwarded = false;
    _isClose = false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    forwardBottom(BuildContext context){
      return showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (BuildContext _) {
          return Container(

            color: Colors.white,
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text('Forward',style: TextStyle(fontSize: 18),)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Align(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.close)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    //height: 100,
                    color: Colors.white,
                    child: TextField(
                      //controller: passCtrl,
                      decoration: InputDecoration(
                        hintText: "Forward to",
                        filled: true,
                        //fillColor: Colors.purple.shade50,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 100,
                    color: Colors.white,
                    child: TextField(
                      //controller: passCtrl,
                      decoration: InputDecoration(
                        hintText: "Reason",
                        filled: true,
                        //fillColor: Colors.purple.shade50,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          /*Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Dashboard()),
                          );*/
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          //shape: StadiumBorder(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // or 0 for sharp corners
                            //side: BorderSide(color: Colors.black, width: 1), // the "s" you mentioned
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        child: Text("FORWARD"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    closeBottom(BuildContext context){
      return showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (BuildContext _) {
          return Container(

            color: Colors.white,
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 10, bottom: 20),
                            child: Text('Close',style: TextStyle(fontSize: 18),)),
                        Container(
                          margin: EdgeInsets.only( bottom: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.close)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(

                      border: Border.all(

                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    //margin: EdgeInsets.all(10),
                    //height: 100,
                    //color: Colors.white,
                    child: Container(
                      width: width-20,
                      height: 50,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Problem Found',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: items
                              .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (String? value) {
                            setState(() {

                              selectedValue = value;
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 140,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 100,
                    color: Colors.white,
                    child: TextField(
                      //controller: passCtrl,
                      decoration: InputDecoration(
                        hintText: "Solution",
                        filled: true,
                        //fillColor: Colors.purple.shade50,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: _imageFile != null
                              ? Image.file(_imageFile!, width: 300, height: 300, fit: BoxFit.cover)
                              : Image.asset("assets/images/noimage.png", height: 50,),
                        ),

                        ElevatedButton(
                          onPressed: _captureImage,
                          child: Text("Capture Image"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          /*Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Dashboard()),
                          );*/
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          //shape: StadiumBorder(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // or 0 for sharp corners
                            //side: BorderSide(color: Colors.black, width: 1), // the "s" you mentioned
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        child: Text("CLOSE"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.amity_blue,
        automaticallyImplyLeading: false,
        title: Text('Complaint Detail', style: TextStyle(
            color: Colors.white
        ),),




      ),

      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [



              Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                        width: width/2-3,
                        color: Colors.white,
                      margin: EdgeInsets.only(left: 2.0,top: 1.0,right: 1.0,bottom: 1.0),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('Complaint Number', style: TextStyle( color: Colors.black),)),
                    Container(
                        height: 40,
                        width: width/2-3,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 1.0,top: 1.0,right: 2.0,bottom: 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text('20250611866325', style: TextStyle( color: Colors.black),)),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                        width: width/2-3,
                        color: Colors.white,
                      margin: EdgeInsets.only(left: 2.0,top: 1.0,right: 1.0,bottom: 1.0),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('Complaint Date', style: TextStyle( color: Colors.black),)),
                    Container(
                        height: 40,
                        width: width/2-3,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 1.0,top: 1.0,right: 2.0,bottom: 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text('11-06-2025', style: TextStyle( color: Colors.black),)),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                        width: width/2-3,
                        color: Colors.white,
                      margin: EdgeInsets.only(left: 2.0,top: 1.0,right: 1.0,bottom: 1.0),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('Asset Tag', style: TextStyle( color: Colors.black),)),
                    Container(
                        height: 40,
                        width: width/2-3,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 1.0,top: 1.0,right: 2.0,bottom: 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text('AUNDT4565', style: TextStyle( color: Colors.black),)),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                        width: width/2-3,
                        color: Colors.white,
                      margin: EdgeInsets.only(left: 2.0,top: 1.0,right: 1.0,bottom: 1.0),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('Problem Reported', style: TextStyle( color: Colors.black),)),
                    Container(
                        height: 40,
                        width: width/2-3,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 1.0,top: 1.0,right: 2.0,bottom: 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text('IT SUPPORT REQUIRED', style: TextStyle( color: Colors.black),)),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                        width: width/2-3,
                        color: Colors.white,
                      margin: EdgeInsets.only(left: 2.0,top: 1.0,right: 1.0,bottom: 1.0),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('Engineer Name', style: TextStyle( color: Colors.black),)),
                    Container(
                        height: 40,
                        width: width/2-3,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 1.0,top: 1.0,right: 2.0,bottom: 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text('Mohan Thakur', style: TextStyle( color: Colors.black),)),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                        width: width/2-3,
                        color: Colors.white,
                      margin: EdgeInsets.only(left: 2.0,top: 1.0,right: 1.0,bottom: 1.0),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      child: Text('Engineer Contact', style: TextStyle( color: Colors.black),)),
                    Container(
                        height: 40,
                        width: width/2-3,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 1.0,top: 1.0,right: 2.0,bottom: 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text('9876543210', style: TextStyle( color: Colors.black),)),
                  ],
                ),
              ),

              _isStart && _isHold? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: (){
                      setState(() {

                        _isHold=false;
                      });

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.amity_blue,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    label: Text('Resume', style: TextStyle(color: Colors.white),),


                  )
                ],
              ):_isStart && !_isHold ?Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: (){
                        setState(() {
                          _isHold = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      label: Text('Hold', style: TextStyle(color: Colors.white),),


                    ),
                    ElevatedButton.icon (
                      onPressed: (){
                        setState(() {
                          forwardBottom(context);
                        });


                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      label: Text('Forward', style: TextStyle(color: Colors.white),),


                    ),
                    ElevatedButton.icon(
                      onPressed: (){
                        closeBottom(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      label: Text('Close', style: TextStyle(color: Colors.white),),


                    )
                  ],
                ),
              ):Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                      onPressed: (){
                        setState(() {

                          _isStart=true;
                        });

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.amity_yellow,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      label: Text('Start', style: TextStyle(color: AppColors.amity_blue),),


                  )
                ],
              ),




            ],
          ),
        ),
      ),
    );
  }
}
