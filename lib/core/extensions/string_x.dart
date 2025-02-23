extension StringX on String {
  bool containsWithLowerCase(final String value) =>
      toLowerCase().contains(value.toLowerCase());

  bool equalsWithLowerCase(final String value) =>
      toLowerCase() == value.toLowerCase();

  bool startsWithLowerCase(final String value) =>
      toLowerCase().startsWith(value.toLowerCase());

  String toSentenceCase() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String toCamelCase() => split(' ')
      .map((final word) => word.toSentenceCase())
      .join(' ');

  String? get notEmptyValueOrNull => isNotEmpty ? this : null;
}

extension StringNullX on String? {
  bool get isNotNullOrEmpty => this?.isNotEmpty ?? false;

  bool get isNullOrEmpty => this == null || this!.isEmpty;
}