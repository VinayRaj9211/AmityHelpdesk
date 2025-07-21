
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../widgets/colors.dart';



class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // TODO: implement your code here

    setState(() {
     // clearMsg = true;
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.amity_blue,
        automaticallyImplyLeading: false,
        title: Text('complaints', style: TextStyle(
          color: Colors.white
        ),),

        actions: <Widget>[
          IconButton(onPressed: (){
            Scaffold.of(context).showBottomSheet((BuildContext context) {
              return Container(
                height: 400,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                        child: const Text('Select'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
          },
              icon: Icon(
                Icons.filter_alt,
                color: Colors.white,
              ))
        ],


      ),
      drawer:Container(
        color: Colors.amber,
      ),
      body: ListView.builder(
        //physics: NeverScrollableScrollPhysics(),
        itemCount: 50,
        itemBuilder: (context, index) => Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 0.5),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: (){
                  /*Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CompDetail()),
                  );*/

                },
                leading: Icon(Icons.notifications_sharp),
                title: Text('2025061186635', style: TextStyle(fontSize: 14),),
                subtitle: Text('System display issue', style: TextStyle(fontSize: 12),),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text('pending', style: TextStyle( fontSize: 10, color: Colors.green, ), ),
                    Text('11-06-2025 10:11:06' , style: TextStyle( fontSize: 11, color: Colors.grey),),


                  ],
                ),
              ),
              Container(
                height: 0.2,
                color:Colors.grey ,
              )
            ],
          ),
        ),
      ),
    );
  }
}
