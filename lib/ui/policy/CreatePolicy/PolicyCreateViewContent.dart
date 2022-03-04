import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';



class PolicyCreateViewFormUI extends StatefulWidget {

  final GlobalKey<FormState>formState;
  final TextEditingController policyNameController;


  const PolicyCreateViewFormUI({Key key, this.formState,this.policyNameController}) : super(key: key);


  @override
  _PolicyCreateViewFormUIState createState() => _PolicyCreateViewFormUIState();
}

class _PolicyCreateViewFormUIState extends State<PolicyCreateViewFormUI> {
  
  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formState,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              controller: widget.policyNameController,
              decoration: InputDecoration(
                labelText: "input policy name here"
              ),
              validator: (value){
                if(value.isEmpty){
                  return "Please enter policy name";
                }
                
                //null - ok!
                return null;
              },
            ),
          )
        ],
      ),

    );
  }
}

class PolicyCreateMemberUI extends StatelessWidget {

  final int members;

  const PolicyCreateMemberUI({Key key, this.members}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        "Members:${this.members}",
      ),
    );
  }
}

class PolicyCreateListUI extends StatelessWidget {

  final List<Contact> contacts;

  const PolicyCreateListUI({Key key, this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: contacts != null 
       ? ListView.builder(
              shrinkWrap: true,
              itemCount: contacts?.length ?? 0,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                Contact contact = contacts?.elementAt(index);
                return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                        subtitle: Text(contact.phones.first.value),
                    leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(contact.avatar),
                          )
                        : CircleAvatar(
                            child: Text(contact.initials()),
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                          ),
                    title: Text(contact.displayName ?? ''),
                  );
              },
            )
          : Center(child: const CircularProgressIndicator()),
    );
  }
}