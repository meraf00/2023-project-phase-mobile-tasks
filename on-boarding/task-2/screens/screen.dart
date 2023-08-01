abstract class Screen {
  final List<String> options;

  Screen(this.options);

  displayOptions() {
    for (final (index, option) in options.indexed) {
      print("${index + 1}. $option");
    }
  }

  Screen handleInput(int option);
}
