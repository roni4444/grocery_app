import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/components/MyBottomNavigationWidget.dart';

class ProductListScreen extends StatefulWidget {
  final String category;
  ProductListScreen({this.category});

  @override
  _ProductListScreenState createState() => _ProductListScreenState(category);
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Widget> arrival = [];
  List<String> newarr = [];
  String cat;

  _ProductListScreenState(String category) {
    cat = category;
  }

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
        .collection(cat)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                newarr.add(doc.id);
                print(doc.id);
              })
            })
        .whenComplete(() => setState(() {
              newarr.forEach((element) {
                arrival.add(
                  FlatButton(
                    onPressed: null,
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
                                  height: 80.0,
                                  width: 90.0,
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
                                  onPressed: null,
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
                                    onPressed: null)
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
      appBar: AppBar(
        title: Text("Grocery"),
      ),
      bottomNavigationBar: MyBottomNavigationWidget(),
      body: SafeArea(
        child: Container(
          child: DefaultTabController(
            length: 1,
            child: Scaffold(
              body: TabBarView(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.all(0.0),
                        sliver: SliverGrid.count(
                          crossAxisCount: getCount(),
                          children: arrival,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int getCount() {
    if (arrival.length == 0) {
      setState(() {
        return 2;
      });
    } else {
      return 2;
    }
  }
}
