class ArticleModel {
  String? uri;
  String? lang;
  bool? isDuplicate;
  String? date;
  String? time;
  String? dateTime;
  String? dateTimePub;
  String? dataType;
  dynamic sim;
  String? url;
  String? title;
  String? body;
  Source? source;
  List<Null>? authors;
  String? image;
  dynamic eventUri;

  ArticleModel({
    this.uri,
    this.lang,
    this.isDuplicate,
    this.date,
    this.time,
    this.dateTime,
    this.dateTimePub,
    this.dataType,
    this.sim,
    this.url,
    this.title,
    this.body,
    this.source,
    this.authors,
    this.image,
    this.eventUri,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    lang = json['lang'];
    isDuplicate = json['isDuplicate'];
    date = json['date'];
    time = json['time'];
    dateTime = json['dateTime'];
    dateTimePub = json['dateTimePub'];
    dataType = json['dataType'];
    sim = json['sim'];
    url = json['url'];
    title = json['title'];
    body = json['body'];
    source = json['source'] != null ? Source.fromJson(json['source']) : null;

    image = json['image'];
    eventUri = json['eventUri'];
  }
}

class Source {
  String? uri;
  String? dataType;
  String? title;
  bool? locationValidated;

  Source({this.uri, this.dataType, this.title, this.locationValidated});

  Source.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    dataType = json['dataType'];
    title = json['title'];
    locationValidated = json['locationValidated'];
  }
}
