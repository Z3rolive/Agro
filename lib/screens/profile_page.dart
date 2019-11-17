import 'package:agro/constants/constant.dart';
import 'package:agro/models/cartmodel.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: <Widget>[
              CircleAvatar(radius: 50, child: Image.asset('assets/girl.png', fit: BoxFit.contain,)),
              SizedBox(height: 20),
              Text('Sarah',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffFF6347),
                ),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Fullname'),
                    Text('Sarah', style: kSubtitleStyleBold),
                    Divider(),
                    Text('Email'),
                    Text(ScopedModel.of<CartModel>(context, rebuildOnChange: false).useremail, style: kSubtitleStyleBold,),
                    Divider(),
                    Text('Designation'),
                    Text('User',style: kSubtitleStyleBold,)
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
