import 'package:agro/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
     /*  backgroundColor: Color(0xff687DA4), */
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    
                  ),
                  child: Image.asset('assets/logo3.png'),
                ),
                SizedBox(height: 10,),
                Text(
                  'NEPAFARM',
                  style: TextStyle(color:Colors.green, fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:40.0),
                  child: Text('NepaFarm aims to increase efficiency, helping farmers maximize yields for every kilo fertilizer applied through knowledge sharing, balanced and crop-specific nutrition and technology.',style: TextStyle(color:Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                      leading: Icon(LineIcons.globe, color: Colors.blueGrey, size: 35,),
                      title: Text('Go To Website',style:TextStyle(color:Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      trailing: Icon(LineIcons.arrow_right),
                    ),
                    OrangeDivider(
                    ),
                    ListTile(
                       leading: Icon(LineIcons.envelope, color: Colors.red, size: 35,),
                      title: Text('Email Us', style:TextStyle(color:Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      trailing: Icon(LineIcons.arrow_right),
                    ),
                    OrangeDivider(),
                    ListTile(
                      leading: Icon(LineIcons.thumbs_o_up, color: Colors.green[600], size: 35,),
                      title: Text('FeedBack',style:TextStyle(color:Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      trailing: Icon(LineIcons.arrow_right),
                    ),
                    OrangeDivider(),
                    ListTile(
                      leading: Icon(LineIcons.bug, color: Colors.orange, size: 35,),
                      title: Text('Report Issues',style: TextStyle(color:Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      trailing: Icon(LineIcons.arrow_right),
                    ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
