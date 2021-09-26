import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_with_us_test/pages/lists/lists_top_page.dart';
import 'package:study_with_us_test/pages/measure_study/measure_top_page.dart';
import 'package:study_with_us_test/pages/study_rooms/study_rooms_top_page.dart';
import 'package:study_with_us_test/pages/user_profile/user_profile_top_page.dart';

class RootPracticeWidget extends StatefulWidget {
  final int num;

  RootPracticeWidget(this.num);

  @override
  _RootPracticeWidgetState createState() => _RootPracticeWidgetState();
}

class _RootPracticeWidgetState extends State<RootPracticeWidget> {
  int _selectedIndex = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

  static const _footerIcons = [
    Icons.home,
    Icons.groups,
    Icons.watch_later,
    Icons.format_list_bulleted,
  ];

  static const _footerItemNames = [
    'ホーム',
    '勉強部屋',
    'タイマー',
    '目標',
  ];

  // === 追加部分 ===
  var _routes = [
    UserProfile(),
    StudyRooms(),
    TimerPage(),
    ListTopPage(),
  ];
  // ==============

  @override
  void initState() {
    super.initState();
    _bottomNavigationBarItems.add(_UpdateActiveState(0));
    for (var i = 1; i < _footerItemNames.length; i++) {
      _bottomNavigationBarItems.add(_UpdateDeactiveState(i));
    }

    _selectedIndex = widget.num;
  }

  /// インデックスのアイテムをアクティベートする
  BottomNavigationBarItem _UpdateActiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.lightBlueAccent,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.lightBlueAccent,
          ),
        )
    );
  }

  BottomNavigationBarItem _UpdateDeactiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black26,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black26,
          ),
        )
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavigationBarItems[_selectedIndex] =
          _UpdateDeactiveState(_selectedIndex);
      _bottomNavigationBarItems[index] = _UpdateActiveState(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // これを書かないと3つまでしか表示されない
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}