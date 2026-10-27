// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetActivityRecordCollection on Isar {
  IsarCollection<ActivityRecord> get activityRecords => this.collection();
}

const ActivityRecordSchema = CollectionSchema(
  name: r'ActivityRecord',
  id: -5504051165367630394,
  properties: {
    r'activeCalories': PropertySchema(
      id: 0,
      name: r'activeCalories',
      type: IsarType.double,
    ),
    r'dayEpoch': PropertySchema(
      id: 1,
      name: r'dayEpoch',
      type: IsarType.long,
    ),
    r'distanceMeters': PropertySchema(
      id: 2,
      name: r'distanceMeters',
      type: IsarType.double,
    ),
    r'hourlySteps': PropertySchema(
      id: 3,
      name: r'hourlySteps',
      type: IsarType.longList,
    ),
    r'steps': PropertySchema(
      id: 4,
      name: r'steps',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 5,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _activityRecordEstimateSize,
  serialize: _activityRecordSerialize,
  deserialize: _activityRecordDeserialize,
  deserializeProp: _activityRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'dayEpoch': IndexSchema(
      id: -7839809255606828845,
      name: r'dayEpoch',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'dayEpoch',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _activityRecordGetId,
  getLinks: _activityRecordGetLinks,
  attach: _activityRecordAttach,
  version: '3.4.1',
);

int _activityRecordEstimateSize(
  ActivityRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.hourlySteps.length * 8;
  return bytesCount;
}

void _activityRecordSerialize(
  ActivityRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.activeCalories);
  writer.writeLong(offsets[1], object.dayEpoch);
  writer.writeDouble(offsets[2], object.distanceMeters);
  writer.writeLongList(offsets[3], object.hourlySteps);
  writer.writeLong(offsets[4], object.steps);
  writer.writeDateTime(offsets[5], object.updatedAt);
}

ActivityRecord _activityRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ActivityRecord();
  object.activeCalories = reader.readDouble(offsets[0]);
  object.dayEpoch = reader.readLong(offsets[1]);
  object.distanceMeters = reader.readDouble(offsets[2]);
  object.hourlySteps = reader.readLongList(offsets[3]) ?? [];
  object.id = id;
  object.steps = reader.readLong(offsets[4]);
  object.updatedAt = reader.readDateTime(offsets[5]);
  return object;
}

P _activityRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLongList(offset) ?? []) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _activityRecordGetId(ActivityRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _activityRecordGetLinks(ActivityRecord object) {
  return [];
}

void _activityRecordAttach(
    IsarCollection<dynamic> col, Id id, ActivityRecord object) {
  object.id = id;
}

extension ActivityRecordByIndex on IsarCollection<ActivityRecord> {
  Future<ActivityRecord?> getByDayEpoch(int dayEpoch) {
    return getByIndex(r'dayEpoch', [dayEpoch]);
  }

  ActivityRecord? getByDayEpochSync(int dayEpoch) {
    return getByIndexSync(r'dayEpoch', [dayEpoch]);
  }

  Future<bool> deleteByDayEpoch(int dayEpoch) {
    return deleteByIndex(r'dayEpoch', [dayEpoch]);
  }

  bool deleteByDayEpochSync(int dayEpoch) {
    return deleteByIndexSync(r'dayEpoch', [dayEpoch]);
  }

  Future<List<ActivityRecord?>> getAllByDayEpoch(List<int> dayEpochValues) {
    final values = dayEpochValues.map((e) => [e]).toList();
    return getAllByIndex(r'dayEpoch', values);
  }

  List<ActivityRecord?> getAllByDayEpochSync(List<int> dayEpochValues) {
    final values = dayEpochValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'dayEpoch', values);
  }

  Future<int> deleteAllByDayEpoch(List<int> dayEpochValues) {
    final values = dayEpochValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'dayEpoch', values);
  }

  int deleteAllByDayEpochSync(List<int> dayEpochValues) {
    final values = dayEpochValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'dayEpoch', values);
  }

  Future<Id> putByDayEpoch(ActivityRecord object) {
    return putByIndex(r'dayEpoch', object);
  }

  Id putByDayEpochSync(ActivityRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'dayEpoch', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByDayEpoch(List<ActivityRecord> objects) {
    return putAllByIndex(r'dayEpoch', objects);
  }

  List<Id> putAllByDayEpochSync(List<ActivityRecord> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'dayEpoch', objects, saveLinks: saveLinks);
  }
}

extension ActivityRecordQueryWhereSort
    on QueryBuilder<ActivityRecord, ActivityRecord, QWhere> {
  QueryBuilder<ActivityRecord, ActivityRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterWhere> anyDayEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dayEpoch'),
      );
    });
  }
}

