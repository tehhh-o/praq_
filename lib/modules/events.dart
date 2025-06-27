class Events {
  final int ID;
  final String Image;
  final String Title;
  final String Description;

  Events({
    required this.ID,
    required this.Image,
    required this.Title,
    required this.Description,
  });

  static Events fromJson(json) => Events(
    ID: json['ID'],
    Image: json['Image'],
    Title: json['Title'],
    Description: json['Description'],
  );
}
