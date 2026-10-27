import 'exercise.dart';

/// Static 5-day muscle split. Titles (muscleGroup, name) are English.
/// All body copy (focus, benefits, tips, muscles, equipment) is Arabic.
const workoutPlan = <WorkoutDay>[
  WorkoutDay(
    dayNumber: 1,
    muscleGroup: 'Back',
    focus: 'التركيز على السماكة والعرض',
    exercises: [
      Exercise(
        id: 'back_1',
        muscleGroup: 'Back',
        name: 'Seated Cable Row',
        sets: 4,
        reps: '12',
        equipment: 'كابل',
        difficulty: Difficulty.beginner,
        restSeconds: 90,
        benefits:
            'يبني سماكة منتصف الظهر، ويعزز سحب لوح الكتف، '
            'ويحسّن وضعية العمود الفقري بشكل عام.',
        imagePath: 'assets/images/exercises/seated_row.jpg',
        tips: [
          'اسحب نحو منتصف البطن مع ثبات الظهر',
          'اضغط لوحي الكتف في نهاية الحركة',
          'تجنّب تأرجح الجذع للأمام والخلف',
        ],
        secondaryMuscles: ['البايسبس', 'الساعد'],
      ),
      Exercise(
        id: 'back_2',
        muscleGroup: 'Back',
        name: 'Lat Pulldown',
        sets: 4,
        reps: '12',
        equipment: 'كابل',
        difficulty: Difficulty.beginner,
        restSeconds: 75,
        benefits:
            'يستهدف العضلة الظهرية العريضة لتوسيع الجزء العلوي من الظهر '
            'وبناء شكل V رياضي.',
        imagePath: 'assets/images/exercises/lat_pulldown.jpg',
        tips: [
          'اسحب البار نحو أعلى الصدر وليس خلف الرأس',
          'حافظ على ميلان خفيف للخلف',
          'ركّز على سحب الكوعين للأسفل والخلف',
        ],
        secondaryMuscles: ['البايسبس', 'الساعد'],
      ),
      Exercise(
        id: 'back_3',
        muscleGroup: 'Back',
        name: 'Bent Over Barbell Row',
        sets: 3,
        reps: '10',
        equipment: 'باربيل',
        difficulty: Difficulty.advanced,
        restSeconds: 120,
        benefits:
            'يطوّر قوة الظهر العلوي والسفلي، ويستهدف عدة عضلات '
            'مثبتة للسلسلة الخلفية في وقت واحد.',
        imagePath: 'assets/images/exercises/bent_over_row.jpg',
        tips: [
          'حافظ على ظهر مستقيم وركبتين مثنيتين قليلًا',
          'اسحب البار نحو السرة لا نحو الصدر',
          'لا ترفع الجذع أثناء السحب',
        ],
        secondaryMuscles: ['البايسبس', 'الدالية الخلفية', 'أسفل الظهر'],
      ),
      Exercise(
        id: 'back_4',
        muscleGroup: 'Back',
        name: 'Single-Arm Dumbbell Row',
        sets: 3,
        reps: '12 لكل جهة',
        equipment: 'دمبل',
        difficulty: Difficulty.beginner,
        restSeconds: 60,
        benefits:
            'يصحّح اختلال القوة بين الجانبين، ويستهدف ألياف الظهر '
            'السفلية بعمق.',
        imagePath: 'assets/images/exercises/single_arm_row.jpg',
        tips: [
          'ادعم جسمك على مقعد بيد وركبة واحدة',
          'اسحب الدمبل نحو الخصر وليس الكتف',
          'احفظ الظهر موازيًا للأرض',
        ],
        secondaryMuscles: ['البايسبس', 'الساعد'],
      ),
    ],
  ),
  WorkoutDay(
    dayNumber: 2,
    muscleGroup: 'Chest',
    focus: 'التركيز على الحجم والصدر العلوي',
    exercises: [
      Exercise(
        id: 'chest_1',
        muscleGroup: 'Chest',
        name: 'Chest Press Machine',
        sets: 4,
        reps: '10-12',
        equipment: 'آلة',
        difficulty: Difficulty.beginner,
        restSeconds: 75,
        benefits:
            'يبني كتلة الصدر بأمان مع مسار حركة مضبوط، '
            'مثالي للتدرج الثابت.',
        imagePath: 'assets/images/exercises/chest_press.jpg',
        tips: [
          'اضبط ارتفاع المقعد بحيث يكون المقبض بمستوى منتصف الصدر',
          'لا تقفل الكوع في نهاية الحركة',
          'تحكّم في الوزن أثناء الرجوع',
        ],
        secondaryMuscles: ['الترايسبس', 'الدالية الأمامية'],
      ),
      Exercise(
        id: 'chest_2',
        muscleGroup: 'Chest',
        name: 'Incline Dumbbell Press',
        sets: 4,
        reps: '12',
        equipment: 'دمبل',
        difficulty: Difficulty.intermediate,
        restSeconds: 90,
        benefits:
            'يركّز بشكل أساسي على الجزء العلوي من الصدر '
            'لإبراز امتلاء الجذع العلوي.',
        imagePath: 'assets/images/exercises/incline_dumbbell_press.jpg',
        tips: [
          'اضبط المقعد بزاوية 30-45 درجة',
          'اسحب لوحي الكتف للخلف وثبّتهما',
          'اخفض الدمبل حتى مستوى الصدر العلوي',
        ],
        secondaryMuscles: ['الترايسبس', 'الدالية الأمامية'],
      ),
      Exercise(
        id: 'chest_3',
        muscleGroup: 'Chest',
        name: 'Dumbbell Flyes',
        sets: 3,
        reps: '15',
        equipment: 'دمبل',
        difficulty: Difficulty.intermediate,
        restSeconds: 60,
        benefits:
            'يمدّد ألياف عضلات الصدر عبر نطاق حركة واسع، '
            'ويحسّن مرونة وتحديد الصدر.',
        imagePath: 'assets/images/exercises/dumbbell_flyes.jpg',
        tips: [
          'حافظ على انحناء خفيف ثابت في الكوع',
          'افتح الذراعين إلى الجانبين لا إلى الخلف',
          'تجنّب خفض الدمبل أكثر من اللازم لتفادي إجهاد الكتف',
        ],
        secondaryMuscles: ['الدالية الأمامية'],
      ),
      Exercise(
        id: 'chest_4',
        muscleGroup: 'Chest',
        name: 'Cable Crossover',
        sets: 3,
        reps: '15',
        equipment: 'كابل',
        difficulty: Difficulty.intermediate,
        restSeconds: 60,
        benefits:
            'يحافظ على شدّ مستمر طوال نطاق الحركة بالكامل، '
            'ويعظّم الانقباض عند المركز.',
        imagePath: 'assets/images/exercises/cable_crossover.jpg',
        tips: [
          'انحنِ قليلًا للأمام',
          'اجمع يديك أمام الوركين',
          'اضغط عضلات الصدر عند الالتقاء لثانية',
        ],
        secondaryMuscles: ['الدالية الأمامية'],
      ),
    ],
  ),
  WorkoutDay(
    dayNumber: 3,
    muscleGroup: 'Legs',
    focus: 'الفخذ الأمامي، الخلفي، والسمانة',
    exercises: [
      Exercise(
        id: 'legs_1',
        muscleGroup: 'Legs',
        name: 'Leg Press',
        sets: 4,
        reps: '12',
        equipment: 'آلة',
        difficulty: Difficulty.beginner,
        restSeconds: 120,
        benefits:
            'يطوّر قوة الفخذ الأمامي والمؤخرة بفعالية مع تقليل '
            'الحمل على أسفل الظهر.',
        imagePath: 'assets/images/exercises/leg_press.jpg',
        tips: [
          'ضع القدمين بعرض الكتفين',
          'لا تقفل الركبتين عند الدفع',
          'اخفض حتى تصبح الركبتان بزاوية 90 درجة',
        ],
        secondaryMuscles: ['المؤخرة', 'أوتار الركبة'],
      ),
      Exercise(
        id: 'legs_2',
        muscleGroup: 'Legs',
        name: 'Seated Leg Curl',
        sets: 4,
        reps: '15',
        equipment: 'آلة',
        difficulty: Difficulty.beginner,
        restSeconds: 60,
        benefits:
            'يعزل ويقوّي عضلات الفخذ الخلفية، '
            'ويقي من إصابات الركبة الشائعة.',
        imagePath: 'assets/images/exercises/leg_curl.jpg',
        tips: [
          'اضبط الوسادة لتستقر على الكاحل تمامًا',
          'اثنِ الركبتين كاملًا للخلف',
          'تحكّم في الوزن أثناء الرجوع ولا تدعه يسقط',
        ],
        secondaryMuscles: ['السمانة'],
      ),
      Exercise(
        id: 'legs_3',
        muscleGroup: 'Legs',
        name: 'Leg Extension',
        sets: 4,
        reps: '15',
        equipment: 'آلة',
        difficulty: Difficulty.beginner,
        restSeconds: 60,
        benefits:
            'يعزل عضلات الفخذ الأمامي لتحسين ثبات الركبة '
            'وتحديد أسفل الفخذ.',
        imagePath: 'assets/images/exercises/leg_extension.jpg',
        tips: [
          'ادفع إلى الأعلى حتى امتداد كامل',
          'اضغط عضلات الفخذ لثانية في الأعلى',
          'تحكّم في الرجوع ببطء',
        ],
        secondaryMuscles: [],
      ),
      Exercise(
        id: 'legs_4',
        muscleGroup: 'Legs',
        name: 'Standing Calf Raises',
        sets: 4,
        reps: '20',
        equipment: 'آلة',
        difficulty: Difficulty.beginner,
        restSeconds: 45,
        benefits:
            'يبني تحمل العضلات ونموّها في عضلات '
            'السمانة بكامل مكوناتها.',
        imagePath: 'assets/images/exercises/calf_raises.jpg',
        tips: [
          'ارفع الكعبين قدر الإمكان',
          'اخفض إلى امتداد كامل',
          'حركة بطيئة ومتحكم بها لا بالاهتزاز',
        ],
        secondaryMuscles: [],
      ),
    ],
  ),
  WorkoutDay(
    dayNumber: 4,
    muscleGroup: 'Shoulders',
    focus: 'تحديد وعرض عضلة الدالية',
    exercises: [
      Exercise(
        id: 'shoulders_1',
        muscleGroup: 'Shoulders',
        name: 'Shoulder Press Machine',
        sets: 4,
        reps: '12',
        equipment: 'آلة',
        difficulty: Difficulty.beginner,
        restSeconds: 75,
        benefits:
            'يبني كتلة أساسية في الرأس الأمامي والجانبي للدالية '
            'بأمان مع ثبات الجهاز.',
        imagePath: 'assets/images/exercises/shoulder_press.jpg',
        tips: [
          'اضبط المقعد بحيث يكون المقبض بمستوى الأذنين',
          'ادفع بشكل مستقيم للأعلى',
          'لا تقفل الكوع في نهاية الحركة',
        ],
        secondaryMuscles: ['الترايسبس'],
      ),
      Exercise(
        id: 'shoulders_2',
        muscleGroup: 'Shoulders',
        name: 'Dumbbell Lateral Raises',
        sets: 4,
        reps: '15',
        equipment: 'دمبل',
        difficulty: Difficulty.intermediate,
        restSeconds: 45,
        benefits:
            'يستهدف مباشرة الرأس الجانبي للدالية لتوسيع '
            'عرض الكتف وبناء شكل رياضي.',
        imagePath: 'assets/images/exercises/lateral_raises.jpg',
        tips: [
          'ارفع إلى مستوى الكتف فقط لا أعلى',
          'احفظ انحناء خفيف في الكوع',
          'لا تهزّ الجسم للمساعدة بالوزن',
        ],
        secondaryMuscles: ['الدالية الأمامية'],
      ),
      Exercise(
        id: 'shoulders_3',
        muscleGroup: 'Shoulders',
        name: 'Front Raise',
        sets: 3,
        reps: '12',
        equipment: 'دمبل',
        difficulty: Difficulty.beginner,
        restSeconds: 45,
        benefits:
            'يعزل الرأس الأمامي للدالية لتطوير '
            'متوازن للكتف.',
        imagePath: 'assets/images/exercises/front_raise.jpg',
        tips: [
          'ارفع إلى مستوى الكتف',
          'احفظ الذراعين مستقيمين تقريبًا',
          'تحكّم في الرجوع ببطء',
        ],
        secondaryMuscles: [],
      ),
      Exercise(
        id: 'shoulders_4',
        muscleGroup: 'Shoulders',
        name: 'Rear Delt Fly',
        sets: 3,
        reps: '15',
        equipment: 'دمبل',
        difficulty: Difficulty.intermediate,
        restSeconds: 60,
        benefits:
            'يقوّي الرأس الخلفي للدالية ووضعية الظهر العلوي، '
            'ويعالج انحناء الكتفين للأمام.',
        imagePath: 'assets/images/exercises/rear_delt_fly.jpg',
        tips: [
          'انحنِ للأمام مع ظهر مستقيم',
          'افتح الذراعين إلى الخلف والجانبين',
          'اضغط لوحي الكتف في الأعلى',
        ],
        secondaryMuscles: ['الظهر العلوي'],
      ),
    ],
  ),
  WorkoutDay(
    dayNumber: 5,
    muscleGroup: 'Arms & Core',
    focus: 'البايسبس، الترايسبس، وقوة البطن',
    exercises: [
      Exercise(
        id: 'arms_1',
        muscleGroup: 'Arms & Core',
        name: 'Biceps Curl',
        sets: 4,
        reps: '12',
        equipment: 'باربيل أو دمبل',
        difficulty: Difficulty.beginner,
        restSeconds: 60,
        benefits:
            'يبني كتلة وقوة وظيفية في مقدمة الذراع '
            'العلوية.',
        imagePath: 'assets/images/exercises/biceps_curl.jpg',
        tips: [
          'ثبّت الكوعين بجانب الجسم',
          'ارفع حتى الانقباض الكامل دون تأرجح',
          'تحكّم في الرجوع ببطء',
        ],
        secondaryMuscles: ['الساعد'],
      ),
      Exercise(
        id: 'arms_2',
        muscleGroup: 'Arms & Core',
        name: 'Triceps Pushdown',
        sets: 4,
        reps: '12',
        equipment: 'كابل',
        difficulty: Difficulty.beginner,
        restSeconds: 60,
        benefits:
            'يعزل عضلة الترايسبس المسؤولة عن الجزء الأكبر من '
            'كتلة الذراع العلوية وقوة فرد الكوع.',
        imagePath: 'assets/images/exercises/triceps_pushdown.jpg',
        tips: [
          'ثبّت الكوعين قريبًا من الجسم',
          'ادفع للأسفل حتى امتداد كامل للذراع',
          'لا تحرّك المرفقين إلى الأمام',
        ],
        secondaryMuscles: ['الساعد'],
      ),
      Exercise(
        id: 'arms_3',
        muscleGroup: 'Arms & Core',
        name: 'Abdominal Crunch Machine',
        sets: 4,
        reps: '20',
        equipment: 'آلة',
        difficulty: Difficulty.beginner,
        restSeconds: 45,
        benefits:
            'يقوّي العضلة البطنية المستقيمة، ويدعم ثبات '
            'الجذع، ويحمي الفقرات القطنية.',
        imagePath: 'assets/images/exercises/ab_crunch.jpg',
        tips: [
          'انحنِ بالجذع للأمام من البطن لا من الورك',
          'اضغط عضلات البطن في النهاية',
          'تنفّس زفيرًا أثناء الانقباض',
        ],
        secondaryMuscles: ['العضلات المائلة'],
      ),
    ],
  ),
];
