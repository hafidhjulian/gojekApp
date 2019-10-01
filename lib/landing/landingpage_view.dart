import 'package:flutter/material.dart';
import 'package:gojekapp/Akun/akunpage_view.dart';
import 'package:gojekapp/Beranda/berandapage_view.dart';
import 'package:gojekapp/Inbox/inboxpage_view.dart';
import 'package:gojekapp/Pesanan/pesananpage_view.dart';
import 'package:gojekapp/constant.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [
    new BerandaPage(),
    new PesananPage(),
    new InboxPage(),
    new AkunPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _container[_bottomNavCurrentIndex],
      bottomNavigationBar: _builBottomNavigation(),
    );
  }
  Widget _builBottomNavigation(){
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index){
        setState(() {
          _bottomNavCurrentIndex = index;
        });
      },
      currentIndex: _bottomNavCurrentIndex,
      items: [
        BottomNavigationBarItem(
          activeIcon: new Icon(Icons.home, color: GojekPalette.green),
          icon: new Icon(Icons.home, color: Colors.grey),
          title: new Text('Beranda'),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(Icons.assignment, color: GojekPalette.green),
          icon: new Icon(Icons.assignment, color: Colors.grey),
          title: new Text('Pesanan'),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(Icons.mail, color: GojekPalette.green),
          icon: new Icon(Icons.mail, color: Colors.grey),
          title: new Text('Inbox'),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(Icons.person, color: GojekPalette.green),
          icon: new Icon(Icons.person, color: Colors.grey),
          title: new Text('Akun'),
        ),
      ],
    );
  }
}