import 'package:flutter/material.dart';
import 'package:quicktalk_replica/Tabs/TabsinaTab/DailyTimeRecord.dart';
import 'package:quicktalk_replica/Tabs/TabsinaTab/MyLogBook.dart';
import 'package:quicktalk_replica/Tabs/TabsinaTab/UserLocation.dart';

class TabsinaTab extends StatefulWidget {
  @override
  _TabsinaTabState createState() => _TabsinaTabState();
}

class _TabsinaTabState extends State<TabsinaTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedTab = [
      UserLocation(),
      DailyTimeRecord(),
      MyLogBook(),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/Images/group_banner.png'),fit: BoxFit.cover),
            ),
            child: TabBar(
              indicatorColor: Colors.purple,
              controller: _tabController,
              tabs: <Tab>[
                Tab(
                  child: Text(
                    'USER\nLOCATION',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
                Tab(
                  child: Text(
                    'DAILY TIME\nRECORD',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
                Tab(
                  child: Text(
                    'MY LOG BOOK',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 12,
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: _selectedTab,
          ),
        ),
      ],
    );
  }
}
