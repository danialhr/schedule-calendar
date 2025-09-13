class EventModel {
  String id;
  String imageUrl;
  String title;
  String description;
  String type;
  String sessionType;
  int durationInMinutes;
  List<String> coachId;
  List<int> idFromCoachId;

  EventModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.type,
    required this.sessionType,
    required this.durationInMinutes,
    required this.coachId,
    required this.idFromCoachId,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        imageUrl: json["fields"]["imageUrl"],
        title: json["fields"]["title"],
        description: json["fields"]["description"],
        type: json["fields"]["type"],
        sessionType: json["fields"]["sessionType"],
        durationInMinutes: json["fields"]["durationByMinutes"],
        coachId: List<String>.from(json["fields"]["coachId"].map((coachId) => coachId)),
        idFromCoachId: List<int>.from(json["fields"]["id (from CoachId)"].map((id) => id)),
      );
}
