//formula
double calcBMI(double height,double weight) {
  return 0;
}

//User
class User {
  String id;
  String username;
  String email;
  String name;
  String gender;
  String birthdate;
  Stats stats;
  Goals goals;
  List<Log> log;
  String currWorkout;
  String currDiet;

  User(
      {this.id,
      this.username,
      this.email,
      this.name,
      this.gender,
      this.birthdate,
      this.stats,
      this.goals,
      this.log,
      this.currWorkout,
      this.currDiet});

  User.fromJson(Map<String, dynamic> json) {
    //id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    id = json['id'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    goals = json['goals'] != null ? new Goals.fromJson(json['goals']) : null;
    if (json['log'] != null) {
      List<Log> log = [];
      json['log'].forEach((v) {
        log.add(new Log.fromJson(v));
      });
    }
    // currWorkout = json['curr_workout'] != null
    //     ? new Id.fromJson(json['curr_workout'])
    //     : null;
    // currDiet =
    //     json['curr_diet'] != null ? new Id.fromJson(json['curr_diet']) : null;
    currWorkout = json['curr_workout'];
    currDiet = json['curr_diet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id;
    }
    data['username'] = this.username;
    data['email'] = this.email;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['birthdate'] = this.birthdate;
    if (this.stats != null) {
      data['stats'] = this.stats.toJson();
    }
    if (this.goals != null) {
      data['goals'] = this.goals.toJson();
    }
    if (this.log != null) {
      data['log'] = this.log.map((v) => v.toJson()).toList();
    }
    if (this.currWorkout != null) {
      data['curr_workout'] = this.currWorkout;
    }
    if (this.currDiet != null) {
      data['curr_diet'] = this.currDiet;
    }
    return data;
  }
}

class Stats {
  double height;
  double weight;
  double bodyfat;

  Stats({this.height, this.weight, this.bodyfat});

  Stats.fromJson(Map<String, dynamic> json) {
    height = json['height'].toDouble();
    weight = json['weight'].toDouble();
    bodyfat = json['bodyfat'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['bodyfat'] = this.bodyfat;
    return data;
  }
}

class Goals {
  String targetdate;
  double weight;
  double bodyfat;

  Goals({this.targetdate, this.weight, this.bodyfat});

  Goals.fromJson(Map<String, dynamic> json) {
    targetdate = json['targetdate'];
    weight = json['weight'].toDouble();
    bodyfat = json['bodyfat'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['targetdate'] = this.targetdate;
    data['weight'] = this.weight;
    data['bodyfat'] = this.bodyfat;
    return data;
  }
}

class Log {
  String date;
  WorkoutLog workout;

  Log({this.date, this.workout});

  Log.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    workout = json['workout'] != null
        ? new WorkoutLog.fromJson(json['workout'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.workout != null) {
      data['workout'] = this.workout.toJson();
    }
    return data;
  }
}

class WorkoutLog {
  String wid;
  List<Ex> ex;

  WorkoutLog({this.wid, this.ex});

