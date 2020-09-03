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

class ActivityData {
  // Displayed Data
  String name;
  String description;
  List<String> images = [];
  int cost;
  double rating;

  ActivityData(
      this.name, this.description, this.images, this.cost, this.rating);


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


// Creates an activity
ActivityData createActivity(String activityName, String description,
    List<String> images, int cost, double rating) {
  var activity = ActivityData(activityName, description, images, cost, rating);
  var test = activityDataToJson(activity);
  print(test);

  return activity;
}
