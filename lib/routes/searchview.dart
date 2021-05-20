import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sinapps/models/searchResult.dart';
import 'package:sinapps/models/searchResultCard.dart';
import 'package:sinapps/utils/colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

List<SearchResult> peopleResult = [
  SearchResult(identifier: "Mert Ture", description: "Orthopedics at Acıbadem"),
  SearchResult(identifier: "Kaan Atmaca", description: "Doctor at Acıbadem")
];

List<SearchResult> locationResult = [
  SearchResult(identifier: "Acıbadem", description: "a uniiversity hospital"),
  SearchResult(identifier: "Koç Uni", description: "University in Turkey")
];

List<SearchResult> topicResult = [
  SearchResult(identifier: "Nobet", description: "doktorların tuttuğu şey"),
  SearchResult(identifier: "asdasdas", description: "sadasdasdasdasdasdas")
];

class _SearchPageState extends State<SearchPage> {
  static const historyLength = 5;
  List<String> _searchHistory = [
    'sample1',
    'search2',
    'hello world',
    'sucourse'
  ];

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
    // We dont neeed to duplicate it
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
    // We are displaying this variable in screen and
    // we need to be sure it is filtered from scratch
    controller = FloatingSearchBarController();
    filteredSearchHistory = filteredSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
            setState(() {
              addSearchTerm(query);
              selectedTerm = query;
            });
            controller.close();
          },
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                elevation: 4,
                child: Builder(builder: (context) {
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
            children: peopleResult
                .map((element) => SearchResultCard(
                      sr: element,
                    ))
                .toList(),
          ),
          Container(
            child: Text(
              'Location',
              style: TextStyle(
                fontFamily: 'BrandonText',
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
          ),
          Divider(),
          Column(
            children: locationResult
                .map((element) => SearchResultCard(
                      sr: element,
                    ))
                .toList(),
          ),
          Container(
            child: Text(
              'Topic',
              style: TextStyle(
                fontFamily: 'BrandonText',
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
          ),
          Divider(),
          Column(
            children: locationResult
                .map((element) => SearchResultCard(
                      sr: element,
                    ))
                .toList(),
          ),
        ]);
  }
}
