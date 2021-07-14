import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    required this.titlename,
    required this.createPage, this.act=false,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final String titlename;
  final Widget Function() createPage;
  bool act = false;
  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() =>
      _CustomAppBarState(titlename, createPage, act);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final String titlename;
  final Widget Function() createPage;
  bool act = false;
  _CustomAppBarState(this.titlename, this.createPage, this.act);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          titlename,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 5.0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => createPage()));
          },
          child: Container(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        actions: act== true ?  <Widget>[
          GestureDetector(
            onTap: () {},
            child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                )),
          )
        ]:null 
        );
  }
}
