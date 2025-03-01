class BannersModel {
  String? title;
  String? url;

  BannersModel({
    this.title,
    this.url,
  });

  BannersModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
  }
}
