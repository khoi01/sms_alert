import 'package:contacts_service/contacts_service.dart';


class ContactInfo{


  static Future<List<Contact>> getContacts() async{
    //We already have permissions for contact when we get to this page, so we
    // are now just retrieving it
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    final List<Contact> modifiedContact = new List<Contact>();

    Contact con;

    contacts.forEach((contact) { 
        
        contact.phones.forEach((phone) {
          con = new Contact(
            displayName: contact.displayName,
            givenName:  contact.givenName,
            middleName: contact.middleName,
            prefix: contact.prefix,
            suffix: contact.suffix,
            familyName: contact.familyName,
            company:  contact.company,
            jobTitle: contact.jobTitle,
            emails: contact.emails,
            phones: [phone],
            postalAddresses: contact.postalAddresses,
            avatar: contact.avatar,
            birthday: contact.birthday,
            androidAccountType: contact.androidAccountType,
            androidAccountTypeRaw: contact.androidAccountTypeRaw,
            androidAccountName: contact.androidAccountName
          );
          
          modifiedContact.add(con);
        });

    });


    modifiedContact.forEach((con) {
         print(con.displayName+":"+con.phones.first.label);
     }); 

     return modifiedContact;
  }

}