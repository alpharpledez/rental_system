import 'package:cabin/base/order.dart';
import 'package:cabin/base/support_request.dart';
import 'package:cabin/base/user.dart';
import 'package:cabin/widget/cabin_data_table.dart';
import 'package:cabin/widget/cabin_nav_bar.dart';
import 'package:cabin/widget/cabin_scaffold.dart';
import 'package:flutter/material.dart';

class AdminSupportRequestListPage extends StatefulWidget {
  createState() => AdminSupportRequestListPageState();
}

class AdminSupportRequestListPageState extends State<AdminSupportRequestListPage> {
  bool dataReady = false;
  List<SupportRequest> allorders;

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return CabinScaffold(
      navBar: CabinNavBar(),
      adaptivePage: false,
      body: dataReady
          ?allorders.length == 0?Container(padding:EdgeInsets.only(top:100), alignment: Alignment.center, child:Text("暂无工单",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold))) :Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 60),
              child: CabinDataTable(items: allorders,userType: UserType.service,refresh: (){getList();}))
          : Center(
              child: Container(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            )),
    );
  }

  Future getList() async {
    allorders = await SupportRequestProvider.instance.getall();
    if (allorders != null){dataReady = true; print(allorders.length);};
    setState(() {});
  }
}
