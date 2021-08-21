import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/constants/constants.dart';
import 'package:connecty/ui/screens/search/search_screen.dart';
import 'package:connecty/ui/screens/profile/profile_screen.dart';
import 'package:connecty/ui/screens/contacts/contacts_screen.dart';
import 'package:connecty/ui/screens/chat_list/chat_list_screen.dart';

import 'nav_bar.dart';

class Frame extends StatefulWidget {
  Frame();

  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<Frame> with SingleTickerProviderStateMixin {
  final double iconSize = 20.0;
  PageController pageController;
  final Color iconColor = Colors.white;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: TabScreens.Home.index,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  navBarChangePage(TabScreens tab) {
    BlocProvider.of<TabBloc>(context).add(TabUpdated(tab));
    pageController.animateToPage(tab.index,
        duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserBloc>().state.user;

    return BlocBuilder<TabBloc, TabScreens>(
      builder: (context, activeTab) {
        return Scaffold(
          key: _scaffoldKey,
          body: PageView(
            children: <Widget>[
              ContactsScreen(),
              BlocProvider.value(
                value: context.read<ChatListBloc>()..add(GetChats(user.chats)),
                child: ChatListScreen(),
              ),
              SearchScreen(),
              ProfileScreen(),
            ],
            controller: pageController,
            onPageChanged: (pageIndex) => BlocProvider.of<TabBloc>(context)
                .add(TabUpdated(TabScreens.values[pageIndex])),
          ),
          bottomNavigationBar: NavBar(
            bottomNavigationKey: _bottomNavigationKey,
            activeTab: activeTab,
            onTabSelected: navBarChangePage,
          ),
        );
      },
    );
  }
}
