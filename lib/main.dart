import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/ApiProvider.dart';
import 'package:task/profile.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:toast/toast.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiProvider api = new ApiProvider();
  Profile profile;

  bool isPressed = false;
  List imageList = new List();
  String title;
  String category;
  String date;
  String address;
  String trainer;
  String trainerImg;
  String trainerInfo;
  String details;
  int price;
  String dayName;
  String monthName;
  String dayTime;

  Color _getColor(String color) {
    return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
  }

  images() async {
    await getApi();
    List<Widget> image = new List<Widget>();
    for (int i = 0; i < profile.image.length; i++) {
      image.add(Image.network(
        profile.image[i],
        fit: BoxFit.cover,
      ));
    }
    setState(() {
      imageList = image;
    });
  }

  text() async {
    await getApi();

    setState(() {
      category = profile.category;
      title = profile.title;
      date = profile.date;
      address = profile.address;
      trainer = profile.trainer;
      trainerImg = profile.trainerImg;
      trainerInfo = profile.trainerInfo;
      details = profile.details;
      price = profile.price;
    });
  }

  getApi() async {
    profile = await api.getResponse();
  }

  setDate() async {
    await text();
    int year = int.parse(date.substring(0, 4));
    int month = int.parse(date.substring(5, 7));
    int day = int.parse(date.substring(8, 10));
    int dayNo = DateTime(year, month, day).weekday;
    switch (dayNo) {
      case 1:
        setState(() {
          dayName = 'الاثنين';
        });
        break;

      case 2:
        setState(() {
          dayName = 'الثلاثاء';
        });
        break;

      case 3:
        setState(() {
          dayName = 'الاربعاء';
        });
        break;

      case 4:
        setState(() {
          dayName = 'الخميس';
        });
        break;

      case 5:
        setState(() {
          dayName = 'الجمعة';
        });
        break;

      case 6:
        setState(() {
          dayName = 'السبت';
        });
        break;

      case 7:
        setState(() {
          dayName = 'الاحد';
        });
    }

    switch (month) {
      case 1:
        setState(() {
          monthName = 'يناير';
        });
        break;

      case 1:
        setState(() {
          monthName = 'يناير';
        });
        break;

      case 1:
        setState(() {
          monthName = 'يناير';
        });
        break;
      case 1:
        setState(() {
          monthName = 'يناير';
        });
        break;

      case 2:
        setState(() {
          monthName = 'فبراير';
        });
        break;

      case 3:
        setState(() {
          monthName = 'مارس';
        });
        break;

      case 4:
        setState(() {
          monthName = 'ابريل';
        });
        break;

      case 5:
        setState(() {
          monthName = 'مايو';
        });
        break;

      case 6:
        setState(() {
          monthName = 'يونيو';
        });
        break;

      case 7:
        setState(() {
          monthName = 'يوليو';
        });
        break;

      case 8:
        setState(() {
          monthName = 'اغسطس';
        });
        break;

      case 9:
        setState(() {
          monthName = 'سبتمبر';
        });
        break;

      case 10:
        setState(() {
          monthName = 'اكتوبر';
        });
        break;

      case 11:
        setState(() {
          monthName = 'نوفمبر';
        });
        break;
      case 12:
        setState(() {
          monthName = 'ديسمبر';
        });
        break;
    }

    if (int.parse(date.substring(11, 13)) > 12)
      setState(() {
        dayTime = 'مساءا';
      });
    else
      setState(() {
        dayTime = 'صباحا';
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApi();
    images();
    text();
    setDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Container(
                        height: 210,
                        width: double.infinity,
                        child: imageList.isEmpty
                            ? Container()
                            : Carousel(
                                autoplay: false,
                                boxFit: BoxFit.fill,
                                dotPosition: DotPosition.bottomLeft,
                                dotBgColor: Colors.transparent,
                                dotColor: Colors.white.withOpacity(0.7),
                                dotIncreaseSize: 1.5,
                                dotSize: 7,
                                dotSpacing: 15,
                                images: imageList,
                              )),
                  ),
                  Positioned(
                    child: IconButton(
                        icon: Icon(
                          isPressed ? Icons.star : Icons.star_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isPressed = !isPressed;
                          });
                        }),
                    top: 10,
                    left: 10,
                  ),
                  Positioned(
                    child: Image.asset('assets/images/Share Icon.png',height: 20,width: 20,),

                    top: 25,
                    left: 60,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Text(
                        category == null ? '' : category + ' #  ',
                        style: TextStyle(
                            color: _getColor('#e600ac'), fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        title ?? '',
                        style: TextStyle(
                            color: _getColor('#990073'),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child:  Image.asset('assets/images/Date Icon.png',height: 15,width: 15,),
                          ),
                          Container(
                            child: date == null
                                ? Text('')
                                : Text(
                                    dayName +
                                        ', ' +
                                        int.parse(date.substring(8, 10))
                                            .toString() +
                                        ' ' +
                                        monthName +
                                        ', ' +
                                        date.substring(11, 16) +
                                        ' ' +
                                        dayTime,
                                    style: TextStyle(
                                        color: _getColor('#e600ac'),
                                        fontWeight: FontWeight.w500),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 4)),
                          Image.asset('assets/images/Address Icon.png',height: 15,width: 15,),
                          Padding(padding: EdgeInsets.only(right: 4)),
                          address == null
                              ? Container()
                              : Text(address,
                                  style: TextStyle(
                                      color: _getColor('#e600ac'),
                                      fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.8,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          trainerImg == null
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black38,
                                    backgroundImage: NetworkImage(trainerImg),
                                  ),
                                ),
                          Padding(padding: EdgeInsets.only(right: 7)),
                          trainer == null
                              ? Container()
                              : Text(
                                  trainer,
                                  style: TextStyle(
                                      color: _getColor('#cc0099'),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                        ],
                      ),
                    ),
                    trainerInfo == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 20, 0),
                            child: Text(
                              trainerInfo,
                              style: TextStyle(color: _getColor('#e600ac')),
                            ),
                          ),
                    Divider(
                      thickness: 0.8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(
                        'عن الدورة',
                        style: TextStyle(
                            color: _getColor('#cc0099'),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: details == null
                          ? Container()
                          : Text(
                              details,
                              style: TextStyle(
                                color: _getColor('#e600ac'),
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                    ),
                    Divider(
                      thickness: 0.8,
                    ),
                    Text(
                      'تكلفة الدورة',
                      style: TextStyle(
                          color: _getColor('#cc0099'),
                          fontWeight: FontWeight.bold),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 15)),
                          Text(
                            'الحجز العادي',
                            style: TextStyle(color: _getColor('#e600ac')),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20),
                              child: price == null
                                  ? Container()
                                  : Text(price.toString() + ' SAR',
                                      style: TextStyle(
                                          color: _getColor('#e600ac'))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 15)),
                          Text('الحجز المميز',
                              style: TextStyle(color: _getColor('#e600ac'))),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20),
                              child: price == null
                                  ? Container()
                                  : Text(price.toString() + ' SAR',
                                      style: TextStyle(
                                          color: _getColor('#e600ac'))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 15)),
                          Text('الحجز السريع',
                              style: TextStyle(color: _getColor('#e600ac'))),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20),
                              child: price == null
                                  ? Container()
                                  : Text(price.toString() + ' SAR',
                                      style: TextStyle(
                                          color: _getColor('#e600ac'))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Toast.show("تم الحجز بنجاح", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        },
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                  colors: [
                    _getColor('#602060'),
                    _getColor('#993399'),
                  ],
                  stops: [
                    0.0,
                    1.0
                  ])),
          child: Text(
            'قم بالحجز الان',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
