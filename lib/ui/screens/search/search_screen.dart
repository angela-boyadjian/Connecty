import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:users/users_repository.dart';

import 'widgets/result_card.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<User> searchResults = [];
  TextEditingController searchController = TextEditingController();
  bool showClear = false;

  void searchClear() {
    searchController.clear();
    setState(() {
      searchResults = [];
      showClear = false;
    });
  }

  void onChanged(value) async {
    var res = await context.read<UsersRepository>().searchByName(value);

    if (value.length > 0) {
      setState(() {
        searchResults = res;
        showClear = true;
      });
    } else {
      searchController.clear();
      setState(() {
        showClear = false;
        searchResults = [];
      });
    }
  }

  noResult() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Connecty,', style: Theme.of(context).textTheme.headline4),
          AutoSizeText(
            tr('search.Title'),
            // textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.w900),
            maxLines: 2,
          ),
        ],
      ),
    );
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
          searchResults.isEmpty
              ? noResult()
              : GridView.count(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  primary: false,
                  shrinkWrap: true,
                  children: searchResults.map((element) {
                    return ResultCard(user: element);
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
