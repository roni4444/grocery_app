import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/components/MyBottomNavigationWidget.dart';
import 'package:grocery_app/components/ReusableCategoryCard.dart';

import 'Cart_screen.dart';
import 'Product_details_screen.dart';
import 'Product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> arrival = [];
  List<String> newarr = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection("Shared")
        .doc("Category")
        .collection("Fruits")
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                newarr.add(doc.id);
              })
            })
        .whenComplete(() => setState(() {
              newarr.forEach((element) {
                arrival.add(
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: element),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5.0,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                Image(
                                  image: AssetImage("images/apple.png"),
                                  alignment: Alignment.centerRight,
                                  height: 100.0,
                                  width: 110.0,
                                  fit: BoxFit.scaleDown,
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  element,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text("Rs.20/KG"),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  alignment: Alignment.topRight,
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(
                                  height: 90.0,
                                ),
                                IconButton(
                                    icon: Icon(Icons.chevron_right),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailScreen(
                                                    product: element),
                                          ));
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(5.0),
          children: [
            DrawerHeader(
              child: IconButton(
                icon: Icon(Icons.close),
                alignment: Alignment.centerRight,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              decoration: BoxDecoration(color: Colors.green),
            ),
            ListTile(
              title: Text("Home"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
            ),
            ListTile(
              title: Text("Cart"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
              },
            ),
            ListTile(
              title: Text("Orders"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Log out"),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Grocery App"),
      ),
      bottomNavigationBar: MyBottomNavigationWidget(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: AppBar(
                      toolbarHeight: 50.0,
                      backgroundColor: Colors.white,
                      bottom: TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              'Categories',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'New arrivals',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Budget Friendly',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        CustomScrollView(
                          slivers: <Widget>[
                            SliverPadding(
                              padding: const EdgeInsets.all(0.0),
                              sliver: SliverGrid.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductListScreen(
                                            category: "Fruits",
                                          ),
                                        ),
                                      );
                                    },
                                    child: ReusableCategoryCard(
                                      imagePath: "images/fruits.jpg",
                                      cardText: "Fruits",
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: null,
                                    child: ReusableCategoryCard(
                                      imagePath: "images/vegetables.jpg",
                                      cardText: "Vegetables",
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: null,
                                    child: ReusableCategoryCard(
                                      imagePath: "images/grain.jpg",
                                      cardText: "Grain",
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: null,
                                    child: ReusableCategoryCard(
                                      imagePath: "images/spices.jpg",
                                      cardText: "Spices",
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: null,
                                    child: ReusableCategoryCard(
                                      imagePath: "images/frozenfood.jpg",
                                      cardText: "Frozen Food",
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: null,
                                    child: ReusableCategoryCard(
                                      imagePath: "images/drinks.png",
                                      cardText: "Drinks",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        CustomScrollView(
                          slivers: <Widget>[
                            SliverPadding(
                              padding: const EdgeInsets.all(0.0),
                              sliver: SliverGrid.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                                children: arrival,
                              ),
                            ),
                          ],
                        ),
                        Text('Budget Friendly'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
