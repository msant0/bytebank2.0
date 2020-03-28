class Contact {
  final String name;

  Contact(this.name, this.accountNumber);

  final int accountNumber;

  @override
  String toString() {
    return 'Contact{name: $name, accountNumber: $accountNumber}';
  }
}
