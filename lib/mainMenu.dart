import 'dart:io';
import 'package:agro/constants/constant.dart';
import 'package:agro/order/cartmodel.dart';
import 'package:agro/order/home.dart';
import 'package:agro/pages/aboutpage.dart';
import 'package:agro/pages/newspage.dart';
import 'package:agro/pages/querypage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:line_icons/line_icons.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;

  MainMenu(this.signOut);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  String email = "", name = "", id = "";
  TabController tabController;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      email = preferences.getString("email");
      name = preferences.getString("name");
    });
    print("id" + id);
    print("user" + email);
    print("name" + name);
  }
  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: const FlexibleSpaceBar(
              
              title: Text("Home",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 24.0,
                      )),
                      background: Image(image: AssetImage('assets/Header.png'),
                      fit: BoxFit.cover,),
            ),

            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_circle),
                tooltip: 'Add new entry',
                onPressed: () {},
              ),
            ],
            floating: true,
            pinned: true,
            elevation: 0,
          ),
          
          SliverFillRemaining(
            
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                SizedBox(height: 20),
                  
                    Text('Talk to Expert', style: kTitleStyle,),
                    Text('If you have any queries about something,'+
                     'you can post ask your query to the expert along with the photo. Just press the button Below to post your query.', style: kSubtitleStyle,),
                    Align(
                      alignment: Alignment.center,
                                          child: RaisedButton(
                        color: Colors.orange,
                      child: Text('Ask query'),
                        onPressed: (){
                          Navigator.pushNamed(context, '/query', arguments: email);
                        },
                      ),
                    ),
                  SizedBox(height: 30,),
                Text('Order Materials', style: kTitleStyle,),
                Text('Press the button below to view and order materials. '),
                Align(
                      alignment: Alignment.center,
                                          child: RaisedButton(
                        color: Colors.orange,
                      child: Text('Order'),
                        onPressed: (){
                          Navigator.pushNamed(context, '/order', arguments: email);
                        },
                      ),
                    ),
                    Text('View Documentations', style: kTitleStyle,),
                    Text('Documents are available on how to grow particular plants.'),
                     Align(
                      alignment: Alignment.center,
                                          child: RaisedButton(
                        color: Colors.orange,
                      child: Text('View Documents'),
                        onPressed: (){
                          Navigator.pushNamed(context, '/library');
                        },
                      ),
                    ),
              ],),
            ),
          ),
        ],
      ),
        
        drawer: Drawer(
          elevation: 0,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/drawer.jpg'),
                  ),
                ),
                accountName: Text('$name',
                    style: TextStyle(backgroundColor: Colors.green[400])),
                accountEmail: Text(' $email ',
                    style: TextStyle(backgroundColor: Colors.green[400])),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/girl.png'),
                ),
              ),
              ListTile(
                  title: Text(
                    'Talk to Expert',
                    style: kTileTitleStyle,
                  ),
                  dense: true,
                  leading: Icon(
                    LineIcons.question_circle,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pushNamed('/query',arguments: email);
                  }),
              GreenDivider(),
              ListTile(
                  dense: true,
                  title: Text('Ask For Material', style: kTileTitleStyle),
                  leading: Icon(
                    LineIcons.pagelines,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pushNamed('/order', arguments: email);
                    ScopedModel.of<CartModel>(context).setUser(email); 
                  }),
              GreenDivider(),
              ListTile(
                  dense: true,
                  title: Text('Library', style: kTileTitleStyle),
                  leading: Icon(
                    LineIcons.book,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pushNamed('/library'); 
                  }),
              GreenDivider(),
              ListTile(
                  dense: true,
                  title: Text('News', style: kTileTitleStyle),
                  leading: Icon(
                    LineIcons.newspaper_o,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewsPage()));
                  }),
              GreenDivider(),
              ListTile(
                  dense: true,
                  title: Text('Schedule', style: kTileTitleStyle),
                  leading: Icon(LineIcons.calendar, color: iconColor),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {}),
              GreenDivider(),
              ListTile(
                  dense: true,
                  title: Text('About Us', style: kTileTitleStyle),
                  leading: Icon(LineIcons.linux, color: iconColor),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutPage()));
                  }),
              GreenDivider(),
              ListTile(
                  dense: true,
                  title: Text('Log Out', style: kTileTitleStyle),
                  leading: Icon(LineIcons.sign_out),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    _showLogOutDialog();
                  }),
              GreenDivider(),
              ListTile(
                  dense: true,
                  title: Text('Exit App', style: kTileTitleStyle),
                  leading: Icon(
                    LineIcons.power_off,
                    color: Colors.red,
                  ),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    _showExitDialog();
                  }),
            ],
          ),
        ),
      ),
    );
    
    /* Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(Icons.lock_open),
          )
        ],
      ),
      body: Center(
        child: Text(
          "WelCome",
          style: TextStyle(fontSize: 30.0, color: Colors.blue),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.black,
        iconSize: 30.0,
//        iconSize: MediaQuery.of(context).size.height * .60,
        currentIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
          selectedIndex = 'TAB: $currentIndex';
//            print(selectedIndex);
          reds(selectedIndex);
        },

        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Color(0xFFf7d426)),
          BottomNavyBarItem(
              icon: Icon(Icons.view_list),
              title: Text('List'),
              activeColor: Color(0xFFf7d426)),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              activeColor: Color(0xFFf7d426)),
        ],
      ),
    ); */
  }
void _showExitDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
              
            ),
            title: Text('Confirm Exit'),
            content: Text('Are you sure you want to exit?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text('Yes')),
              FlatButton(
                onPressed: () {
                  _dismissDialog();
                },
                child: Text('Cancel'),
              )
            ],
          );
        });
        
 
  }
  _dismissDialog() {
    Navigator.pop(context);
  }

void _showLogOutDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
              
            ),
            title: Text('Confirm Signout'),
            content: Text('You will no longer be signed in. Do you wish to continue?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    signOut();
                    _dismissDialog();
                  },
                  child: Text('Yes')),
              FlatButton(
                onPressed: () {
                  _dismissDialog();
                },
                child: Text('Cancel'),
              )
            ],
          );
        });
        
 
  }
  callToast(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.green[200],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
