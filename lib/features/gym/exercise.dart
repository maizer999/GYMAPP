enum Difficulty { beginner, intermediate, advanced }

extension DifficultyLabel on Difficulty {
  String get label {
    switch (this) {
      case Difficulty.beginner:
        return 'مبتدئ';
      case Difficulty.intermediate:
        return 'متوسط';
      case Difficulty.advanced:
        return 'متقدم';
    }
  }
}

class Exercise {
  const Exercise({
    required this.id,
    required this.muscleGroup,
    required this.name,
    required this.sets,
    required this.reps,
    required this.benefits,
    required this.imagePath,
    required this.equipment,
    required this.difficulty,
    this.restSeconds = 60,
    this.tips = const [],
    this.secondaryMuscles = const [],
  });

  final String id;
  final String muscleGroup;
  final String name;
  final int sets;
  final String reps;
  final String benefits;
  final String imagePath;
  final String equipment;
  final Difficulty difficulty;
  final int restSeconds;
  final List<String> tips;
  final List<String> secondaryMuscles;

  String get setsRepsLabel => '$sets مجموعات × $reps تكرار';
}

class WorkoutDay {
  const WorkoutDay({
    required this.dayNumber,
    required this.muscleGroup,
    required this.focus,
    required this.exercises,
  });

  final int dayNumber;
  final String muscleGroup;
  final String focus;
  final List<Exercise> exercises;
}
