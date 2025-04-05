class SupportedCode {
  final String code;
  final String name;

  SupportedCode({required this.code, required this.name});

  factory SupportedCode.fromJson(List<dynamic> json) {
    return SupportedCode(code: json[0], name: json[1]);
  }
}
