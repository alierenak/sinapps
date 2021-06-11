import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinapps/models/searchResult.dart';
import 'package:sinapps/models/searchResultCard.dart';
import 'package:sinapps/models/user.dart';

List<SearchResult> userResults = [];
List<SearchResult> postResults = [];

class SearchPage extends StatefulWidget {

  const SearchPage({Key key, this.currentUser}) : super(key: key);
  final user currentUser;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const historyLength = 5;
  var results = [];
  List<String> _searchHistory = [];
  SharedPreferences prefs;

  List<String> filteredSearchHistory;

  // Number of term
  String selectedTerm;

  List<String> filteredSearchTerms({
    @required String filter,
  }) {

    // Filtering among search history to make search easy
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((element) => element.startsWith(filter))
          .toList();
    } else {
      // if nothing written we can return all search history
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String element) {
    // What we want to do is if the added search term is already exist
    // We dont need to duplicate it
    if (_searchHistory.contains(element)) {
      putSearchTermFirst(element);
      return;
    } else {
      // if element is not exist
      // you may add normally
      _searchHistory.add(element);
      if (_searchHistory.length > historyLength) {
        // remove oldest search until length is proper to add new one
        _searchHistory.removeRange(0, _searchHistory.length - historyLength);
      }
      filteredSearchHistory = filteredSearchTerms(filter: null);
    }
    prefs.setStringList("search_history", _searchHistory);
  }

  void deleteSearchTerm(String element) {
    _searchHistory.removeWhere((willDelete) => willDelete == element);
    filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  void putSearchTermFirst(element) {
    // if element is already exist will be deleted
    deleteSearchTerm(element);

    // add to the first
    addSearchTerm(element);
  }

  FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    loadSearchHistory();
    // We are displaying this variable in screen and
    // we need to be sure it is filtered from scratch
    controller = FloatingSearchBarController();
  }

  void loadSearchHistory() async {
    prefs = await SharedPreferences.getInstance();
    var _sh = prefs.getStringList("search_history");
    if (_sh == null) {
      prefs.setStringList("search_history", []);
    } else {
      // safe to get
      _searchHistory = _sh;
    }
  }

  void saveHistory() {
    prefs.setStringList("search_history", _searchHistory);
  }

  @override
  void dispose() {
    saveHistory();
    controller.dispose();
    super.dispose();
  }

  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  void checkIfExist(String src) {
    bool ch = false;
    for (int i = 0; i < results.length; i++) {
      if (src == results[i].identifier ||
          src == results[i].description) ch = true;
    }
    if (ch == false) {
      crashlytics.setCustomKey("search result not found:", src);
    }
  }

  void getSearchResults(query) async {

    var users = await FirebaseFirestore.instance
        .collection("users")
        .where('username', isGreaterThanOrEqualTo: query,

      isLessThan: query.substring(0, query.length - 1) +
          String.fromCharCode(query.codeUnitAt(query.length - 1) + 1),

    )
        .get();
    //.where('activation', isEqualTo: "active")
    users.docs.forEach((doc) => {
      if (doc['activation'] == "active") {
        userResults.add(
            SearchResult(identifier: doc['username'],
                description: doc['description'],
                itemID: doc['uid'],
                photoUrl: doc['photoUrl'])

        )
      }
    });

    var posts = await FirebaseFirestore.instance
        .collection("posts")
        .where('title', isGreaterThanOrEqualTo: query,
      isLessThan: query.substring(0, query.length - 1) +
          String.fromCharCode(query.codeUnitAt(query.length - 1) + 1),
    )

        .get();
    //.where('activation', isEqualTo: "active")
    posts.docs.forEach((doc) => {
      if (doc["activation"] == "active") {
        postResults.add(
            SearchResult(identifier: doc['title'],
                description: doc['content'],
                itemID: doc['pid'],
                photoUrl: doc['postPhotoURL'])
        )
      }
    });

    setState(() {
      selectedTerm = query;
      results = userResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[800],
          elevation: 0.0,
          title: Text(
            'Search',
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 24,
              fontFamily: 'BrandonText',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: FloatingSearchBar(
          automaticallyImplyBackButton: false,
          controller: controller,
          body: FloatingSearchBarScrollNotifier(
            child: SearchResultsListView(
              searchTerm: selectedTerm,
            ),
          ),
          // When we close process will be more nice (
          transition: CircularFloatingSearchBarTransition(),
          // search terms shows up in cool way :)
          physics: BouncingScrollPhysics(),
          title: Text(
            selectedTerm ?? 'Enter to search',
            style: Theme.of(context).textTheme.headline6,
          ),
          hint: 'Start typing...',
          actions: [
            FloatingSearchBarAction.searchToClear(),
          ],
          onQueryChanged: (query) {
            setState(() {
              filteredSearchHistory = filteredSearchTerms(filter: query);
            });
          },
          onSubmitted: (query) {
            userResults = [];
            postResults = [];
            checkIfExist(query);
            getSearchResults(query);
            addSearchTerm(query);
            controller.close();
          },
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                elevation: 4,
                child: Builder(builder: (context) {
                  filteredSearchHistory = filteredSearchTerms(filter: null);
                  if (filteredSearchHistory.isEmpty &&
                      controller.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'No history exist. Start to explore :)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (filteredSearchHistory.isEmpty) {
                    // search history not found but user typing something
                    return ListTile(
                      title: Text(controller.query),
                      leading: const Icon(Icons.search),
                      // for each type we need to add characters to history which is writing...
                      onTap: () {
                        setState(() {
                          addSearchTerm(controller.query);
                          selectedTerm = controller.query;
                        });
                        controller.close();
                      },
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map((e) => ListTile(
                        title: Text(
                          e,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: const Icon(Icons.history),
                        trailing: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              deleteSearchTerm(e);
                            });
                          },
                        ),
                        onTap: () {
                          setState(() {
                            putSearchTermFirst(e);
                            selectedTerm = e;
                          });
                          controller.close();
                        },
                      ))
                          .toList(),
                    );
                  }
                }),
              ),
            );
          },
        ));
  }
}

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  Widget buildSearchResults(
      List<SearchResult> results, BuildContext context, int index) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text(""),
              subtitle: Text(""),
            ),
          ],
        ),
      ),
    );
  }

  const SearchResultsListView({
    Key key,
    @required this.searchTerm,
  }) : super(key: key);

  noResultsFound(context) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
                "No results found!"
            ),
          ),
          Container(
            width: double.infinity,
          )
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Explore Sinappses!',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);
    return ListView(
        padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              'People',
              style: TextStyle(
                fontFamily: 'BrandonText',
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(),
          Column(
            children: (userResults == null || userResults.isEmpty) ? noResultsFound(context) : userResults
                .map((element) => SearchResultCard(
                      sr: element, itType: "user",
                    )).toList(),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              'Posts',
              style: TextStyle(
                fontFamily: 'BrandonText',
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(),
          Column(
            children: (postResults == null || postResults.isEmpty) ? noResultsFound(context) : postResults
                .map((element) => SearchResultCard(
              sr: element, itType: "post",
            )).toList(),
          ),
        ]);
  }
}