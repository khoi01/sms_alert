import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ComponentSearchBarLocation extends StatefulWidget
    implements PreferredSizeWidget {
  final String title; //title
  final Color backgroundColor; // theme color by color admin,tech,user
  final Function onCallbackFilteredItem; //sendback filtered data
  final List<Contact>? contacts; // all data

  ComponentSearchBarLocation({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.onCallbackFilteredItem,
    this.contacts,
  }) : super(key: key);

  @override
  _ComponentSearchBarLocationState createState() =>
      _ComponentSearchBarLocationState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ComponentSearchBarLocationState
    extends State<ComponentSearchBarLocation> {
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Add New Member ');
  final TextEditingController _filter = new TextEditingController();
  List<Contact>? _filteredContacts;
  String _searchText = "";

  _ComponentSearchBarLocationState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _filteredContacts = widget.contacts;

          //callback
          widget.onCallbackFilteredItem(_filteredContacts);
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          buildFilteredItems();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new AppBar(
        /*  backgroundColor: widget.backgroundColor,*/
        centerTitle: true,
        title: _appBarTitle,
        actions: [
          new IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed,
          )
        ]);
  }

  void buildFilteredItems() {
    if (_searchText.isNotEmpty && _searchText.length > 1) {
      _filteredContacts = [];

      for (Contact contact in widget.contacts ?? []) {
        if (contact.displayName!
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _filteredContacts?.add(contact);
        }
      }

      widget.onCallbackFilteredItem(_filteredContacts);
    }
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          style: TextStyle(color: Colors.white),
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Members..');
        _filter.clear();
      }
    });
  }
}
