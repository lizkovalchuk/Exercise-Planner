class BucketModel {
  final String exerciseId;
  final String exerciseName;
  BucketModel(this.exerciseId, this.exerciseName);

  Map<String, String> toJson() {
    return {"exercise_id": this.exerciseId, "exercise_name": this.exerciseName};
  }
}
