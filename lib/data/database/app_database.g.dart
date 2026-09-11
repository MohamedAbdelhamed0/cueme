// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RoutinesTableTable extends RoutinesTable
    with TableInfo<$RoutinesTableTable, RoutineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionVerbMeta = const VerificationMeta(
    'actionVerb',
  );
  @override
  late final GeneratedColumn<String> actionVerb = GeneratedColumn<String>(
    'action_verb',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dosageTextMeta = const VerificationMeta(
    'dosageText',
  );
  @override
  late final GeneratedColumn<String> dosageText = GeneratedColumn<String>(
    'dosage_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorKeyMeta = const VerificationMeta(
    'colorKey',
  );
  @override
  late final GeneratedColumn<String> colorKey = GeneratedColumn<String>(
    'color_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weekdaysMaskMeta = const VerificationMeta(
    'weekdaysMask',
  );
  @override
  late final GeneratedColumn<int> weekdaysMask = GeneratedColumn<int>(
    'weekdays_mask',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _soundModeMeta = const VerificationMeta(
    'soundMode',
  );
  @override
  late final GeneratedColumn<String> soundMode = GeneratedColumn<String>(
    'sound_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioIdMeta = const VerificationMeta(
    'audioId',
  );
  @override
  late final GeneratedColumn<String> audioId = GeneratedColumn<String>(
    'audio_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vibrationEnabledMeta = const VerificationMeta(
    'vibrationEnabled',
  );
  @override
  late final GeneratedColumn<bool> vibrationEnabled = GeneratedColumn<bool>(
    'vibration_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("vibration_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _snoozeEnabledMeta = const VerificationMeta(
    'snoozeEnabled',
  );
  @override
  late final GeneratedColumn<bool> snoozeEnabled = GeneratedColumn<bool>(
    'snooze_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("snooze_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _snoozeMinutesMeta = const VerificationMeta(
    'snoozeMinutes',
  );
  @override
  late final GeneratedColumn<int> snoozeMinutes = GeneratedColumn<int>(
    'snooze_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    actionVerb,
    dosageText,
    instructions,
    iconKey,
    colorKey,
    isActive,
    isArchived,
    startDate,
    endDate,
    weekdaysMask,
    soundMode,
    audioId,
    vibrationEnabled,
    snoozeEnabled,
    snoozeMinutes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('action_verb')) {
      context.handle(
        _actionVerbMeta,
        actionVerb.isAcceptableOrUnknown(data['action_verb']!, _actionVerbMeta),
      );
    }
    if (data.containsKey('dosage_text')) {
      context.handle(
        _dosageTextMeta,
        dosageText.isAcceptableOrUnknown(data['dosage_text']!, _dosageTextMeta),
      );
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_iconKeyMeta);
    }
    if (data.containsKey('color_key')) {
      context.handle(
        _colorKeyMeta,
        colorKey.isAcceptableOrUnknown(data['color_key']!, _colorKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_colorKeyMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('weekdays_mask')) {
      context.handle(
        _weekdaysMaskMeta,
        weekdaysMask.isAcceptableOrUnknown(
          data['weekdays_mask']!,
          _weekdaysMaskMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekdaysMaskMeta);
    }
    if (data.containsKey('sound_mode')) {
      context.handle(
        _soundModeMeta,
        soundMode.isAcceptableOrUnknown(data['sound_mode']!, _soundModeMeta),
      );
    } else if (isInserting) {
      context.missing(_soundModeMeta);
    }
    if (data.containsKey('audio_id')) {
      context.handle(
        _audioIdMeta,
        audioId.isAcceptableOrUnknown(data['audio_id']!, _audioIdMeta),
      );
    }
    if (data.containsKey('vibration_enabled')) {
      context.handle(
        _vibrationEnabledMeta,
        vibrationEnabled.isAcceptableOrUnknown(
          data['vibration_enabled']!,
          _vibrationEnabledMeta,
        ),
      );
    }
    if (data.containsKey('snooze_enabled')) {
      context.handle(
        _snoozeEnabledMeta,
        snoozeEnabled.isAcceptableOrUnknown(
          data['snooze_enabled']!,
          _snoozeEnabledMeta,
        ),
      );
    }
    if (data.containsKey('snooze_minutes')) {
      context.handle(
        _snoozeMinutesMeta,
        snoozeMinutes.isAcceptableOrUnknown(
          data['snooze_minutes']!,
          _snoozeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      actionVerb: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_verb'],
      ),
      dosageText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dosage_text'],
      ),
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      ),
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      )!,
      colorKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_key'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      weekdaysMask: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekdays_mask'],
      )!,
      soundMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sound_mode'],
      )!,
      audioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_id'],
      ),
      vibrationEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}vibration_enabled'],
      )!,
      snoozeEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}snooze_enabled'],
      )!,
      snoozeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snooze_minutes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RoutinesTableTable createAlias(String alias) {
    return $RoutinesTableTable(attachedDatabase, alias);
  }
}

