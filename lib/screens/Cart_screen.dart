import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/components/MyBottomNavigationWidget.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> _list = [];
  List<String> _plist = [];
  List<Widget> cartlist = [];
  List<Widget> pricelist = [];

  @override
  void initState() {
    super.initState();
    getCart();
    getPrice();
  }

  Future getCart() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection("Users")
        .doc("User1")
        .collection("Cart")
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                _list.add(doc["Product"]);
              })
            })
        .whenComplete(() => setState(() {
              _list.forEach((element) {
                cartlist.add(Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 80, 5),
                      child: Card(
                        elevation: 10.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 130.0,
                              width: 130.0,
                              child: Image.asset("images/apple.png"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(element),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text("20/KG"),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.add_circle),
                                    onPressed: null),
                                IconButton(
                                    icon: Icon(Icons.remove_circle),
                                    onPressed: null),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ));
              });
            }));
  }

  Future getPrice() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection("Users")
        .doc("User1")
        .collection("Cart")
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                _plist.add(doc["Price"]);
              })
            })
        .whenComplete(() => setState(() {
              _plist.forEach((el) {
                pricelist.add(Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Text(
                        el,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 70.0,
                    ),
                    Icon(Icons.add),
                  ],
                ));
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        leading: Icon(Icons.arrow_back),
        actions: [Icon(Icons.notifications)],
      ),
      bottomNavigationBar: MyBottomNavigationWidget(),
      body: SafeArea(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: cartlist,
              ),
              Column(
                children: pricelist,
              )
            ],
          ),
        ),
      ),
    );
  }
}
