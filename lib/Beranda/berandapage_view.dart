import 'package:flutter/material.dart';
import 'package:gojekapp/Beranda/beranda_gojek_appbar.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
    child : new Scaffold(
      appBar: GojekAppBar(),
      body: Container(),
      )
    );
  }
}