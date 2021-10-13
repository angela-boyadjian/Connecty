import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:users/users_repository.dart';

import 'widgets/result_card.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<User> queryResultSet = [];
  TextEditingController searchController = TextEditingController();
  bool showClear = false;

  void searchClear() {
    searchController.clear();
    setState(() {
      queryResultSet = [];
      showClear = false;
    });
  }

  void search(String toSearch) async {
    var res = await context.read<UsersRepository>().searchByName(toSearch);
    setState(() {
      queryResultSet = res;
    });
  }

  void onChanged(value) {
    if (value.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: searchController,
              onChanged: onChanged,
              style: theme.textTheme.subtitle1,
              onFieldSubmitted: search,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_pin,
                  size: 30.0,
                ),
                suffixIcon: showClear
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.white),
                        onPressed: () => {searchClear()},
                      )
                    : null,
                contentPadding: EdgeInsets.only(left: 25.0),
                hintText: 'Search by name...',
                hintStyle: theme.textTheme.subtitle1,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          GridView.count(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            primary: false,
            shrinkWrap: true,
            children: queryResultSet.map((element) {
              return ResultCard(element);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
