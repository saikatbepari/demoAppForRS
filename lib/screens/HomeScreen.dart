import 'package:exercise_app/screens/PhotosList.dart';
import 'package:exercise_app/screens/VideoList.dart';
import 'package:exercise_app/widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  TabController tabController;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
              child: Container(
                color: Color(0xFFf5f6f7),
              ),
            ),
            PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: TabBar(
                controller: tabController,
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Photos',
                  ),
                  Tab(
                    text: 'Videos',
                  ),
                ], // list of tabs
              ),
            ),
            SizedBox(
              height: 10,
              child: Container(
                color: Color(0xFFf5f6f7),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  Container(
                    color: Colors.white24,
                    child: PhotosList(slug: 'curated'),
                  ),
                  Container(
                    color: Colors.white24,
                    child: VideoList(slug: 'videos/popular'),
                  ),
                  // class name
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
