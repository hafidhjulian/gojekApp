import 'package:flutter/material.dart';
import 'package:gojekapp/constant.dart';
import 'package:gojekapp/Beranda/beranda_gojek_appbar.dart';
import 'package:gojekapp/Beranda/beranda_model.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  List<GojekService> _gojekServiceList = [];
  List<Food> _goFoodFeaturedList = [];

  @override
  void initState() {
    super.initState();

    _gojekServiceList.add(new GojekService(
        image: Icons.directions_bike,
        color: GojekPalette.menuRide,
        title: "GO-RIDE"));
    _gojekServiceList.add(new GojekService(
        image: Icons.local_car_wash,
        color: GojekPalette.menuCar,
        title: "GO-CAR"));
    _gojekServiceList.add(new GojekService(
        image: Icons.directions_car,
        color: GojekPalette.menuBluebird,
        title: "GO-BLUEBIRD"));
    _gojekServiceList.add(new GojekService(
        image: Icons.restaurant,
        color: GojekPalette.menuFood,
        title: "GO-FOOD"));
    _gojekServiceList.add(new GojekService(
        image: Icons.next_week,
        color: GojekPalette.menuSend,
        title: "GO-SEND"));
    _gojekServiceList.add(new GojekService(
        image: Icons.local_offer,
        color: GojekPalette.menuDeals,
        title: "GO-DEALS"));
    _gojekServiceList.add(new GojekService(
        image: Icons.phonelink_ring,
        color: GojekPalette.menuPulsa,
        title: "GO-PULSA"));
    _gojekServiceList.add(new GojekService(
        image: Icons.apps, color: GojekPalette.menuOther, title: "LAINNYA"));
    _gojekServiceList.add(new GojekService(
        image: Icons.shopping_basket,
        color: GojekPalette.menuShop,
        title: "GO-SHOP"));
    _gojekServiceList.add(new GojekService(
        image: Icons.shopping_cart,
        color: GojekPalette.menuMart,
        title: "GO-MART"));
    _gojekServiceList.add(new GojekService(
        image: Icons.local_play, color: GojekPalette.menuTix, title: "GO-TIX"));

    
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new Scaffold(
      appBar: new GojekAppBar(),
      backgroundColor: GojekPalette.grey,
      body: Container(
        child: new ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  _buildGopayMenu(),
                  _buildGojekServiceMenu(),
                ],
              ),
            ),
            new Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 16.0),
              child: new Column(
                children: <Widget>[
                  _buildGoFoodFeatured(),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget _buildGojekServiceMenu() {
    return new SizedBox(
      width: double.infinity,
      height: 220.0,
      child: new Container(
        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: GridView.builder(
          physics: ClampingScrollPhysics(),
          itemCount: 8,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, position) {
            return _rowGojekService(_gojekServiceList[position]);
          },
        ),
      ),
    );
  }

  Widget _buildGoFoodFeatured() {
    return new Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 0, 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Text("GO-FOOD", style: new TextStyle(fontFamily: "NeoSansBold")),
          new Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          new Text(
            "Pilihan Terlaris",
            style: new TextStyle(fontFamily: "NeoSansBold"),
          ),
          new SizedBox(
            height: 172.0,
            child: FutureBuilder<List>(
              future: fetchFood(),
              builder: (context, snapshot){
                if (snapshot.hasData) {
                  return new ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.only(top: 12.0),
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _rowGoFoodFeatured(snapshot.data[index]);
                    },
                  );
                }
                return Center(
                  child: SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: const CircularProgressIndicator(),
                  ),
                );
              })
          ),
        ],
      ),
    );
  }

  Widget _buildMenuBottomSheet() {
    return new StatefulBuilder(
      builder: (c, s) {
        return new SafeArea(
          child: new Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            width: double.infinity,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(4.0), color: Colors.white),
            child: new Column(
              children: <Widget>[
                new Icon(
                  Icons.drag_handle,
                  color: GojekPalette.grey,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("GO-JEK Services",
                        style: TextStyle(
                            fontFamily: "NeoSansBold", fontSize: 18.0)),
                    new OutlineButton(
                      color: GojekPalette.green,
                      onPressed: () {},
                      child: new Text(
                        "EDIT FAVORITES",
                        style: TextStyle(
                            fontSize: 12.0, color: GojekPalette.green),
                      ),
                    )
                  ],
                ),
                new Container(
                  height: 300.0,
                  child: new GridView.builder(
                    physics: new NeverScrollableScrollPhysics(),
                    itemCount: _gojekServiceList.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (context, position) {
                      return _rowGojekService(_gojekServiceList[position]);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _rowGojekService(GojekService gojekService) {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (context) {
                    return _buildMenuBottomSheet();
                  });
            },
            child: new Container(
              decoration: new BoxDecoration(
                  border: Border.all(color: GojekPalette.grey200, width: 1.0),
                  borderRadius:
                      new BorderRadius.all(new Radius.circular(20.0))),
              padding: EdgeInsets.all(12.0),
              child: new Icon(
                gojekService.image,
                color: gojekService.color,
                size: 32.0,
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 6.0),
          ),
          new Text(gojekService.title, style: new TextStyle(fontSize: 10.0)),
        ],
      ),
    );
  }
}

Future<List<Food>> fetchFood() async {
      List<Food> _goFoodFeaturedList = [];
    _goFoodFeaturedList.add(
        new Food(title: "Steak Andakar", image: "assets/images/food_1.jpg"));
    _goFoodFeaturedList.add(
        new Food(title: "Mie Ayam Tumini", image: "assets/images/food_2.jpg"));
    _goFoodFeaturedList.add(
        new Food(title: "Tengkleng Hohah", image: "assets/images/food_3.jpg"));
    _goFoodFeaturedList.add(
        new Food(title: "Waroeng Steak", image: "assets/images/food_4.jpg"));
    _goFoodFeaturedList.add(new Food(
        title: "Kindai Warung Banjar", image: "assets/images/food_5.jpg"));

    return new Future.delayed(new Duration(seconds: 1),(){
      return _goFoodFeaturedList;
    });
    }

Widget _buildGopayMenu() {
  return new Container(
      height: 130,
      decoration: new BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(10.0))),
      child: new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(12.0),
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
                ),
                borderRadius: new BorderRadius.only(
                    topLeft: new Radius.circular(10.0),
                    topRight: new Radius.circular(10.0))),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("GOPAY",
                    style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontFamily: "NeoSansBold")),
                new Container(
                  child: new Text("Rp. 120.000",
                      style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: "NeoSansBold")),
                )
              ],
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 12.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(
                      "assets/icons/icon_transfer.png",
                      width: 32.0,
                      height: 32.0,
                    ),
                    new Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    new Text(
                      "Transfer",
                      style: new TextStyle(color: Colors.white, fontSize: 12.0),
                    )
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(
                      "assets/icons/icon_scan.png",
                      width: 32.0,
                      height: 32.0,
                    ),
                    new Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    new Text(
                      "Scan QR",
                      style: new TextStyle(color: Colors.white, fontSize: 12.0),
                    )
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(
                      "assets/icons/icon_saldo.png",
                      width: 32.0,
                      height: 32.0,
                    ),
                    new Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    new Text(
                      "Isi Saldo",
                      style: new TextStyle(color: Colors.white, fontSize: 12.0),
                    )
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(
                      "assets/icons/icon_menu.png",
                      width: 32.0,
                      height: 32.0,
                    ),
                    new Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    new Text(
                      "Lainnya",
                      style: new TextStyle(color: Colors.white, fontSize: 12.0),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ));
}

Widget _rowGoFoodFeatured(Food food) {
  return new Container(
    margin: EdgeInsets.only(right: 16.0),
    child: new Column(
      children: <Widget>[
        new ClipRRect(
          borderRadius: new BorderRadius.circular(8.0),
          child: new Image.asset(
            food.image,
            width: 132.0,
            height: 132.0,
          ),
        ),
        new Padding(
          padding: EdgeInsets.only(top: 8.0),
        ),
        new Text(food.title)
      ],
    ),
  );
}

// Widget _buildGojekServiceMenu() {
//   return new SizedBox(
//     width: double.infinity,
//     height: 220.0,
//     child: new Container(
//       margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
//       child: GridView.builder(
//         physics: ClampingScrollPhysics(),
//         itemCount: 8,
//         gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4,
//         ),
//         itemBuilder: (context, position){
//           return _rowGojekService(_gojekServiceList[position]);
//         },
//       ),
//     ),
//   );
// }
