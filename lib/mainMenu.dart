import 'dart:io';
import 'package:agro/constants/constant.dart';
import 'package:agro/models/cartmodel.dart';
import 'package:agro/monitoring_part.dart/home.dart';
import 'package:agro/pages/aboutpage.dart';
import 'package:agro/screens/notification_screen.dart';
import 'package:agro/screens/home_menu.dart';
import 'package:agro/screens/order_screen.dart';
import 'package:agro/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:line_icons/line_icons.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;

  MainMenu(this.signOut);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String email = "", name = "", id = "", userid;
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

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
    ScopedModel.of<CartModel>(context).setUser(preferences.getString("email"));
    ScopedModel.of<CartModel>(context).setid(preferences.getString("id"));
    print(ScopedModel.of<CartModel>(context, rebuildOnChange: false).useremail);
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  int bottomSelectedIndex = 0;
  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomeMenu(),
        Database(),
        NotificationScreen(),
        ProfilePage(),
      ],
    );
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('NepaFarm'),
        ),
        body: buildPageView(),
        drawer: Drawer(
          elevation: 0,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/drawer.jpg'),
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
                title: Text('Talk to Expert', style: kTileTitleStyle),
                dense: true,
                leading: Icon(
                  LineIcons.question_circle,
                  color: iconColor,
                ),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.of(context).pushNamed('/query');
                },
              ),
              GreenDivider(),
              ListTile(
                  dense: true,
                  title: Text('Answers', style: kTileTitleStyle),
                  leading: Icon(
                    LineIcons.angellist,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/answer');
                  }),
              GreenDivider(),
              ListTile(
                  dense: true,
                  title: Text('View Products', style: kTileTitleStyle),
                  leading: Icon(
                    LineIcons.pagelines,
                    color: iconColor,
                  ),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pushNamed('/order');
                    ScopedModel.of<CartModel>(context).setUser(("$email"));
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
                    Navigator.pushNamed(context, '/news');
                  }),
              GreenDivider(),
              ListTile(
                  dense: true,
                  title: Text('Monitoring', style: kTileTitleStyle),
                  leading: Icon(LineIcons.calendar, color: iconColor),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }),
              GreenDivider(),
              ListTile(
                  dense: true,
                  title: Text('About Us', style: kTileTitleStyle),
                  leading: Icon(LineIcons.female, color: iconColor),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pageController.animateToPage(2,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
          child: Icon(LineIcons.bell),
          backgroundColor: Colors.orange,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BubbleBottomBar(
          opacity: .2,
          currentIndex: bottomSelectedIndex,
          onTap: (index) {
            pageChanged(index);
            bottomTapped(index);
          },
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          elevation: 8,
          fabLocation: BubbleBottomBarFabLocation.end, //new
          hasNotch: true, //new
          hasInk: true, //new, gives a cute ink effect
          inkColor:
              Colors.black12, //optional, uses theme color if not specified
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.dashboard,
                  color: Colors.red,
                ),
                title: Text("Home")),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.shopping_cart,
                  color: Colors.deepPurple,
                ),
                title: Text("Orders")),
            BubbleBottomBarItem(
                backgroundColor: Colors.indigo,
                icon: Icon(
                  LineIcons.bell,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  LineIcons.bell,
                  color: Colors.indigo,
                ),
                title: Text("Notifications")),
            BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                LineIcons.user,
                color: Colors.black,
              ),
              activeIcon: Icon(
                LineIcons.user,
                color: Colors.green,
              ),
              title: Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text('Confirm Signout'),
            content: Text(
                'You will no longer be signed in. Do you wish to continue?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  signOut();
                  _dismissDialog();
                },
                child: Text('Yes'),
              ),
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
