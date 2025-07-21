import 'package:flutter/material.dart';

import '../widgets/colors.dart';

class MyLabs extends StatefulWidget {
  const MyLabs({super.key});

  @override
  State<MyLabs> createState() => _MyLabsState();
}

class _MyLabsState extends State<MyLabs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.amity_blue,
        automaticallyImplyLeading: false,
        title: Text('My Team', style: TextStyle(
            color: Colors.white
        ),),




      ),
      body: SafeArea(child: ListView.builder(
        itemBuilder:(context, index) =>
            ListTile(
              onTap: (){
                /*Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Complaints()),
                );*/

              },
              leading: Icon(Icons.settings_applications_outlined),
              title: Text('E2 Forth Floor E2001 '),
              subtitle: Text('MatLab'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('35 Systems', style: TextStyle(
                    fontSize: 10,
                  ),),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
      )),
    );
  }
}
