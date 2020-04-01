import 'package:bytebank2/database/app_database.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE contacts('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    return _toMap(contact, db);
  }

  Future<int> _toMap(Contact contact, Database db) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return db.insert('contacts', contactMap);

    /*Creation model using 'Then'
      return getDatabase().then((db) {
        final Map<String, dynamic> contactMap = Map();
        contactMap['name'] = contact.name;
       contactMap['account_number'] = contact.accountNumber;
      return db.insert('contacts', contactMap);
      });
     */
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('contacts');
    return _toList(result);
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = List();
    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_id],
        row[_name],
        row[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;

    /*Creation model using 'Then'
      return getDatabase().then((db) {
      return db.query('contacts').then((maps) {
         final List<Contact> contacts = List();
         for (Map<String, dynamic> map in maps) {
         final Contact contact = Contact(
          map['id'],
          map['name'],
          map['account_number'],
          );
        contacts.add(contact);
        }
      return contacts;
       });
       });
      */
  }
}
