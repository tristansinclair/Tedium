import 'dart:convert';
import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}

class LocationData {
  double lat, long;
  LocationData(this.lat, this.long);
}

class ActivityData {
  // Displayed Data
  String name;
  String description;
  List<String> images = [];
  int cost;
  double rating;
  LocationData location;

  ActivityData(
      this.name, this.description, this.images, this.cost, this.rating, this.location);


  final String dataPath = "assets/data/activityData.json";
  List<ActivityData> activities;
  

  ActivityData.fromJson(Map<String, dynamic> json)
      : this.name = json['name'],
        this.description = json['description'],
        this.images = json['images'],
        this.cost = json['cost'],
        this.rating = json['rating'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'images': images,
        'cost': cost,
        'rating': rating,
      };
}

String activityDataToJson(ActivityData activity) => 
  json.encode(activity.toJson());
