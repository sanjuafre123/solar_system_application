class PlanetsModel {
  String position, name, image, velocity, distance, description, color, img;
  bool like;

  PlanetsModel(
      {required this.like,
        required this.position,
        required this.name,
        required this.image,
        required this.velocity,
        required this.distance,
        required this.description,
        required this.color,
        required this.img});

  factory PlanetsModel.fromJson(Map json) {
    return PlanetsModel(
      like: json['like'],
      position: json['position'],
      color: json['color'],
      name: json['name'],
      image: json['image'],
      velocity: json['velocity'],
      distance: json['distance'],
      description: json['description'],
      img: json['img'],
    );
  }
}