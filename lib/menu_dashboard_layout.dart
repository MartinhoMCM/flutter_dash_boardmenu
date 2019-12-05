import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final Color backgroundColor = Color(0xFF4A4A58);

class MenuDashBoardPage extends StatefulWidget {
  @override
  _MenuDashBoardPageState createState() => _MenuDashBoardPageState();
}

class _MenuDashBoardPageState extends State<MenuDashBoardPage>  with SingleTickerProviderStateMixin{
  bool isCollapsed=true;
  double screenWidth, screenHeight;
  TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'maven');
  final Duration duration =Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller =AnimationController(vsync: this, duration: duration);
    _scaleAnimation =Tween<double>(begin:  1, end: 0.6).animate(_controller);
    _menuScaleAnimation=Tween<double>(begin:  -1, end: 1).animate(_controller);
    _slideAnimation =Tween<Offset>(begin: Offset(-1,0), end: Offset(0,0)).animate(_controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size =MediaQuery.of(context).size;
    screenWidth =size.width;
    screenHeight=size.height;

    return  Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context)
        ],
      ),
    );
  }

 Widget  menu(BuildContext context) {



    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text( 'Dashboard', style: textStyle,),
                SizedBox(height: 10,),
                Text('Messages', style:  textStyle,),
                SizedBox(height: 10,),
                Text('Utility Bills', style: textStyle,),
                SizedBox(height: 10,),
                Text('Fund Transfer', style: textStyle,),
                SizedBox(height: 10,),
                Text('Branches', style: textStyle,),

              ],
            ),
          ),

        ),
      ),
    );
 }

  Widget dashboard(BuildContext context) {

    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom:0,
      left:isCollapsed ?0 : 0.6*screenWidth,
      right:isCollapsed ?0 : -0.4*screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                    InkWell(child: Icon(Icons.menu, color: Colors.white,),
                    onTap: (){
                      setState(() {

                        if(isCollapsed)
                          _controller.forward();
                        else _controller.reverse();

                        isCollapsed =!isCollapsed;
                        debugPrint('isCollapsed $isCollapsed');
                      });
                    },),
                    Text('Cards', style: TextStyle( fontSize: 24, color: Colors.white),),
                    Icon(Icons.settings, color: Colors.white,)
                  ],),

                  Container(

                    margin:  EdgeInsets.only(top: 50),
                    height: 200,
                    child: PageView.builder(
                      itemCount: 3,
                        itemBuilder: (context, index)
                    {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        color: setColor(index),
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                              child: Text('Current Balance', style: TextStyle(color: Colors.white, fontSize: 15),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text('12.432.32', style: TextStyle(color: Colors.white, fontSize: 25),),
                            )
                          ],
                        ),
                      );
                    }),
                  ),

                   SizedBox(height: 20,),
                  Text('Transactions', style: textStyle,  ),
                  SizedBox(height: 5,),
                  ListView.separated(
                    shrinkWrap: true,
                      itemBuilder: (context, index)
                      {
                        return ListTile(
                          title: Text('MacBook', style: TextStyle(fontFamily: 'maven'),),
                          subtitle: Text('Apple', style: TextStyle(fontFamily: 'maven')),
                          trailing: Text('-2900', style: TextStyle(fontFamily: 'maven')),
                        );

                      }, separatorBuilder: (context, index)
                      {
                        return Divider(height: 5,);
                      }, itemCount: 10)
                ],
              ),
            ),
          ) ,
        ),
      ),
    );
  }

  Color setColor(int index)
  {
    switch(index)
    {
      case 0: return Colors.redAccent;
      break;
      
      case 1: return Colors.blueAccent;
      break;
      
      default: return Colors.greenAccent;
      break;
    }
  }
}
