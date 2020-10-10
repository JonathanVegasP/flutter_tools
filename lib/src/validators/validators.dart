extension NullX on Null {
  bool get isNull => true;

  bool get isNotNull => false;
}

extension ValidatorsX<T> on T {
  bool get isNull => this == null;

  bool get isNotNull => !this.isNull;
}

extension StringX on String {
  bool get isNull => this == null || this.isEmpty;

  bool get isNotNull => !this.isNull;

  bool get isFullName => this.split(' ').length > 1;

  bool get isEmail {
    final pattern =
        r'^[\w-_]+(\.[\w-_]+)*@[a-z0-9]{2,}(\.[a-z]{2,6})*(\.[a-z]{2,6})$';
    return RegExp(pattern).hasMatch(this);
  }

  bool minLength(int length) => this.length >= length;

  bool maxLength(int length) => this.length <= length;
}
