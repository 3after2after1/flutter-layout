class ProductDataModel {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? lastSeenTime;
  String? avatar;
  String? status;
  int? messages;

  ProductDataModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.lastSeenTime,
      this.avatar,
      this.status,
      this.messages});

  ProductDataModel.fromJSON(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    username = json["username"];
    lastSeenTime = json["last_seen_time"];
    avatar = json["avatar"];
    status = json["status"];
    messages = json["messages"];
  }
}