class RoutineRow extends DataClass implements Insertable<RoutineRow> {
  final String id;
  final String name;
  final String category;
  final String? actionVerb;
  final String? dosageText;
  final String? instructions;
  final String iconKey;
  final String colorKey;
  final bool isActive;
  final bool isArchived;
  final DateTime startDate;
  final DateTime? endDate;
  final int weekdaysMask;
  final String soundMode;
  final String? audioId;
  final bool vibrationEnabled;
  final bool snoozeEnabled;
  final int snoozeMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RoutineRow({
    required this.id,
    required this.name,
    required this.category,
    this.actionVerb,
    this.dosageText,
    this.instructions,
    required this.iconKey,
    required this.colorKey,
    required this.isActive,
    required this.isArchived,
    required this.startDate,
    this.endDate,
    required this.weekdaysMask,
    required this.soundMode,
    this.audioId,
    required this.vibrationEnabled,
    required this.snoozeEnabled,
    required this.snoozeMinutes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || actionVerb != null) {
      map['action_verb'] = Variable<String>(actionVerb);
    }
    if (!nullToAbsent || dosageText != null) {
      map['dosage_text'] = Variable<String>(dosageText);
    }
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    map['icon_key'] = Variable<String>(iconKey);
    map['color_key'] = Variable<String>(colorKey);
    map['is_active'] = Variable<bool>(isActive);
    map['is_archived'] = Variable<bool>(isArchived);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['weekdays_mask'] = Variable<int>(weekdaysMask);
    map['sound_mode'] = Variable<String>(soundMode);
    if (!nullToAbsent || audioId != null) {
      map['audio_id'] = Variable<String>(audioId);
    }
    map['vibration_enabled'] = Variable<bool>(vibrationEnabled);
    map['snooze_enabled'] = Variable<bool>(snoozeEnabled);
    map['snooze_minutes'] = Variable<int>(snoozeMinutes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RoutinesTableCompanion toCompanion(bool nullToAbsent) {
    return RoutinesTableCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      actionVerb: actionVerb == null && nullToAbsent
          ? const Value.absent()
          : Value(actionVerb),
      dosageText: dosageText == null && nullToAbsent
          ? const Value.absent()
          : Value(dosageText),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
      iconKey: Value(iconKey),
      colorKey: Value(colorKey),
      isActive: Value(isActive),
      isArchived: Value(isArchived),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      weekdaysMask: Value(weekdaysMask),
      soundMode: Value(soundMode),
      audioId: audioId == null && nullToAbsent
          ? const Value.absent()
          : Value(audioId),
      vibrationEnabled: Value(vibrationEnabled),
      snoozeEnabled: Value(snoozeEnabled),
      snoozeMinutes: Value(snoozeMinutes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RoutineRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      actionVerb: serializer.fromJson<String?>(json['actionVerb']),
      dosageText: serializer.fromJson<String?>(json['dosageText']),
      instructions: serializer.fromJson<String?>(json['instructions']),
      iconKey: serializer.fromJson<String>(json['iconKey']),
      colorKey: serializer.fromJson<String>(json['colorKey']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      weekdaysMask: serializer.fromJson<int>(json['weekdaysMask']),
      soundMode: serializer.fromJson<String>(json['soundMode']),
      audioId: serializer.fromJson<String?>(json['audioId']),
      vibrationEnabled: serializer.fromJson<bool>(json['vibrationEnabled']),
      snoozeEnabled: serializer.fromJson<bool>(json['snoozeEnabled']),
      snoozeMinutes: serializer.fromJson<int>(json['snoozeMinutes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'actionVerb': serializer.toJson<String?>(actionVerb),
      'dosageText': serializer.toJson<String?>(dosageText),
      'instructions': serializer.toJson<String?>(instructions),
      'iconKey': serializer.toJson<String>(iconKey),
      'colorKey': serializer.toJson<String>(colorKey),
      'isActive': serializer.toJson<bool>(isActive),
      'isArchived': serializer.toJson<bool>(isArchived),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'weekdaysMask': serializer.toJson<int>(weekdaysMask),
      'soundMode': serializer.toJson<String>(soundMode),
      'audioId': serializer.toJson<String?>(audioId),
      'vibrationEnabled': serializer.toJson<bool>(vibrationEnabled),
      'snoozeEnabled': serializer.toJson<bool>(snoozeEnabled),
      'snoozeMinutes': serializer.toJson<int>(snoozeMinutes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RoutineRow copyWith({
    String? id,
    String? name,
    String? category,
    Value<String?> actionVerb = const Value.absent(),
    Value<String?> dosageText = const Value.absent(),
    Value<String?> instructions = const Value.absent(),
    String? iconKey,
    String? colorKey,
    bool? isActive,
    bool? isArchived,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    int? weekdaysMask,
    String? soundMode,
    Value<String?> audioId = const Value.absent(),
    bool? vibrationEnabled,
    bool? snoozeEnabled,
    int? snoozeMinutes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RoutineRow(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    actionVerb: actionVerb.present ? actionVerb.value : this.actionVerb,
    dosageText: dosageText.present ? dosageText.value : this.dosageText,
    instructions: instructions.present ? instructions.value : this.instructions,
    iconKey: iconKey ?? this.iconKey,
    colorKey: colorKey ?? this.colorKey,
    isActive: isActive ?? this.isActive,
    isArchived: isArchived ?? this.isArchived,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    weekdaysMask: weekdaysMask ?? this.weekdaysMask,
    soundMode: soundMode ?? this.soundMode,
    audioId: audioId.present ? audioId.value : this.audioId,
    vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
    snoozeEnabled: snoozeEnabled ?? this.snoozeEnabled,
    snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RoutineRow copyWithCompanion(RoutinesTableCompanion data) {
    return RoutineRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      actionVerb: data.actionVerb.present
          ? data.actionVerb.value
          : this.actionVerb,
      dosageText: data.dosageText.present
          ? data.dosageText.value
          : this.dosageText,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      colorKey: data.colorKey.present ? data.colorKey.value : this.colorKey,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      weekdaysMask: data.weekdaysMask.present
          ? data.weekdaysMask.value
          : this.weekdaysMask,
      soundMode: data.soundMode.present ? data.soundMode.value : this.soundMode,
      audioId: data.audioId.present ? data.audioId.value : this.audioId,
      vibrationEnabled: data.vibrationEnabled.present
          ? data.vibrationEnabled.value
          : this.vibrationEnabled,
      snoozeEnabled: data.snoozeEnabled.present
          ? data.snoozeEnabled.value
          : this.snoozeEnabled,
      snoozeMinutes: data.snoozeMinutes.present
          ? data.snoozeMinutes.value
          : this.snoozeMinutes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('actionVerb: $actionVerb, ')
          ..write('dosageText: $dosageText, ')
          ..write('instructions: $instructions, ')
          ..write('iconKey: $iconKey, ')
          ..write('colorKey: $colorKey, ')
          ..write('isActive: $isActive, ')
          ..write('isArchived: $isArchived, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('weekdaysMask: $weekdaysMask, ')
          ..write('soundMode: $soundMode, ')
          ..write('audioId: $audioId, ')
          ..write('vibrationEnabled: $vibrationEnabled, ')
          ..write('snoozeEnabled: $snoozeEnabled, ')
          ..write('snoozeMinutes: $snoozeMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    actionVerb,
    dosageText,
    instructions,
    iconKey,
    colorKey,
    isActive,
    isArchived,
    startDate,
    endDate,
    weekdaysMask,
    soundMode,
    audioId,
    vibrationEnabled,
    snoozeEnabled,
    snoozeMinutes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.actionVerb == this.actionVerb &&
          other.dosageText == this.dosageText &&
          other.instructions == this.instructions &&
          other.iconKey == this.iconKey &&
          other.colorKey == this.colorKey &&
          other.isActive == this.isActive &&
          other.isArchived == this.isArchived &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.weekdaysMask == this.weekdaysMask &&
          other.soundMode == this.soundMode &&
          other.audioId == this.audioId &&
          other.vibrationEnabled == this.vibrationEnabled &&
          other.snoozeEnabled == this.snoozeEnabled &&
          other.snoozeMinutes == this.snoozeMinutes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RoutinesTableCompanion extends UpdateCompanion<RoutineRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String?> actionVerb;
  final Value<String?> dosageText;
  final Value<String?> instructions;
  final Value<String> iconKey;
  final Value<String> colorKey;
  final Value<bool> isActive;
  final Value<bool> isArchived;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<int> weekdaysMask;
  final Value<String> soundMode;
  final Value<String?> audioId;
  final Value<bool> vibrationEnabled;
  final Value<bool> snoozeEnabled;
  final Value<int> snoozeMinutes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RoutinesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.actionVerb = const Value.absent(),
    this.dosageText = const Value.absent(),
    this.instructions = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.colorKey = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.weekdaysMask = const Value.absent(),
    this.soundMode = const Value.absent(),
    this.audioId = const Value.absent(),
    this.vibrationEnabled = const Value.absent(),
    this.snoozeEnabled = const Value.absent(),
    this.snoozeMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutinesTableCompanion.insert({
    required String id,
    required String name,
    required String category,
    this.actionVerb = const Value.absent(),
    this.dosageText = const Value.absent(),
    this.instructions = const Value.absent(),
    required String iconKey,
    required String colorKey,
    this.isActive = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime startDate,
    this.endDate = const Value.absent(),
    required int weekdaysMask,
    required String soundMode,
    this.audioId = const Value.absent(),
    this.vibrationEnabled = const Value.absent(),
    this.snoozeEnabled = const Value.absent(),
    this.snoozeMinutes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       category = Value(category),
       iconKey = Value(iconKey),
       colorKey = Value(colorKey),
       startDate = Value(startDate),
       weekdaysMask = Value(weekdaysMask),
       soundMode = Value(soundMode),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RoutineRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? actionVerb,
    Expression<String>? dosageText,
    Expression<String>? instructions,
    Expression<String>? iconKey,
    Expression<String>? colorKey,
    Expression<bool>? isActive,
    Expression<bool>? isArchived,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? weekdaysMask,
    Expression<String>? soundMode,
    Expression<String>? audioId,
    Expression<bool>? vibrationEnabled,
    Expression<bool>? snoozeEnabled,
    Expression<int>? snoozeMinutes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (actionVerb != null) 'action_verb': actionVerb,
      if (dosageText != null) 'dosage_text': dosageText,
      if (instructions != null) 'instructions': instructions,
      if (iconKey != null) 'icon_key': iconKey,
      if (colorKey != null) 'color_key': colorKey,
      if (isActive != null) 'is_active': isActive,
      if (isArchived != null) 'is_archived': isArchived,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (weekdaysMask != null) 'weekdays_mask': weekdaysMask,
      if (soundMode != null) 'sound_mode': soundMode,
      if (audioId != null) 'audio_id': audioId,
      if (vibrationEnabled != null) 'vibration_enabled': vibrationEnabled,
      if (snoozeEnabled != null) 'snooze_enabled': snoozeEnabled,
      if (snoozeMinutes != null) 'snooze_minutes': snoozeMinutes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutinesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? category,
    Value<String?>? actionVerb,
    Value<String?>? dosageText,
    Value<String?>? instructions,
    Value<String>? iconKey,
    Value<String>? colorKey,
    Value<bool>? isActive,
    Value<bool>? isArchived,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<int>? weekdaysMask,
    Value<String>? soundMode,
    Value<String?>? audioId,
    Value<bool>? vibrationEnabled,
    Value<bool>? snoozeEnabled,
    Value<int>? snoozeMinutes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RoutinesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      actionVerb: actionVerb ?? this.actionVerb,
      dosageText: dosageText ?? this.dosageText,
      instructions: instructions ?? this.instructions,
      iconKey: iconKey ?? this.iconKey,
      colorKey: colorKey ?? this.colorKey,
      isActive: isActive ?? this.isActive,
      isArchived: isArchived ?? this.isArchived,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      weekdaysMask: weekdaysMask ?? this.weekdaysMask,
      soundMode: soundMode ?? this.soundMode,
      audioId: audioId ?? this.audioId,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      snoozeEnabled: snoozeEnabled ?? this.snoozeEnabled,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (actionVerb.present) {
      map['action_verb'] = Variable<String>(actionVerb.value);
    }
    if (dosageText.present) {
      map['dosage_text'] = Variable<String>(dosageText.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (colorKey.present) {
      map['color_key'] = Variable<String>(colorKey.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (weekdaysMask.present) {
      map['weekdays_mask'] = Variable<int>(weekdaysMask.value);
    }
    if (soundMode.present) {
      map['sound_mode'] = Variable<String>(soundMode.value);
    }
    if (audioId.present) {
      map['audio_id'] = Variable<String>(audioId.value);
    }
    if (vibrationEnabled.present) {
      map['vibration_enabled'] = Variable<bool>(vibrationEnabled.value);
    }
    if (snoozeEnabled.present) {
      map['snooze_enabled'] = Variable<bool>(snoozeEnabled.value);
    }
    if (snoozeMinutes.present) {
      map['snooze_minutes'] = Variable<int>(snoozeMinutes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('actionVerb: $actionVerb, ')
          ..write('dosageText: $dosageText, ')
          ..write('instructions: $instructions, ')
          ..write('iconKey: $iconKey, ')
          ..write('colorKey: $colorKey, ')
          ..write('isActive: $isActive, ')
          ..write('isArchived: $isArchived, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('weekdaysMask: $weekdaysMask, ')
          ..write('soundMode: $soundMode, ')
          ..write('audioId: $audioId, ')
          ..write('vibrationEnabled: $vibrationEnabled, ')
          ..write('snoozeEnabled: $snoozeEnabled, ')
          ..write('snoozeMinutes: $snoozeMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReminderTimesTableTable extends ReminderTimesTable
    with TableInfo<$ReminderTimesTableTable, ReminderTimeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderTimesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routines (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _hourMeta = const VerificationMeta('hour');
  @override
  late final GeneratedColumn<int> hour = GeneratedColumn<int>(
    'hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minuteMeta = const VerificationMeta('minute');
  @override
  late final GeneratedColumn<int> minute = GeneratedColumn<int>(
    'minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notificationIdMeta = const VerificationMeta(
    'notificationId',
  );
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
    'notification_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    hour,
    minute,
    sortOrder,
    isEnabled,
    notificationId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_times';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderTimeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('hour')) {
      context.handle(
        _hourMeta,
        hour.isAcceptableOrUnknown(data['hour']!, _hourMeta),
      );
    } else if (isInserting) {
      context.missing(_hourMeta);
    }
    if (data.containsKey('minute')) {
      context.handle(
        _minuteMeta,
        minute.isAcceptableOrUnknown(data['minute']!, _minuteMeta),
      );
    } else if (isInserting) {
      context.missing(_minuteMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('notification_id')) {
      context.handle(
        _notificationIdMeta,
        notificationId.isAcceptableOrUnknown(
          data['notification_id']!,
          _notificationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderTimeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderTimeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_id'],
      )!,
      hour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hour'],
      )!,
      minute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minute'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      notificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReminderTimesTableTable createAlias(String alias) {
    return $ReminderTimesTableTable(attachedDatabase, alias);
  }
}

class ReminderTimeRow extends DataClass implements Insertable<ReminderTimeRow> {
  final String id;
  final String routineId;
  final int hour;
  final int minute;
  final int sortOrder;
  final bool isEnabled;
  final int notificationId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ReminderTimeRow({
    required this.id,
    required this.routineId,
    required this.hour,
    required this.minute,
    required this.sortOrder,
    required this.isEnabled,
    required this.notificationId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_id'] = Variable<String>(routineId);
    map['hour'] = Variable<int>(hour);
    map['minute'] = Variable<int>(minute);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['notification_id'] = Variable<int>(notificationId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReminderTimesTableCompanion toCompanion(bool nullToAbsent) {
    return ReminderTimesTableCompanion(
      id: Value(id),
      routineId: Value(routineId),
      hour: Value(hour),
      minute: Value(minute),
      sortOrder: Value(sortOrder),
      isEnabled: Value(isEnabled),
      notificationId: Value(notificationId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReminderTimeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderTimeRow(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      hour: serializer.fromJson<int>(json['hour']),
      minute: serializer.fromJson<int>(json['minute']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      notificationId: serializer.fromJson<int>(json['notificationId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineId': serializer.toJson<String>(routineId),
      'hour': serializer.toJson<int>(hour),
      'minute': serializer.toJson<int>(minute),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'notificationId': serializer.toJson<int>(notificationId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReminderTimeRow copyWith({
    String? id,
    String? routineId,
    int? hour,
    int? minute,
    int? sortOrder,
    bool? isEnabled,
    int? notificationId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ReminderTimeRow(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    hour: hour ?? this.hour,
    minute: minute ?? this.minute,
    sortOrder: sortOrder ?? this.sortOrder,
    isEnabled: isEnabled ?? this.isEnabled,
    notificationId: notificationId ?? this.notificationId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ReminderTimeRow copyWithCompanion(ReminderTimesTableCompanion data) {
    return ReminderTimeRow(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      hour: data.hour.present ? data.hour.value : this.hour,
      minute: data.minute.present ? data.minute.value : this.minute,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderTimeRow(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('notificationId: $notificationId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    routineId,
    hour,
    minute,
    sortOrder,
    isEnabled,
    notificationId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderTimeRow &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.hour == this.hour &&
          other.minute == this.minute &&
          other.sortOrder == this.sortOrder &&
          other.isEnabled == this.isEnabled &&
          other.notificationId == this.notificationId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ReminderTimesTableCompanion extends UpdateCompanion<ReminderTimeRow> {
  final Value<String> id;
  final Value<String> routineId;
  final Value<int> hour;
  final Value<int> minute;
  final Value<int> sortOrder;
  final Value<bool> isEnabled;
  final Value<int> notificationId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ReminderTimesTableCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.hour = const Value.absent(),
    this.minute = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReminderTimesTableCompanion.insert({
    required String id,
    required String routineId,
    required int hour,
    required int minute,
    this.sortOrder = const Value.absent(),
    this.isEnabled = const Value.absent(),
    required int notificationId,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       routineId = Value(routineId),
       hour = Value(hour),
       minute = Value(minute),
       notificationId = Value(notificationId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ReminderTimeRow> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<int>? hour,
    Expression<int>? minute,
    Expression<int>? sortOrder,
    Expression<bool>? isEnabled,
    Expression<int>? notificationId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (hour != null) 'hour': hour,
      if (minute != null) 'minute': minute,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (notificationId != null) 'notification_id': notificationId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReminderTimesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? routineId,
    Value<int>? hour,
    Value<int>? minute,
    Value<int>? sortOrder,
    Value<bool>? isEnabled,
    Value<int>? notificationId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ReminderTimesTableCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      sortOrder: sortOrder ?? this.sortOrder,
      isEnabled: isEnabled ?? this.isEnabled,
      notificationId: notificationId ?? this.notificationId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (hour.present) {
      map['hour'] = Variable<int>(hour.value);
    }
    if (minute.present) {
      map['minute'] = Variable<int>(minute.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderTimesTableCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('notificationId: $notificationId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AudioRecordingsTableTable extends AudioRecordingsTable
    with TableInfo<$AudioRecordingsTableTable, AudioRecordingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AudioRecordingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iosSoundFilenameMeta = const VerificationMeta(
    'iosSoundFilename',
  );
  @override
  late final GeneratedColumn<String> iosSoundFilename = GeneratedColumn<String>(
    'ios_sound_filename',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codecMeta = const VerificationMeta('codec');
  @override
  late final GeneratedColumn<String> codec = GeneratedColumn<String>(
    'codec',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('wav'),
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeBytesMeta = const VerificationMeta(
    'fileSizeBytes',
  );
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
    'file_size_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localPath,
    iosSoundFilename,
    codec,
    durationMs,
    fileSizeBytes,
    revision,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audio_recordings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AudioRecordingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('ios_sound_filename')) {
      context.handle(
        _iosSoundFilenameMeta,
        iosSoundFilename.isAcceptableOrUnknown(
          data['ios_sound_filename']!,
          _iosSoundFilenameMeta,
        ),
      );
    }
    if (data.containsKey('codec')) {
      context.handle(
        _codecMeta,
        codec.isAcceptableOrUnknown(data['codec']!, _codecMeta),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
        _fileSizeBytesMeta,
        fileSizeBytes.isAcceptableOrUnknown(
          data['file_size_bytes']!,
          _fileSizeBytesMeta,
        ),
      );
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AudioRecordingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AudioRecordingRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      iosSoundFilename: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ios_sound_filename'],
      ),
      codec: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codec'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      )!,
      fileSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size_bytes'],
      ),
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AudioRecordingsTableTable createAlias(String alias) {
    return $AudioRecordingsTableTable(attachedDatabase, alias);
  }
}

class AudioRecordingRow extends DataClass
    implements Insertable<AudioRecordingRow> {
  final String id;
  final String localPath;
  final String? iosSoundFilename;
  final String codec;
  final int durationMs;
  final int? fileSizeBytes;
  final int revision;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AudioRecordingRow({
    required this.id,
    required this.localPath,
    this.iosSoundFilename,
    required this.codec,
    required this.durationMs,
    this.fileSizeBytes,
    required this.revision,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['local_path'] = Variable<String>(localPath);
    if (!nullToAbsent || iosSoundFilename != null) {
      map['ios_sound_filename'] = Variable<String>(iosSoundFilename);
    }
    map['codec'] = Variable<String>(codec);
    map['duration_ms'] = Variable<int>(durationMs);
    if (!nullToAbsent || fileSizeBytes != null) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    }
    map['revision'] = Variable<int>(revision);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AudioRecordingsTableCompanion toCompanion(bool nullToAbsent) {
    return AudioRecordingsTableCompanion(
      id: Value(id),
      localPath: Value(localPath),
      iosSoundFilename: iosSoundFilename == null && nullToAbsent
          ? const Value.absent()
          : Value(iosSoundFilename),
      codec: Value(codec),
      durationMs: Value(durationMs),
      fileSizeBytes: fileSizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(fileSizeBytes),
      revision: Value(revision),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AudioRecordingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AudioRecordingRow(
      id: serializer.fromJson<String>(json['id']),
      localPath: serializer.fromJson<String>(json['localPath']),
      iosSoundFilename: serializer.fromJson<String?>(json['iosSoundFilename']),
      codec: serializer.fromJson<String>(json['codec']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
      fileSizeBytes: serializer.fromJson<int?>(json['fileSizeBytes']),
      revision: serializer.fromJson<int>(json['revision']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'localPath': serializer.toJson<String>(localPath),
      'iosSoundFilename': serializer.toJson<String?>(iosSoundFilename),
      'codec': serializer.toJson<String>(codec),
      'durationMs': serializer.toJson<int>(durationMs),
      'fileSizeBytes': serializer.toJson<int?>(fileSizeBytes),
      'revision': serializer.toJson<int>(revision),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AudioRecordingRow copyWith({
    String? id,
    String? localPath,
    Value<String?> iosSoundFilename = const Value.absent(),
    String? codec,
    int? durationMs,
    Value<int?> fileSizeBytes = const Value.absent(),
    int? revision,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AudioRecordingRow(
    id: id ?? this.id,
    localPath: localPath ?? this.localPath,
    iosSoundFilename: iosSoundFilename.present
        ? iosSoundFilename.value
        : this.iosSoundFilename,
    codec: codec ?? this.codec,
    durationMs: durationMs ?? this.durationMs,
    fileSizeBytes: fileSizeBytes.present
        ? fileSizeBytes.value
        : this.fileSizeBytes,
    revision: revision ?? this.revision,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AudioRecordingRow copyWithCompanion(AudioRecordingsTableCompanion data) {
    return AudioRecordingRow(
      id: data.id.present ? data.id.value : this.id,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      iosSoundFilename: data.iosSoundFilename.present
          ? data.iosSoundFilename.value
          : this.iosSoundFilename,
      codec: data.codec.present ? data.codec.value : this.codec,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      revision: data.revision.present ? data.revision.value : this.revision,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AudioRecordingRow(')
          ..write('id: $id, ')
          ..write('localPath: $localPath, ')
          ..write('iosSoundFilename: $iosSoundFilename, ')
          ..write('codec: $codec, ')
          ..write('durationMs: $durationMs, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('revision: $revision, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localPath,
    iosSoundFilename,
    codec,
    durationMs,
    fileSizeBytes,
    revision,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AudioRecordingRow &&
          other.id == this.id &&
          other.localPath == this.localPath &&
          other.iosSoundFilename == this.iosSoundFilename &&
          other.codec == this.codec &&
          other.durationMs == this.durationMs &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.revision == this.revision &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AudioRecordingsTableCompanion extends UpdateCompanion<AudioRecordingRow> {
  final Value<String> id;
  final Value<String> localPath;
  final Value<String?> iosSoundFilename;
  final Value<String> codec;
  final Value<int> durationMs;
  final Value<int?> fileSizeBytes;
  final Value<int> revision;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AudioRecordingsTableCompanion({
    this.id = const Value.absent(),
    this.localPath = const Value.absent(),
    this.iosSoundFilename = const Value.absent(),
    this.codec = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.revision = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AudioRecordingsTableCompanion.insert({
    required String id,
    required String localPath,
    this.iosSoundFilename = const Value.absent(),
    this.codec = const Value.absent(),
    required int durationMs,
    this.fileSizeBytes = const Value.absent(),
    this.revision = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       localPath = Value(localPath),
       durationMs = Value(durationMs),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AudioRecordingRow> custom({
    Expression<String>? id,
    Expression<String>? localPath,
    Expression<String>? iosSoundFilename,
    Expression<String>? codec,
    Expression<int>? durationMs,
    Expression<int>? fileSizeBytes,
    Expression<int>? revision,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localPath != null) 'local_path': localPath,
      if (iosSoundFilename != null) 'ios_sound_filename': iosSoundFilename,
      if (codec != null) 'codec': codec,
      if (durationMs != null) 'duration_ms': durationMs,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (revision != null) 'revision': revision,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AudioRecordingsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? localPath,
    Value<String?>? iosSoundFilename,
    Value<String>? codec,
    Value<int>? durationMs,
    Value<int?>? fileSizeBytes,
    Value<int>? revision,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AudioRecordingsTableCompanion(
      id: id ?? this.id,
      localPath: localPath ?? this.localPath,
      iosSoundFilename: iosSoundFilename ?? this.iosSoundFilename,
      codec: codec ?? this.codec,
      durationMs: durationMs ?? this.durationMs,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      revision: revision ?? this.revision,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (iosSoundFilename.present) {
      map['ios_sound_filename'] = Variable<String>(iosSoundFilename.value);
    }
    if (codec.present) {
      map['codec'] = Variable<String>(codec.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AudioRecordingsTableCompanion(')
          ..write('id: $id, ')
          ..write('localPath: $localPath, ')
          ..write('iosSoundFilename: $iosSoundFilename, ')
          ..write('codec: $codec, ')
          ..write('durationMs: $durationMs, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('revision: $revision, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReminderHistoryTableTable extends ReminderHistoryTable
    with TableInfo<$ReminderHistoryTableTable, ReminderHistoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reminderTimeIdMeta = const VerificationMeta(
    'reminderTimeId',
  );
  @override
  late final GeneratedColumn<String> reminderTimeId = GeneratedColumn<String>(
    'reminder_time_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduledForMeta = const VerificationMeta(
    'scheduledFor',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledFor = GeneratedColumn<DateTime>(
    'scheduled_for',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionAtMeta = const VerificationMeta(
    'actionAt',
  );
  @override
  late final GeneratedColumn<DateTime> actionAt = GeneratedColumn<DateTime>(
    'action_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _snoozedUntilMeta = const VerificationMeta(
    'snoozedUntil',
  );
  @override
  late final GeneratedColumn<DateTime> snoozedUntil = GeneratedColumn<DateTime>(
    'snoozed_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routineNameSnapshotMeta =
      const VerificationMeta('routineNameSnapshot');
  @override
  late final GeneratedColumn<String> routineNameSnapshot =
      GeneratedColumn<String>(
        'routine_name_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _categorySnapshotMeta = const VerificationMeta(
    'categorySnapshot',
  );
  @override
  late final GeneratedColumn<String> categorySnapshot = GeneratedColumn<String>(
    'category_snapshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    reminderTimeId,
    scheduledFor,
    action,
    actionAt,
    snoozedUntil,
    note,
    createdAt,
    routineNameSnapshot,
    categorySnapshot,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderHistoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('reminder_time_id')) {
      context.handle(
        _reminderTimeIdMeta,
        reminderTimeId.isAcceptableOrUnknown(
          data['reminder_time_id']!,
          _reminderTimeIdMeta,
        ),
      );
    }
    if (data.containsKey('scheduled_for')) {
      context.handle(
        _scheduledForMeta,
        scheduledFor.isAcceptableOrUnknown(
          data['scheduled_for']!,
          _scheduledForMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledForMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('action_at')) {
      context.handle(
        _actionAtMeta,
        actionAt.isAcceptableOrUnknown(data['action_at']!, _actionAtMeta),
      );
    }
    if (data.containsKey('snoozed_until')) {
      context.handle(
        _snoozedUntilMeta,
        snoozedUntil.isAcceptableOrUnknown(
          data['snoozed_until']!,
          _snoozedUntilMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('routine_name_snapshot')) {
      context.handle(
        _routineNameSnapshotMeta,
        routineNameSnapshot.isAcceptableOrUnknown(
          data['routine_name_snapshot']!,
          _routineNameSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('category_snapshot')) {
      context.handle(
        _categorySnapshotMeta,
        categorySnapshot.isAcceptableOrUnknown(
          data['category_snapshot']!,
          _categorySnapshotMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderHistoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderHistoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_id'],
      )!,
      reminderTimeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_time_id'],
      ),
      scheduledFor: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_for'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      actionAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}action_at'],
      ),
      snoozedUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}snoozed_until'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      routineNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_name_snapshot'],
      ),
      categorySnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_snapshot'],
      ),
    );
  }

  @override
  $ReminderHistoryTableTable createAlias(String alias) {
    return $ReminderHistoryTableTable(attachedDatabase, alias);
  }
}

class ReminderHistoryRow extends DataClass
    implements Insertable<ReminderHistoryRow> {
  final String id;
  final String routineId;
  final String? reminderTimeId;
  final DateTime scheduledFor;
  final String action;
  final DateTime? actionAt;
  final DateTime? snoozedUntil;
  final String? note;
  final DateTime createdAt;
  final String? routineNameSnapshot;
  final String? categorySnapshot;
  const ReminderHistoryRow({
    required this.id,
    required this.routineId,
    this.reminderTimeId,
    required this.scheduledFor,
    required this.action,
    this.actionAt,
    this.snoozedUntil,
    this.note,
    required this.createdAt,
    this.routineNameSnapshot,
    this.categorySnapshot,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_id'] = Variable<String>(routineId);
    if (!nullToAbsent || reminderTimeId != null) {
      map['reminder_time_id'] = Variable<String>(reminderTimeId);
    }
    map['scheduled_for'] = Variable<DateTime>(scheduledFor);
    map['action'] = Variable<String>(action);
    if (!nullToAbsent || actionAt != null) {
      map['action_at'] = Variable<DateTime>(actionAt);
    }
    if (!nullToAbsent || snoozedUntil != null) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || routineNameSnapshot != null) {
      map['routine_name_snapshot'] = Variable<String>(routineNameSnapshot);
    }
    if (!nullToAbsent || categorySnapshot != null) {
      map['category_snapshot'] = Variable<String>(categorySnapshot);
    }
    return map;
  }

  ReminderHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return ReminderHistoryTableCompanion(
      id: Value(id),
      routineId: Value(routineId),
      reminderTimeId: reminderTimeId == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTimeId),
      scheduledFor: Value(scheduledFor),
      action: Value(action),
      actionAt: actionAt == null && nullToAbsent
          ? const Value.absent()
          : Value(actionAt),
      snoozedUntil: snoozedUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozedUntil),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      routineNameSnapshot: routineNameSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(routineNameSnapshot),
      categorySnapshot: categorySnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(categorySnapshot),
    );
  }

  factory ReminderHistoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderHistoryRow(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      reminderTimeId: serializer.fromJson<String?>(json['reminderTimeId']),
      scheduledFor: serializer.fromJson<DateTime>(json['scheduledFor']),
      action: serializer.fromJson<String>(json['action']),
      actionAt: serializer.fromJson<DateTime?>(json['actionAt']),
      snoozedUntil: serializer.fromJson<DateTime?>(json['snoozedUntil']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      routineNameSnapshot: serializer.fromJson<String?>(
        json['routineNameSnapshot'],
      ),
      categorySnapshot: serializer.fromJson<String?>(json['categorySnapshot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineId': serializer.toJson<String>(routineId),
      'reminderTimeId': serializer.toJson<String?>(reminderTimeId),
      'scheduledFor': serializer.toJson<DateTime>(scheduledFor),
      'action': serializer.toJson<String>(action),
      'actionAt': serializer.toJson<DateTime?>(actionAt),
      'snoozedUntil': serializer.toJson<DateTime?>(snoozedUntil),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'routineNameSnapshot': serializer.toJson<String?>(routineNameSnapshot),
      'categorySnapshot': serializer.toJson<String?>(categorySnapshot),
    };
  }

  ReminderHistoryRow copyWith({
    String? id,
    String? routineId,
    Value<String?> reminderTimeId = const Value.absent(),
    DateTime? scheduledFor,
    String? action,
    Value<DateTime?> actionAt = const Value.absent(),
    Value<DateTime?> snoozedUntil = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    Value<String?> routineNameSnapshot = const Value.absent(),
    Value<String?> categorySnapshot = const Value.absent(),
  }) => ReminderHistoryRow(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    reminderTimeId: reminderTimeId.present
        ? reminderTimeId.value
        : this.reminderTimeId,
    scheduledFor: scheduledFor ?? this.scheduledFor,
    action: action ?? this.action,
    actionAt: actionAt.present ? actionAt.value : this.actionAt,
    snoozedUntil: snoozedUntil.present ? snoozedUntil.value : this.snoozedUntil,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    routineNameSnapshot: routineNameSnapshot.present
        ? routineNameSnapshot.value
        : this.routineNameSnapshot,
    categorySnapshot: categorySnapshot.present
        ? categorySnapshot.value
        : this.categorySnapshot,
  );
  ReminderHistoryRow copyWithCompanion(ReminderHistoryTableCompanion data) {
    return ReminderHistoryRow(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      reminderTimeId: data.reminderTimeId.present
          ? data.reminderTimeId.value
          : this.reminderTimeId,
      scheduledFor: data.scheduledFor.present
          ? data.scheduledFor.value
          : this.scheduledFor,
      action: data.action.present ? data.action.value : this.action,
      actionAt: data.actionAt.present ? data.actionAt.value : this.actionAt,
      snoozedUntil: data.snoozedUntil.present
          ? data.snoozedUntil.value
          : this.snoozedUntil,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      routineNameSnapshot: data.routineNameSnapshot.present
          ? data.routineNameSnapshot.value
          : this.routineNameSnapshot,
      categorySnapshot: data.categorySnapshot.present
          ? data.categorySnapshot.value
          : this.categorySnapshot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderHistoryRow(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('reminderTimeId: $reminderTimeId, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('action: $action, ')
          ..write('actionAt: $actionAt, ')
          ..write('snoozedUntil: $snoozedUntil, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('routineNameSnapshot: $routineNameSnapshot, ')
          ..write('categorySnapshot: $categorySnapshot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    routineId,
    reminderTimeId,
    scheduledFor,
    action,
    actionAt,
    snoozedUntil,
    note,
    createdAt,
    routineNameSnapshot,
    categorySnapshot,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderHistoryRow &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.reminderTimeId == this.reminderTimeId &&
          other.scheduledFor == this.scheduledFor &&
          other.action == this.action &&
          other.actionAt == this.actionAt &&
          other.snoozedUntil == this.snoozedUntil &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.routineNameSnapshot == this.routineNameSnapshot &&
          other.categorySnapshot == this.categorySnapshot);
}

class ReminderHistoryTableCompanion
    extends UpdateCompanion<ReminderHistoryRow> {
  final Value<String> id;
  final Value<String> routineId;
  final Value<String?> reminderTimeId;
  final Value<DateTime> scheduledFor;
  final Value<String> action;
  final Value<DateTime?> actionAt;
  final Value<DateTime?> snoozedUntil;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<String?> routineNameSnapshot;
  final Value<String?> categorySnapshot;
  final Value<int> rowid;
  const ReminderHistoryTableCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.reminderTimeId = const Value.absent(),
    this.scheduledFor = const Value.absent(),
    this.action = const Value.absent(),
    this.actionAt = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.routineNameSnapshot = const Value.absent(),
    this.categorySnapshot = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReminderHistoryTableCompanion.insert({
    required String id,
    required String routineId,
    this.reminderTimeId = const Value.absent(),
    required DateTime scheduledFor,
    required String action,
    this.actionAt = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    this.routineNameSnapshot = const Value.absent(),
    this.categorySnapshot = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       routineId = Value(routineId),
       scheduledFor = Value(scheduledFor),
       action = Value(action),
       createdAt = Value(createdAt);
  static Insertable<ReminderHistoryRow> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<String>? reminderTimeId,
    Expression<DateTime>? scheduledFor,
    Expression<String>? action,
    Expression<DateTime>? actionAt,
    Expression<DateTime>? snoozedUntil,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<String>? routineNameSnapshot,
    Expression<String>? categorySnapshot,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (reminderTimeId != null) 'reminder_time_id': reminderTimeId,
      if (scheduledFor != null) 'scheduled_for': scheduledFor,
      if (action != null) 'action': action,
      if (actionAt != null) 'action_at': actionAt,
      if (snoozedUntil != null) 'snoozed_until': snoozedUntil,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (routineNameSnapshot != null)
        'routine_name_snapshot': routineNameSnapshot,
      if (categorySnapshot != null) 'category_snapshot': categorySnapshot,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReminderHistoryTableCompanion copyWith({
    Value<String>? id,
    Value<String>? routineId,
    Value<String?>? reminderTimeId,
    Value<DateTime>? scheduledFor,
    Value<String>? action,
    Value<DateTime?>? actionAt,
    Value<DateTime?>? snoozedUntil,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<String?>? routineNameSnapshot,
    Value<String?>? categorySnapshot,
    Value<int>? rowid,
  }) {
    return ReminderHistoryTableCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      reminderTimeId: reminderTimeId ?? this.reminderTimeId,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      action: action ?? this.action,
      actionAt: actionAt ?? this.actionAt,
      snoozedUntil: snoozedUntil ?? this.snoozedUntil,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      routineNameSnapshot: routineNameSnapshot ?? this.routineNameSnapshot,
      categorySnapshot: categorySnapshot ?? this.categorySnapshot,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (reminderTimeId.present) {
      map['reminder_time_id'] = Variable<String>(reminderTimeId.value);
    }
    if (scheduledFor.present) {
      map['scheduled_for'] = Variable<DateTime>(scheduledFor.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (actionAt.present) {
      map['action_at'] = Variable<DateTime>(actionAt.value);
    }
    if (snoozedUntil.present) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (routineNameSnapshot.present) {
      map['routine_name_snapshot'] = Variable<String>(
        routineNameSnapshot.value,
      );
    }
    if (categorySnapshot.present) {
      map['category_snapshot'] = Variable<String>(categorySnapshot.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('reminderTimeId: $reminderTimeId, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('action: $action, ')
          ..write('actionAt: $actionAt, ')
          ..write('snoozedUntil: $snoozedUntil, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('routineNameSnapshot: $routineNameSnapshot, ')
          ..write('categorySnapshot: $categorySnapshot, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTableTable extends AppSettingsTable
    with TableInfo<$AppSettingsTableTable, AppSettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _accentStyleMeta = const VerificationMeta(
    'accentStyle',
  );
  @override
  late final GeneratedColumn<String> accentStyle = GeneratedColumn<String>(
    'accent_style',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('default'),
  );
  static const VerificationMeta _useDynamicColorMeta = const VerificationMeta(
    'useDynamicColor',
  );
  @override
  late final GeneratedColumn<bool> useDynamicColor = GeneratedColumn<bool>(
    'use_dynamic_color',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use_dynamic_color" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _timeFormatMeta = const VerificationMeta(
    'timeFormat',
  );
  @override
  late final GeneratedColumn<String> timeFormat = GeneratedColumn<String>(
    'time_format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _defaultSnoozeMinutesMeta =
      const VerificationMeta('defaultSnoozeMinutes');
  @override
  late final GeneratedColumn<int> defaultSnoozeMinutes = GeneratedColumn<int>(
    'default_snooze_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _defaultVibrationMeta = const VerificationMeta(
    'defaultVibration',
  );
  @override
  late final GeneratedColumn<bool> defaultVibration = GeneratedColumn<bool>(
    'default_vibration',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("default_vibration" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notificationEducationSeenMeta =
      const VerificationMeta('notificationEducationSeen');
  @override
  late final GeneratedColumn<bool> notificationEducationSeen =
      GeneratedColumn<bool>(
        'notification_education_seen',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notification_education_seen" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    themeMode,
    accentStyle,
    useDynamicColor,
    timeFormat,
    defaultSnoozeMinutes,
    defaultVibration,
    onboardingCompleted,
    notificationEducationSeen,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('accent_style')) {
      context.handle(
        _accentStyleMeta,
        accentStyle.isAcceptableOrUnknown(
          data['accent_style']!,
          _accentStyleMeta,
        ),
      );
    }
    if (data.containsKey('use_dynamic_color')) {
      context.handle(
        _useDynamicColorMeta,
        useDynamicColor.isAcceptableOrUnknown(
          data['use_dynamic_color']!,
          _useDynamicColorMeta,
        ),
      );
    }
    if (data.containsKey('time_format')) {
      context.handle(
        _timeFormatMeta,
        timeFormat.isAcceptableOrUnknown(data['time_format']!, _timeFormatMeta),
      );
    }
    if (data.containsKey('default_snooze_minutes')) {
      context.handle(
        _defaultSnoozeMinutesMeta,
        defaultSnoozeMinutes.isAcceptableOrUnknown(
          data['default_snooze_minutes']!,
          _defaultSnoozeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('default_vibration')) {
      context.handle(
        _defaultVibrationMeta,
        defaultVibration.isAcceptableOrUnknown(
          data['default_vibration']!,
          _defaultVibrationMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    }
    if (data.containsKey('notification_education_seen')) {
      context.handle(
        _notificationEducationSeenMeta,
        notificationEducationSeen.isAcceptableOrUnknown(
          data['notification_education_seen']!,
          _notificationEducationSeenMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      accentStyle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent_style'],
      )!,
      useDynamicColor: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use_dynamic_color'],
      )!,
      timeFormat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_format'],
      )!,
      defaultSnoozeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_snooze_minutes'],
      )!,
      defaultVibration: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}default_vibration'],
      )!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
      notificationEducationSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notification_education_seen'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTableTable createAlias(String alias) {
    return $AppSettingsTableTable(attachedDatabase, alias);
  }
}

class AppSettingsRow extends DataClass implements Insertable<AppSettingsRow> {
  final int id;
  final String themeMode;
  final String accentStyle;
  final bool useDynamicColor;
  final String timeFormat;
  final int defaultSnoozeMinutes;
  final bool defaultVibration;
  final bool onboardingCompleted;
  final bool notificationEducationSeen;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AppSettingsRow({
    required this.id,
    required this.themeMode,
    required this.accentStyle,
    required this.useDynamicColor,
    required this.timeFormat,
    required this.defaultSnoozeMinutes,
    required this.defaultVibration,
    required this.onboardingCompleted,
    required this.notificationEducationSeen,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['theme_mode'] = Variable<String>(themeMode);
    map['accent_style'] = Variable<String>(accentStyle);
    map['use_dynamic_color'] = Variable<bool>(useDynamicColor);
    map['time_format'] = Variable<String>(timeFormat);
    map['default_snooze_minutes'] = Variable<int>(defaultSnoozeMinutes);
    map['default_vibration'] = Variable<bool>(defaultVibration);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    map['notification_education_seen'] = Variable<bool>(
      notificationEducationSeen,
    );
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTableCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      accentStyle: Value(accentStyle),
      useDynamicColor: Value(useDynamicColor),
      timeFormat: Value(timeFormat),
      defaultSnoozeMinutes: Value(defaultSnoozeMinutes),
      defaultVibration: Value(defaultVibration),
      onboardingCompleted: Value(onboardingCompleted),
      notificationEducationSeen: Value(notificationEducationSeen),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsRow(
      id: serializer.fromJson<int>(json['id']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      accentStyle: serializer.fromJson<String>(json['accentStyle']),
      useDynamicColor: serializer.fromJson<bool>(json['useDynamicColor']),
      timeFormat: serializer.fromJson<String>(json['timeFormat']),
      defaultSnoozeMinutes: serializer.fromJson<int>(
        json['defaultSnoozeMinutes'],
      ),
      defaultVibration: serializer.fromJson<bool>(json['defaultVibration']),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
      notificationEducationSeen: serializer.fromJson<bool>(
        json['notificationEducationSeen'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<String>(themeMode),
      'accentStyle': serializer.toJson<String>(accentStyle),
      'useDynamicColor': serializer.toJson<bool>(useDynamicColor),
      'timeFormat': serializer.toJson<String>(timeFormat),
      'defaultSnoozeMinutes': serializer.toJson<int>(defaultSnoozeMinutes),
      'defaultVibration': serializer.toJson<bool>(defaultVibration),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'notificationEducationSeen': serializer.toJson<bool>(
        notificationEducationSeen,
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSettingsRow copyWith({
    int? id,
    String? themeMode,
    String? accentStyle,
    bool? useDynamicColor,
    String? timeFormat,
    int? defaultSnoozeMinutes,
    bool? defaultVibration,
    bool? onboardingCompleted,
    bool? notificationEducationSeen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AppSettingsRow(
    id: id ?? this.id,
    themeMode: themeMode ?? this.themeMode,
    accentStyle: accentStyle ?? this.accentStyle,
    useDynamicColor: useDynamicColor ?? this.useDynamicColor,
    timeFormat: timeFormat ?? this.timeFormat,
    defaultSnoozeMinutes: defaultSnoozeMinutes ?? this.defaultSnoozeMinutes,
    defaultVibration: defaultVibration ?? this.defaultVibration,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    notificationEducationSeen:
        notificationEducationSeen ?? this.notificationEducationSeen,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AppSettingsRow copyWithCompanion(AppSettingsTableCompanion data) {
    return AppSettingsRow(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      accentStyle: data.accentStyle.present
          ? data.accentStyle.value
          : this.accentStyle,
      useDynamicColor: data.useDynamicColor.present
          ? data.useDynamicColor.value
          : this.useDynamicColor,
      timeFormat: data.timeFormat.present
          ? data.timeFormat.value
          : this.timeFormat,
      defaultSnoozeMinutes: data.defaultSnoozeMinutes.present
          ? data.defaultSnoozeMinutes.value
          : this.defaultSnoozeMinutes,
      defaultVibration: data.defaultVibration.present
          ? data.defaultVibration.value
          : this.defaultVibration,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      notificationEducationSeen: data.notificationEducationSeen.present
          ? data.notificationEducationSeen.value
          : this.notificationEducationSeen,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsRow(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('accentStyle: $accentStyle, ')
          ..write('useDynamicColor: $useDynamicColor, ')
          ..write('timeFormat: $timeFormat, ')
          ..write('defaultSnoozeMinutes: $defaultSnoozeMinutes, ')
          ..write('defaultVibration: $defaultVibration, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('notificationEducationSeen: $notificationEducationSeen, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    themeMode,
    accentStyle,
    useDynamicColor,
    timeFormat,
    defaultSnoozeMinutes,
    defaultVibration,
    onboardingCompleted,
    notificationEducationSeen,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsRow &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.accentStyle == this.accentStyle &&
          other.useDynamicColor == this.useDynamicColor &&
          other.timeFormat == this.timeFormat &&
          other.defaultSnoozeMinutes == this.defaultSnoozeMinutes &&
          other.defaultVibration == this.defaultVibration &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.notificationEducationSeen == this.notificationEducationSeen &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsTableCompanion extends UpdateCompanion<AppSettingsRow> {
  final Value<int> id;
  final Value<String> themeMode;
  final Value<String> accentStyle;
  final Value<bool> useDynamicColor;
  final Value<String> timeFormat;
  final Value<int> defaultSnoozeMinutes;
  final Value<bool> defaultVibration;
  final Value<bool> onboardingCompleted;
  final Value<bool> notificationEducationSeen;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AppSettingsTableCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.accentStyle = const Value.absent(),
    this.useDynamicColor = const Value.absent(),
    this.timeFormat = const Value.absent(),
    this.defaultSnoozeMinutes = const Value.absent(),
    this.defaultVibration = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.notificationEducationSeen = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.accentStyle = const Value.absent(),
    this.useDynamicColor = const Value.absent(),
    this.timeFormat = const Value.absent(),
    this.defaultSnoozeMinutes = const Value.absent(),
    this.defaultVibration = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.notificationEducationSeen = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AppSettingsRow> custom({
    Expression<int>? id,
    Expression<String>? themeMode,
    Expression<String>? accentStyle,
    Expression<bool>? useDynamicColor,
    Expression<String>? timeFormat,
    Expression<int>? defaultSnoozeMinutes,
    Expression<bool>? defaultVibration,
    Expression<bool>? onboardingCompleted,
    Expression<bool>? notificationEducationSeen,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (accentStyle != null) 'accent_style': accentStyle,
      if (useDynamicColor != null) 'use_dynamic_color': useDynamicColor,
      if (timeFormat != null) 'time_format': timeFormat,
      if (defaultSnoozeMinutes != null)
        'default_snooze_minutes': defaultSnoozeMinutes,
      if (defaultVibration != null) 'default_vibration': defaultVibration,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (notificationEducationSeen != null)
        'notification_education_seen': notificationEducationSeen,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppSettingsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? themeMode,
    Value<String>? accentStyle,
    Value<bool>? useDynamicColor,
    Value<String>? timeFormat,
    Value<int>? defaultSnoozeMinutes,
    Value<bool>? defaultVibration,
    Value<bool>? onboardingCompleted,
    Value<bool>? notificationEducationSeen,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return AppSettingsTableCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      accentStyle: accentStyle ?? this.accentStyle,
      useDynamicColor: useDynamicColor ?? this.useDynamicColor,
      timeFormat: timeFormat ?? this.timeFormat,
      defaultSnoozeMinutes: defaultSnoozeMinutes ?? this.defaultSnoozeMinutes,
      defaultVibration: defaultVibration ?? this.defaultVibration,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      notificationEducationSeen:
          notificationEducationSeen ?? this.notificationEducationSeen,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (accentStyle.present) {
      map['accent_style'] = Variable<String>(accentStyle.value);
    }
    if (useDynamicColor.present) {
      map['use_dynamic_color'] = Variable<bool>(useDynamicColor.value);
    }
    if (timeFormat.present) {
      map['time_format'] = Variable<String>(timeFormat.value);
    }
    if (defaultSnoozeMinutes.present) {
      map['default_snooze_minutes'] = Variable<int>(defaultSnoozeMinutes.value);
    }
    if (defaultVibration.present) {
      map['default_vibration'] = Variable<bool>(defaultVibration.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (notificationEducationSeen.present) {
      map['notification_education_seen'] = Variable<bool>(
        notificationEducationSeen.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('accentStyle: $accentStyle, ')
          ..write('useDynamicColor: $useDynamicColor, ')
          ..write('timeFormat: $timeFormat, ')
          ..write('defaultSnoozeMinutes: $defaultSnoozeMinutes, ')
          ..write('defaultVibration: $defaultVibration, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('notificationEducationSeen: $notificationEducationSeen, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RoutinesTableTable routinesTable = $RoutinesTableTable(this);
  late final $ReminderTimesTableTable reminderTimesTable =
      $ReminderTimesTableTable(this);
  late final $AudioRecordingsTableTable audioRecordingsTable =
      $AudioRecordingsTableTable(this);
  late final $ReminderHistoryTableTable reminderHistoryTable =
      $ReminderHistoryTableTable(this);
  late final $AppSettingsTableTable appSettingsTable = $AppSettingsTableTable(
    this,
  );
  late final RoutineDao routineDao = RoutineDao(this as AppDatabase);
  late final ReminderHistoryDao reminderHistoryDao = ReminderHistoryDao(
    this as AppDatabase,
  );
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    routinesTable,
    reminderTimesTable,
    audioRecordingsTable,
    reminderHistoryTable,
    appSettingsTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'routines',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reminder_times', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$RoutinesTableTableCreateCompanionBuilder =
    RoutinesTableCompanion Function({
      required String id,
      required String name,
      required String category,
      Value<String?> actionVerb,
      Value<String?> dosageText,
      Value<String?> instructions,
      required String iconKey,
      required String colorKey,
      Value<bool> isActive,
      Value<bool> isArchived,
      required DateTime startDate,
      Value<DateTime?> endDate,
      required int weekdaysMask,
      required String soundMode,
      Value<String?> audioId,
      Value<bool> vibrationEnabled,
      Value<bool> snoozeEnabled,
      Value<int> snoozeMinutes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$RoutinesTableTableUpdateCompanionBuilder =
    RoutinesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> category,
      Value<String?> actionVerb,
      Value<String?> dosageText,
      Value<String?> instructions,
      Value<String> iconKey,
      Value<String> colorKey,
      Value<bool> isActive,
      Value<bool> isArchived,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<int> weekdaysMask,
      Value<String> soundMode,
      Value<String?> audioId,
      Value<bool> vibrationEnabled,
      Value<bool> snoozeEnabled,
      Value<int> snoozeMinutes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$RoutinesTableTableReferences
    extends BaseReferences<_$AppDatabase, $RoutinesTableTable, RoutineRow> {
  $$RoutinesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ReminderTimesTableTable, List<ReminderTimeRow>>
  _reminderTimesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.reminderTimesTable,
        aliasName: 'routines__id__reminder_times__routine_id',
      );

  $$ReminderTimesTableTableProcessedTableManager get reminderTimesTableRefs {
    final manager = $$ReminderTimesTableTableTableManager(
      $_db,
      $_db.reminderTimesTable,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _reminderTimesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoutinesTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoutinesTableTable> {
  $$RoutinesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionVerb => $composableBuilder(
    column: $table.actionVerb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dosageText => $composableBuilder(
    column: $table.dosageText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorKey => $composableBuilder(
    column: $table.colorKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get soundMode => $composableBuilder(
    column: $table.soundMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioId => $composableBuilder(
    column: $table.audioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get vibrationEnabled => $composableBuilder(
    column: $table.vibrationEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get snoozeEnabled => $composableBuilder(
    column: $table.snoozeEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> reminderTimesTableRefs(
    Expression<bool> Function($$ReminderTimesTableTableFilterComposer f) f,
  ) {
    final $$ReminderTimesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminderTimesTable,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderTimesTableTableFilterComposer(
            $db: $db,
            $table: $db.reminderTimesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutinesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutinesTableTable> {
  $$RoutinesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionVerb => $composableBuilder(
    column: $table.actionVerb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dosageText => $composableBuilder(
    column: $table.dosageText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorKey => $composableBuilder(
    column: $table.colorKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get soundMode => $composableBuilder(
    column: $table.soundMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioId => $composableBuilder(
    column: $table.audioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get vibrationEnabled => $composableBuilder(
    column: $table.vibrationEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get snoozeEnabled => $composableBuilder(
    column: $table.snoozeEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutinesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutinesTableTable> {
  $$RoutinesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get actionVerb => $composableBuilder(
    column: $table.actionVerb,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dosageText => $composableBuilder(
    column: $table.dosageText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<String> get colorKey =>
      $composableBuilder(column: $table.colorKey, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get weekdaysMask => $composableBuilder(
    column: $table.weekdaysMask,
    builder: (column) => column,
  );

  GeneratedColumn<String> get soundMode =>
      $composableBuilder(column: $table.soundMode, builder: (column) => column);

  GeneratedColumn<String> get audioId =>
      $composableBuilder(column: $table.audioId, builder: (column) => column);

  GeneratedColumn<bool> get vibrationEnabled => $composableBuilder(
    column: $table.vibrationEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get snoozeEnabled => $composableBuilder(
    column: $table.snoozeEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> reminderTimesTableRefs<T extends Object>(
    Expression<T> Function($$ReminderTimesTableTableAnnotationComposer a) f,
  ) {
    final $$ReminderTimesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.reminderTimesTable,
          getReferencedColumn: (t) => t.routineId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ReminderTimesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.reminderTimesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RoutinesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutinesTableTable,
          RoutineRow,
          $$RoutinesTableTableFilterComposer,
          $$RoutinesTableTableOrderingComposer,
          $$RoutinesTableTableAnnotationComposer,
          $$RoutinesTableTableCreateCompanionBuilder,
          $$RoutinesTableTableUpdateCompanionBuilder,
          (RoutineRow, $$RoutinesTableTableReferences),
          RoutineRow,
          PrefetchHooks Function({bool reminderTimesTableRefs})
        > {
  $$RoutinesTableTableTableManager(_$AppDatabase db, $RoutinesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutinesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutinesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutinesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> actionVerb = const Value.absent(),
                Value<String?> dosageText = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<String> colorKey = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<int> weekdaysMask = const Value.absent(),
                Value<String> soundMode = const Value.absent(),
                Value<String?> audioId = const Value.absent(),
                Value<bool> vibrationEnabled = const Value.absent(),
                Value<bool> snoozeEnabled = const Value.absent(),
                Value<int> snoozeMinutes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutinesTableCompanion(
                id: id,
                name: name,
                category: category,
                actionVerb: actionVerb,
                dosageText: dosageText,
                instructions: instructions,
                iconKey: iconKey,
                colorKey: colorKey,
                isActive: isActive,
                isArchived: isArchived,
                startDate: startDate,
                endDate: endDate,
                weekdaysMask: weekdaysMask,
                soundMode: soundMode,
                audioId: audioId,
                vibrationEnabled: vibrationEnabled,
                snoozeEnabled: snoozeEnabled,
                snoozeMinutes: snoozeMinutes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String category,
                Value<String?> actionVerb = const Value.absent(),
                Value<String?> dosageText = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                required String iconKey,
                required String colorKey,
                Value<bool> isActive = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                required int weekdaysMask,
                required String soundMode,
                Value<String?> audioId = const Value.absent(),
                Value<bool> vibrationEnabled = const Value.absent(),
                Value<bool> snoozeEnabled = const Value.absent(),
                Value<int> snoozeMinutes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RoutinesTableCompanion.insert(
                id: id,
                name: name,
                category: category,
                actionVerb: actionVerb,
                dosageText: dosageText,
                instructions: instructions,
                iconKey: iconKey,
                colorKey: colorKey,
                isActive: isActive,
                isArchived: isArchived,
                startDate: startDate,
                endDate: endDate,
                weekdaysMask: weekdaysMask,
                soundMode: soundMode,
                audioId: audioId,
                vibrationEnabled: vibrationEnabled,
                snoozeEnabled: snoozeEnabled,
                snoozeMinutes: snoozeMinutes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoutinesTableTable, RoutineRow>(table),
                  $$RoutinesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reminderTimesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (reminderTimesTableRefs) db.reminderTimesTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reminderTimesTableRefs)
                    await $_getPrefetchedData<
                      RoutineRow,
                      $RoutinesTableTable,
                      ReminderTimeRow
                    >(
                      currentTable: table,
                      referencedTable: $$RoutinesTableTableReferences
                          ._reminderTimesTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RoutinesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).reminderTimesTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.routineId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RoutinesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutinesTableTable,
      RoutineRow,
      $$RoutinesTableTableFilterComposer,
      $$RoutinesTableTableOrderingComposer,
      $$RoutinesTableTableAnnotationComposer,
      $$RoutinesTableTableCreateCompanionBuilder,
      $$RoutinesTableTableUpdateCompanionBuilder,
      (RoutineRow, $$RoutinesTableTableReferences),
      RoutineRow,
      PrefetchHooks Function({bool reminderTimesTableRefs})
    >;
typedef $$ReminderTimesTableTableCreateCompanionBuilder =
    ReminderTimesTableCompanion Function({
      required String id,
      required String routineId,
      required int hour,
      required int minute,
      Value<int> sortOrder,
      Value<bool> isEnabled,
      required int notificationId,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ReminderTimesTableTableUpdateCompanionBuilder =
    ReminderTimesTableCompanion Function({
      Value<String> id,
      Value<String> routineId,
      Value<int> hour,
      Value<int> minute,
      Value<int> sortOrder,
      Value<bool> isEnabled,
      Value<int> notificationId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ReminderTimesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ReminderTimesTableTable,
          ReminderTimeRow
        > {
  $$ReminderTimesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RoutinesTableTable _routineIdTable(_$AppDatabase db) =>
      db.routinesTable.createAlias('reminder_times__routine_id__routines__id');

  $$RoutinesTableTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<String>('routine_id')!;

    final manager = $$RoutinesTableTableTableManager(
      $_db,
      $_db.routinesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReminderTimesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ReminderTimesTableTable> {
  $$ReminderTimesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RoutinesTableTableFilterComposer get routineId {
    final $$RoutinesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routinesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableTableFilterComposer(
            $db: $db,
            $table: $db.routinesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderTimesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ReminderTimesTableTable> {
  $$ReminderTimesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoutinesTableTableOrderingComposer get routineId {
    final $$RoutinesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routinesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableTableOrderingComposer(
            $db: $db,
            $table: $db.routinesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderTimesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReminderTimesTableTable> {
  $$ReminderTimesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get hour =>
      $composableBuilder(column: $table.hour, builder: (column) => column);

  GeneratedColumn<int> get minute =>
      $composableBuilder(column: $table.minute, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$RoutinesTableTableAnnotationComposer get routineId {
    final $$RoutinesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routinesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutinesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.routinesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderTimesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReminderTimesTableTable,
          ReminderTimeRow,
          $$ReminderTimesTableTableFilterComposer,
          $$ReminderTimesTableTableOrderingComposer,
          $$ReminderTimesTableTableAnnotationComposer,
          $$ReminderTimesTableTableCreateCompanionBuilder,
          $$ReminderTimesTableTableUpdateCompanionBuilder,
          (ReminderTimeRow, $$ReminderTimesTableTableReferences),
          ReminderTimeRow,
          PrefetchHooks Function({bool routineId})
        > {
  $$ReminderTimesTableTableTableManager(
    _$AppDatabase db,
    $ReminderTimesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderTimesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderTimesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReminderTimesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> routineId = const Value.absent(),
                Value<int> hour = const Value.absent(),
                Value<int> minute = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> notificationId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReminderTimesTableCompanion(
                id: id,
                routineId: routineId,
                hour: hour,
                minute: minute,
                sortOrder: sortOrder,
                isEnabled: isEnabled,
                notificationId: notificationId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String routineId,
                required int hour,
                required int minute,
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                required int notificationId,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ReminderTimesTableCompanion.insert(
                id: id,
                routineId: routineId,
                hour: hour,
                minute: minute,
                sortOrder: sortOrder,
                isEnabled: isEnabled,
                notificationId: notificationId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReminderTimesTableTable, ReminderTimeRow>(table),
                  $$ReminderTimesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (routineId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.routineId,
                                referencedTable:
                                    $$ReminderTimesTableTableReferences
                                        ._routineIdTable(db),
                                referencedColumn:
                                    $$ReminderTimesTableTableReferences
                                        ._routineIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReminderTimesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReminderTimesTableTable,
      ReminderTimeRow,
      $$ReminderTimesTableTableFilterComposer,
      $$ReminderTimesTableTableOrderingComposer,
      $$ReminderTimesTableTableAnnotationComposer,
      $$ReminderTimesTableTableCreateCompanionBuilder,
      $$ReminderTimesTableTableUpdateCompanionBuilder,
      (ReminderTimeRow, $$ReminderTimesTableTableReferences),
      ReminderTimeRow,
      PrefetchHooks Function({bool routineId})
    >;
typedef $$AudioRecordingsTableTableCreateCompanionBuilder =
    AudioRecordingsTableCompanion Function({
      required String id,
      required String localPath,
      Value<String?> iosSoundFilename,
      Value<String> codec,
      required int durationMs,
      Value<int?> fileSizeBytes,
      Value<int> revision,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AudioRecordingsTableTableUpdateCompanionBuilder =
    AudioRecordingsTableCompanion Function({
      Value<String> id,
      Value<String> localPath,
      Value<String?> iosSoundFilename,
      Value<String> codec,
      Value<int> durationMs,
      Value<int?> fileSizeBytes,
      Value<int> revision,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AudioRecordingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AudioRecordingsTableTable> {
  $$AudioRecordingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iosSoundFilename => $composableBuilder(
    column: $table.iosSoundFilename,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codec => $composableBuilder(
    column: $table.codec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AudioRecordingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AudioRecordingsTableTable> {
  $$AudioRecordingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iosSoundFilename => $composableBuilder(
    column: $table.iosSoundFilename,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codec => $composableBuilder(
    column: $table.codec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AudioRecordingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AudioRecordingsTableTable> {
  $$AudioRecordingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get iosSoundFilename => $composableBuilder(
    column: $table.iosSoundFilename,
    builder: (column) => column,
  );

  GeneratedColumn<String> get codec =>
      $composableBuilder(column: $table.codec, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AudioRecordingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AudioRecordingsTableTable,
          AudioRecordingRow,
          $$AudioRecordingsTableTableFilterComposer,
          $$AudioRecordingsTableTableOrderingComposer,
          $$AudioRecordingsTableTableAnnotationComposer,
          $$AudioRecordingsTableTableCreateCompanionBuilder,
          $$AudioRecordingsTableTableUpdateCompanionBuilder,
          (
            AudioRecordingRow,
            BaseReferences<
              _$AppDatabase,
              $AudioRecordingsTableTable,
              AudioRecordingRow
            >,
          ),
          AudioRecordingRow,
          PrefetchHooks Function()
        > {
  $$AudioRecordingsTableTableTableManager(
    _$AppDatabase db,
    $AudioRecordingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AudioRecordingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AudioRecordingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AudioRecordingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<String?> iosSoundFilename = const Value.absent(),
                Value<String> codec = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                Value<int?> fileSizeBytes = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AudioRecordingsTableCompanion(
                id: id,
                localPath: localPath,
                iosSoundFilename: iosSoundFilename,
                codec: codec,
                durationMs: durationMs,
                fileSizeBytes: fileSizeBytes,
                revision: revision,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String localPath,
                Value<String?> iosSoundFilename = const Value.absent(),
                Value<String> codec = const Value.absent(),
                required int durationMs,
                Value<int?> fileSizeBytes = const Value.absent(),
                Value<int> revision = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AudioRecordingsTableCompanion.insert(
                id: id,
                localPath: localPath,
                iosSoundFilename: iosSoundFilename,
                codec: codec,
                durationMs: durationMs,
                fileSizeBytes: fileSizeBytes,
                revision: revision,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AudioRecordingsTableTable, AudioRecordingRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $AudioRecordingsTableTable,
                    AudioRecordingRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AudioRecordingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AudioRecordingsTableTable,
      AudioRecordingRow,
      $$AudioRecordingsTableTableFilterComposer,
      $$AudioRecordingsTableTableOrderingComposer,
      $$AudioRecordingsTableTableAnnotationComposer,
      $$AudioRecordingsTableTableCreateCompanionBuilder,
      $$AudioRecordingsTableTableUpdateCompanionBuilder,
      (
        AudioRecordingRow,
        BaseReferences<
          _$AppDatabase,
          $AudioRecordingsTableTable,
          AudioRecordingRow
        >,
      ),
      AudioRecordingRow,
      PrefetchHooks Function()
    >;
typedef $$ReminderHistoryTableTableCreateCompanionBuilder =
    ReminderHistoryTableCompanion Function({
      required String id,
      required String routineId,
      Value<String?> reminderTimeId,
      required DateTime scheduledFor,
      required String action,
      Value<DateTime?> actionAt,
      Value<DateTime?> snoozedUntil,
      Value<String?> note,
      required DateTime createdAt,
      Value<String?> routineNameSnapshot,
      Value<String?> categorySnapshot,
      Value<int> rowid,
    });
typedef $$ReminderHistoryTableTableUpdateCompanionBuilder =
    ReminderHistoryTableCompanion Function({
      Value<String> id,
      Value<String> routineId,
      Value<String?> reminderTimeId,
      Value<DateTime> scheduledFor,
      Value<String> action,
      Value<DateTime?> actionAt,
      Value<DateTime?> snoozedUntil,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<String?> routineNameSnapshot,
      Value<String?> categorySnapshot,
      Value<int> rowid,
    });

class $$ReminderHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $ReminderHistoryTableTable> {
  $$ReminderHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderTimeId => $composableBuilder(
    column: $table.reminderTimeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actionAt => $composableBuilder(
    column: $table.actionAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routineNameSnapshot => $composableBuilder(
    column: $table.routineNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categorySnapshot => $composableBuilder(
    column: $table.categorySnapshot,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReminderHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ReminderHistoryTableTable> {
  $$ReminderHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderTimeId => $composableBuilder(
    column: $table.reminderTimeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actionAt => $composableBuilder(
    column: $table.actionAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routineNameSnapshot => $composableBuilder(
    column: $table.routineNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categorySnapshot => $composableBuilder(
    column: $table.categorySnapshot,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReminderHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReminderHistoryTableTable> {
  $$ReminderHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get routineId =>
      $composableBuilder(column: $table.routineId, builder: (column) => column);

  GeneratedColumn<String> get reminderTimeId => $composableBuilder(
    column: $table.reminderTimeId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<DateTime> get actionAt =>
      $composableBuilder(column: $table.actionAt, builder: (column) => column);

  GeneratedColumn<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get routineNameSnapshot => $composableBuilder(
    column: $table.routineNameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categorySnapshot => $composableBuilder(
    column: $table.categorySnapshot,
    builder: (column) => column,
  );
}

class $$ReminderHistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReminderHistoryTableTable,
          ReminderHistoryRow,
          $$ReminderHistoryTableTableFilterComposer,
          $$ReminderHistoryTableTableOrderingComposer,
          $$ReminderHistoryTableTableAnnotationComposer,
          $$ReminderHistoryTableTableCreateCompanionBuilder,
          $$ReminderHistoryTableTableUpdateCompanionBuilder,
          (
            ReminderHistoryRow,
            BaseReferences<
              _$AppDatabase,
              $ReminderHistoryTableTable,
              ReminderHistoryRow
            >,
          ),
          ReminderHistoryRow,
          PrefetchHooks Function()
        > {
  $$ReminderHistoryTableTableTableManager(
    _$AppDatabase db,
    $ReminderHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderHistoryTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ReminderHistoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> routineId = const Value.absent(),
                Value<String?> reminderTimeId = const Value.absent(),
                Value<DateTime> scheduledFor = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<DateTime?> actionAt = const Value.absent(),
                Value<DateTime?> snoozedUntil = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> routineNameSnapshot = const Value.absent(),
                Value<String?> categorySnapshot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReminderHistoryTableCompanion(
                id: id,
                routineId: routineId,
                reminderTimeId: reminderTimeId,
                scheduledFor: scheduledFor,
                action: action,
                actionAt: actionAt,
                snoozedUntil: snoozedUntil,
                note: note,
                createdAt: createdAt,
                routineNameSnapshot: routineNameSnapshot,
                categorySnapshot: categorySnapshot,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String routineId,
                Value<String?> reminderTimeId = const Value.absent(),
                required DateTime scheduledFor,
                required String action,
                Value<DateTime?> actionAt = const Value.absent(),
                Value<DateTime?> snoozedUntil = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                Value<String?> routineNameSnapshot = const Value.absent(),
                Value<String?> categorySnapshot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReminderHistoryTableCompanion.insert(
                id: id,
                routineId: routineId,
                reminderTimeId: reminderTimeId,
                scheduledFor: scheduledFor,
                action: action,
                actionAt: actionAt,
                snoozedUntil: snoozedUntil,
                note: note,
                createdAt: createdAt,
                routineNameSnapshot: routineNameSnapshot,
                categorySnapshot: categorySnapshot,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReminderHistoryTableTable, ReminderHistoryRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ReminderHistoryTableTable,
                    ReminderHistoryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReminderHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReminderHistoryTableTable,
      ReminderHistoryRow,
      $$ReminderHistoryTableTableFilterComposer,
      $$ReminderHistoryTableTableOrderingComposer,
      $$ReminderHistoryTableTableAnnotationComposer,
      $$ReminderHistoryTableTableCreateCompanionBuilder,
      $$ReminderHistoryTableTableUpdateCompanionBuilder,
      (
        ReminderHistoryRow,
        BaseReferences<
          _$AppDatabase,
          $ReminderHistoryTableTable,
          ReminderHistoryRow
        >,
      ),
      ReminderHistoryRow,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableTableCreateCompanionBuilder =
    AppSettingsTableCompanion Function({
      Value<int> id,
      Value<String> themeMode,
      Value<String> accentStyle,
      Value<bool> useDynamicColor,
      Value<String> timeFormat,
      Value<int> defaultSnoozeMinutes,
      Value<bool> defaultVibration,
      Value<bool> onboardingCompleted,
      Value<bool> notificationEducationSeen,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$AppSettingsTableTableUpdateCompanionBuilder =
    AppSettingsTableCompanion Function({
      Value<int> id,
      Value<String> themeMode,
      Value<String> accentStyle,
      Value<bool> useDynamicColor,
      Value<String> timeFormat,
      Value<int> defaultSnoozeMinutes,
      Value<bool> defaultVibration,
      Value<bool> onboardingCompleted,
      Value<bool> notificationEducationSeen,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$AppSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accentStyle => $composableBuilder(
    column: $table.accentStyle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get useDynamicColor => $composableBuilder(
    column: $table.useDynamicColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeFormat => $composableBuilder(
    column: $table.timeFormat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultSnoozeMinutes => $composableBuilder(
    column: $table.defaultSnoozeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get defaultVibration => $composableBuilder(
    column: $table.defaultVibration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationEducationSeen => $composableBuilder(
    column: $table.notificationEducationSeen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accentStyle => $composableBuilder(
    column: $table.accentStyle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get useDynamicColor => $composableBuilder(
    column: $table.useDynamicColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeFormat => $composableBuilder(
    column: $table.timeFormat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultSnoozeMinutes => $composableBuilder(
    column: $table.defaultSnoozeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get defaultVibration => $composableBuilder(
    column: $table.defaultVibration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationEducationSeen => $composableBuilder(
    column: $table.notificationEducationSeen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get accentStyle => $composableBuilder(
    column: $table.accentStyle,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get useDynamicColor => $composableBuilder(
    column: $table.useDynamicColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timeFormat => $composableBuilder(
    column: $table.timeFormat,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultSnoozeMinutes => $composableBuilder(
    column: $table.defaultSnoozeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get defaultVibration => $composableBuilder(
    column: $table.defaultVibration,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notificationEducationSeen => $composableBuilder(
    column: $table.notificationEducationSeen,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTableTable,
          AppSettingsRow,
          $$AppSettingsTableTableFilterComposer,
          $$AppSettingsTableTableOrderingComposer,
          $$AppSettingsTableTableAnnotationComposer,
          $$AppSettingsTableTableCreateCompanionBuilder,
          $$AppSettingsTableTableUpdateCompanionBuilder,
          (
            AppSettingsRow,
            BaseReferences<
              _$AppDatabase,
              $AppSettingsTableTable,
              AppSettingsRow
            >,
          ),
          AppSettingsRow,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableTableManager(
    _$AppDatabase db,
    $AppSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> accentStyle = const Value.absent(),
                Value<bool> useDynamicColor = const Value.absent(),
                Value<String> timeFormat = const Value.absent(),
                Value<int> defaultSnoozeMinutes = const Value.absent(),
                Value<bool> defaultVibration = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<bool> notificationEducationSeen = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AppSettingsTableCompanion(
                id: id,
                themeMode: themeMode,
                accentStyle: accentStyle,
                useDynamicColor: useDynamicColor,
                timeFormat: timeFormat,
                defaultSnoozeMinutes: defaultSnoozeMinutes,
                defaultVibration: defaultVibration,
                onboardingCompleted: onboardingCompleted,
                notificationEducationSeen: notificationEducationSeen,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> accentStyle = const Value.absent(),
                Value<bool> useDynamicColor = const Value.absent(),
                Value<String> timeFormat = const Value.absent(),
                Value<int> defaultSnoozeMinutes = const Value.absent(),
                Value<bool> defaultVibration = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<bool> notificationEducationSeen = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => AppSettingsTableCompanion.insert(
                id: id,
                themeMode: themeMode,
                accentStyle: accentStyle,
                useDynamicColor: useDynamicColor,
                timeFormat: timeFormat,
                defaultSnoozeMinutes: defaultSnoozeMinutes,
                defaultVibration: defaultVibration,
                onboardingCompleted: onboardingCompleted,
                notificationEducationSeen: notificationEducationSeen,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTableTable, AppSettingsRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AppSettingsTableTable,
                    AppSettingsRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTableTable,
      AppSettingsRow,
      $$AppSettingsTableTableFilterComposer,
      $$AppSettingsTableTableOrderingComposer,
      $$AppSettingsTableTableAnnotationComposer,
      $$AppSettingsTableTableCreateCompanionBuilder,
      $$AppSettingsTableTableUpdateCompanionBuilder,
      (
        AppSettingsRow,
        BaseReferences<_$AppDatabase, $AppSettingsTableTable, AppSettingsRow>,
      ),
      AppSettingsRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RoutinesTableTableTableManager get routinesTable =>
      $$RoutinesTableTableTableManager(_db, _db.routinesTable);
  $$ReminderTimesTableTableTableManager get reminderTimesTable =>
      $$ReminderTimesTableTableTableManager(_db, _db.reminderTimesTable);
  $$AudioRecordingsTableTableTableManager get audioRecordingsTable =>
      $$AudioRecordingsTableTableTableManager(_db, _db.audioRecordingsTable);
  $$ReminderHistoryTableTableTableManager get reminderHistoryTable =>
      $$ReminderHistoryTableTableTableManager(_db, _db.reminderHistoryTable);
  $$AppSettingsTableTableTableManager get appSettingsTable =>
      $$AppSettingsTableTableTableManager(_db, _db.appSettingsTable);
}