  WorkoutLog.fromJson(Map<String, dynamic> json) {
    //wid = json['wid'] != null ? new Id.fromJson(json['wid']) : null;
    wid = json['wid'];

    if (json['ex'] != null) {
      List<Ex> ex = [];
      json['ex'].forEach((v) {
        ex.add(new Ex.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wid'] = this.wid;
    if (this.ex != null) {
      data['ex'] = this.ex.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ex {
  String id;
  List<int> reps;
  List<double> weight;
  List<double> dur;

  Ex({this.id, this.reps, this.weight, this.dur});

  Ex.fromJson(Map<String, dynamic> json) {
    //id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    id = json['id'];
    reps = json['reps'].cast<int>();
    weight = json['weight'].toDouble();
    dur = json['dur'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reps'] = this.reps;
    data['weight'] = this.weight;
    data['dur'] = this.dur;
    return data;
  }
}

//Workout
class Workout {
  String id;
  String name;
  String author;
  List<WDays> days;

  Workout({this.id, this.name, this.author, this.days});

  Workout.fromJson(Map<String, dynamic> json) {
    //id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    id = json['id'];
    name = json['name'];
    //author = json['author'] != null ? new Id.fromJson(json['author']) : null;
    author = json['author'];
    if (json['days'] != null) {
      List<WDays> days = [];
      json['days'].forEach((v) {
        days.add(new WDays.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id;
    }
    data['name'] = this.name;
    if (this.author != null) {
      data['author'] = this.author;
    }
    if (this.days != null) {
      data['days'] = this.days.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WDays {
  String day;
  String time;
  List<Routine> routine;

  WDays({this.day, this.time, this.routine});

  WDays.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    time = json['time'];
    if (json['routine'] != null) {
      List<Routine> routine = [];
      json['routine'].forEach((v) {
        routine.add(new Routine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['time'] = this.time;
    if (this.routine != null) {
      data['routine'] = this.routine.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routine {
  String exid;
  List<int> reps;
  List<double> dur;

  Routine({this.exid, this.reps, this.dur});

  Routine.fromJson(Map<String, dynamic> json) {
    //exid = json['exid'] != null ? new Id.fromJson(json['exid']) : null;
    exid = json['exid'];
    reps = json['reps'].cast<int>();
    dur = json['dur'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exid'] = this.exid;
    data['reps'] = this.reps;
    data['dur'] = this.dur;
    return data;
  }
}

//Exercise
class Exercise {
  String id;
  String name;
  String category;
  String info;
  double difficulty;
  List<String> target;

  Exercise(
      {this.id,
      this.name,
      this.category,
      this.info,
      this.difficulty,
      this.target});

  Exercise.fromJson(Map<String, dynamic> json) {
    //id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    id = json['id'];
    name = json['name'];
    category = json['category'];
    info = json['info'];
    difficulty = json['difficulty'].toDouble();
    target = json['target'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id;
    }
    data['name'] = this.name;
    data['category'] = this.category;
    data['info'] = this.info;
    data['difficulty'] = this.difficulty;
    data['target'] = this.target;
    return data;
  }
}

//Diet
class Diet {
  String id;
  String name;
  String author;
  double calories;
  Dist dist;
  List<Days> days;
  List<String> tags;

  Diet({this.id, this.name, this.author, this.calories, this.dist, this.days});

  Diet.fromJson(Map<String, dynamic> json) {
    //id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    id = json['id'];
    name = json['name'];
    //author = json['author'] != null ? new Id.fromJson(json['author']) : null;
    author = json['author'];
    calories = json['calories'].toDouble();
    dist = json['dist'] != null ? new Dist.fromJson(json['dist']) : null;
    if (json['days'] != null) {
      List<Days> days = [];
      json['days'].forEach((v) {
        days.add(new Days.fromJson(v));
      });
    }
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id;
    }
    data['name'] = this.name;
    if (this.author != null) {
      data['author'] = this.author;
    }
    data['calories'] = this.calories;
    if (this.dist != null) {
      data['dist'] = this.dist.toJson();
    }

    if (this.days != null) {
      data['days'] = this.days.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dist {
  double carbs;
  double protein;
  double fat;

  Dist({this.carbs, this.protein, this.fat});

  Dist.fromJson(Map<String, dynamic> json) {
    carbs = json['carbs'].toDouble();
    protein = json['protein'].toDouble();
    fat = json['fat'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carbs'] = this.carbs;
    data['protein'] = this.protein;
    data['fat'] = this.fat;
    return data;
  }
}

class Days {
  String day;
  List<String> meals;

  Days({this.day, this.meals});

  Days.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['meals'] != null) {
      List<String> meals = [];
      json['meals'].forEach((v) {
        //meals.add(new Id.fromJson(v));
        meals.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.meals != null) {
      data['meals'] = this.meals.map((v) => v).toList();
    }
    return data;
  }
}

//Food
class Food {
  String id;
  String name;
  double calories;
  double carbs;
  double protein;
  double fat;
  List<String> tags;

  Food(
      {this.id,
      this.name,
      this.calories,
      this.carbs,
      this.protein,
      this.fat,
      this.tags});

  Food.fromJson(Map<String, dynamic> json) {
    //id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    id = json['id'];
    name = json['name'];
    calories = json['calories'].toDouble();
    carbs = json['carbs'].toDouble();
    protein = json['protein'].toDouble();
    fat = json['fat'].toDouble();
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id;
    }
    data['name'] = this.name;
    data['calories'] = this.calories;
    data['carbs'] = this.carbs;
    data['protein'] = this.protein;
    data['fat'] = this.fat;
    data['tags'] = this.tags;
    return data;
  }
}
