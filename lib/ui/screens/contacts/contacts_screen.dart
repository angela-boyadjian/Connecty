import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';

import 'package:users/models/user.dart';
import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/logic/cubit/cubit.dart';
import 'package:connecty/constants/constants.dart';
import 'package:connecty/ui/widgets/emptiness.dart';

import 'widgets/custom_slidable.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  bool isSliding = false;
  bool showClear = false;
  List<Widget> normalList = [];
  List<Widget> searchResults = [];
  List<String> strList = [];
  List<User> _contacts = [];
  SlidableController slidableController;
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context
        .read<ContactsCubit>()
        .fetchList(context.read<UserBloc>().state.user);
    searchController.addListener(() {
      _createSlidableList();
    });
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
  }

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {}

  handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      isSliding = isOpen;
    });
  }

  Widget _buildAppBar(textTheme) => AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Container(),
        centerTitle: true,
        title: Text('Contacts',
            style: textTheme.headline5.copyWith(color: Colors.white)),
        actions: [
          IconButton(
              icon: Icon(FontAwesomeIcons.plus, color: Colors.white),
              onPressed: () => Navigator.pushNamed(context, settingsRoute)),
        ],
      );

  void handleFabKey() {
    if (fabKey.currentState.isOpen) {
      fabKey.currentState.close();
    }
  }

  _createSlidableList() {
    normalList = [];
    strList = [];

    _contacts.sort((a, b) => a.name.compareTo(b.name));
    _contacts.forEach((user) {
      normalList.add(
        CustomSlidable(
            contact: user,
            key: Key(user.id),
            controller: slidableController,
            handleFabKey: handleFabKey),
      );
      strList.add(user.name);
    });
  }

  void _searchClear() {
    searchController.clear();
    _createSlidableList();
    setState(() {
      searchResults = [];
      showClear = false;
    });
  }

  void onChanged(value) async {
    var tmpContacts = _contacts;
    tmpContacts.retainWhere((item) => (item.name)
        .toLowerCase()
        .contains(searchController.text.toLowerCase()));
    if (value.length > 0) {
      tmpContacts.sort((a, b) => a.name.compareTo(b.name));
      tmpContacts.forEach((user) {
        List<Widget> tmp = [];
        tmp.add(
          CustomSlidable(
              contact: user,
              key: Key(user.id),
              controller: slidableController,
              handleFabKey: handleFabKey),
        );
        setState(() {
          searchResults = tmp;
          showClear = true;
        });
      });
    } else {
      _searchClear();
    }
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: searchController,
        onChanged: onChanged,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.white38),
            ),
            suffixIcon: showClear
                ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.white),
                    onPressed: () => {_searchClear()},
                  )
                : null,
            labelText: "Search",
            labelStyle: TextStyle(color: Theme.of(context).dividerColor)),
      ),
    );
  }

  Widget _contactsList() {
    _createSlidableList();
    return Expanded(
      child: Stack(
        children: <Widget>[
          AlphabetListScrollView(
            strList: strList,
            highlightTextStyle: TextStyle(
              color: Colors.blue,
            ),
            normalTextStyle: TextStyle(color: Theme.of(context).dividerColor),
            showPreview: true,
            itemBuilder: (context, index) {
              return normalList[index];
            },
            indexedHeight: (i) {
              return 80;
            },
            keyboardUsage: true,
            headerWidgetList: <AlphabetScrollListHeader>[
              AlphabetScrollListHeader(widgetList: [
                _searchBar(),
              ], icon: Icon(Icons.search), indexedHeaderHeight: (index) => 80),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContacts() {
    return BlocBuilder<ContactsCubit, ContactsState>(
      builder: (context, state) {
        if (state is ContactsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ContactsError) {
          return Center(child: Text("Contacts failed"));
        } else if (state is ContactsSuccess) {
          _contacts = state.contacts;
          return _contacts.isEmpty
              ? Column(
                  children: [
                    SizedBox(height: 50),
                    Emptiness(tr('emptiness.noContact')),
                  ],
                )
              : _contactsList();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(textTheme),
      body: SafeArea(
        child: Column(
          children: [
            _buildContacts(),
          ],
        ),
      ),
    );
  }
}