extension ActivityRecordQueryWhere
    on QueryBuilder<ActivityRecord, ActivityRecord, QWhereClause> {
  QueryBuilder<ActivityRecord, ActivityRecord, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterWhereClause>
      dayEpochEqualTo(int dayEpoch) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dayEpoch',
        value: [dayEpoch],
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterWhereClause>
      dayEpochNotEqualTo(int dayEpoch) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dayEpoch',
              lower: [],
              upper: [dayEpoch],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dayEpoch',
              lower: [dayEpoch],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dayEpoch',
              lower: [dayEpoch],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dayEpoch',
              lower: [],
              upper: [dayEpoch],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterWhereClause>
      dayEpochGreaterThan(
    int dayEpoch, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dayEpoch',
        lower: [dayEpoch],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterWhereClause>
      dayEpochLessThan(
    int dayEpoch, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dayEpoch',
        lower: [],
        upper: [dayEpoch],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterWhereClause>
      dayEpochBetween(
    int lowerDayEpoch,
    int upperDayEpoch, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dayEpoch',
        lower: [lowerDayEpoch],
        includeLower: includeLower,
        upper: [upperDayEpoch],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActivityRecordQueryFilter
    on QueryBuilder<ActivityRecord, ActivityRecord, QFilterCondition> {
  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      activeCaloriesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activeCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      activeCaloriesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activeCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      activeCaloriesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activeCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      activeCaloriesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activeCalories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      dayEpochEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayEpoch',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      dayEpochGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayEpoch',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      dayEpochLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayEpoch',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      dayEpochBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayEpoch',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      distanceMetersEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distanceMeters',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      distanceMetersGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distanceMeters',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      distanceMetersLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distanceMeters',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      distanceMetersBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distanceMeters',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      hourlyStepsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hourlySteps',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      hourlyStepsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hourlySteps',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      hourlyStepsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hourlySteps',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      hourlyStepsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hourlySteps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      hourlyStepsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlySteps',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      hourlyStepsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlySteps',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      hourlyStepsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlySteps',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      hourlyStepsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlySteps',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      hourlyStepsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlySteps',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      hourlyStepsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hourlySteps',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      stepsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'steps',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      stepsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'steps',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      stepsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'steps',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      stepsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'steps',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ActivityRecordQueryObject
    on QueryBuilder<ActivityRecord, ActivityRecord, QFilterCondition> {}

extension ActivityRecordQueryLinks
    on QueryBuilder<ActivityRecord, ActivityRecord, QFilterCondition> {}

extension ActivityRecordQuerySortBy
    on QueryBuilder<ActivityRecord, ActivityRecord, QSortBy> {
  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy>
      sortByActiveCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeCalories', Sort.asc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy>
      sortByActiveCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeCalories', Sort.desc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy> sortByDayEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayEpoch', Sort.asc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy>
      sortByDayEpochDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayEpoch', Sort.desc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy>
      sortByDistanceMeters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.asc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy>
      sortByDistanceMetersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.desc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy> sortBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy> sortByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ActivityRecordQuerySortThenBy
    on QueryBuilder<ActivityRecord, ActivityRecord, QSortThenBy> {
  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy>
      thenByActiveCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeCalories', Sort.asc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy>
      thenByActiveCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeCalories', Sort.desc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy> thenByDayEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayEpoch', Sort.asc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy>
      thenByDayEpochDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayEpoch', Sort.desc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy>
      thenByDistanceMeters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.asc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy>
      thenByDistanceMetersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.desc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy> thenBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.asc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy> thenByStepsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'steps', Sort.desc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ActivityRecordQueryWhereDistinct
    on QueryBuilder<ActivityRecord, ActivityRecord, QDistinct> {
  QueryBuilder<ActivityRecord, ActivityRecord, QDistinct>
      distinctByActiveCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activeCalories');
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QDistinct> distinctByDayEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayEpoch');
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QDistinct>
      distinctByDistanceMeters() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceMeters');
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QDistinct>
      distinctByHourlySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hourlySteps');
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QDistinct> distinctBySteps() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'steps');
    });
  }

  QueryBuilder<ActivityRecord, ActivityRecord, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension ActivityRecordQueryProperty
    on QueryBuilder<ActivityRecord, ActivityRecord, QQueryProperty> {
  QueryBuilder<ActivityRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ActivityRecord, double, QQueryOperations>
      activeCaloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activeCalories');
    });
  }

  QueryBuilder<ActivityRecord, int, QQueryOperations> dayEpochProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayEpoch');
    });
  }

  QueryBuilder<ActivityRecord, double, QQueryOperations>
      distanceMetersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceMeters');
    });
  }

  QueryBuilder<ActivityRecord, List<int>, QQueryOperations>
      hourlyStepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hourlySteps');
    });
  }

  QueryBuilder<ActivityRecord, int, QQueryOperations> stepsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'steps');
    });
  }

  QueryBuilder<ActivityRecord, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
