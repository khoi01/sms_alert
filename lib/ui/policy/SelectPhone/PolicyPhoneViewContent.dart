import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:sms_alert/utils/contacts.dart';

class PolicyPhoneViewContentUI extends StatefulWidget {

   final List<Contact> selectedContacts;


  PolicyPhoneViewContentUI({Key key,this.selectedContacts}) : super(key: key);

  @override
  _PolicyPhoneViewContentUIState createState() => _PolicyPhoneViewContentUIState();
}

class _PolicyPhoneViewContentUIState extends State<PolicyPhoneViewContentUI> {
  
    List<Contact> _contacts;
    List<bool> _selected = List.generate(20, (i) => false); // initially fill it up with false


  @override
    void initState() {
      getContacts();
      super.initState();
    
    }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: _contacts != null 
       ? ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: _contacts?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Contact contact = _contacts?.elementAt(index);
                return Container(
                  color: _selected[index] ? Colors.green:null,
                                  child: ListTile(subtitle: Text(contact.phones.first.value),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                    leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(contact.avatar),
                          )
                        : CircleAvatar(
                            child: Text(contact.initials()),
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                    title: Text(contact.displayName ?? ''),
                    //This can be further expanded to showing contacts detail
                    // onPressed().
                    onTap: (){
                      _selected[index] = !_selected[index];
                      //add contact/remove
                      _selected[index] ? widget.selectedContacts.add(contact) : widget.selectedContacts.remove(contact); 
                    
                      refresh();
                    },
                  ),
                );
              },
            )
          : Center(child: const CircularProgressIndicator()),
    );
  }

  
  void getContacts()  {

      ContactInfo.getContacts().then((contacts){        
        _contacts = contacts;
        refresh();
    });  
  }

    void refresh(){
    setState(() {
      
    });
  }
}