// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorApplicationDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ApplicationDatabaseBuilder databaseBuilder(String name) =>
      _$ApplicationDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ApplicationDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$ApplicationDatabaseBuilder(null);
}

class _$ApplicationDatabaseBuilder {
  _$ApplicationDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$ApplicationDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ApplicationDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ApplicationDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ApplicationDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ApplicationDatabase extends ApplicationDatabase {
  _$ApplicationDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CreditCardDao? _creditCardDaoInstance;

  CreditDao? _creditDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CreditCard` (`name` TEXT NOT NULL, `color` INTEGER NOT NULL, `icon` INTEGER, `fee` REAL NOT NULL, `feeType` INTEGER NOT NULL, `due` INTEGER, PRIMARY KEY (`name`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Credit` (`name` TEXT NOT NULL, `card` TEXT, `loan` TEXT NOT NULL, `interest` TEXT NOT NULL, `installments` INTEGER NOT NULL, `payments` TEXT NOT NULL, PRIMARY KEY (`name`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CreditCardDao get creditCardDao {
    return _creditCardDaoInstance ??= _$CreditCardDao(database, changeListener);
  }

  @override
  CreditDao get creditDao {
    return _creditDaoInstance ??= _$CreditDao(database, changeListener);
  }
}

class _$CreditCardDao extends CreditCardDao {
  _$CreditCardDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _creditCardInsertionAdapter = InsertionAdapter(
            database,
            'CreditCard',
            (CreditCard item) => <String, Object?>{
                  'name': item.name,
                  'color': _colorConverter.encode(item.color),
                  'icon': _iconDataConverter.encode(item.icon),
                  'fee': item.fee,
                  'feeType': _feeTypeConverter.encode(item.feeType),
                  'due': item.due
                }),
        _creditCardUpdateAdapter = UpdateAdapter(
            database,
            'CreditCard',
            ['name'],
            (CreditCard item) => <String, Object?>{
                  'name': item.name,
                  'color': _colorConverter.encode(item.color),
                  'icon': _iconDataConverter.encode(item.icon),
                  'fee': item.fee,
                  'feeType': _feeTypeConverter.encode(item.feeType),
                  'due': item.due
                }),
        _creditCardDeletionAdapter = DeletionAdapter(
            database,
            'CreditCard',
            ['name'],
            (CreditCard item) => <String, Object?>{
                  'name': item.name,
                  'color': _colorConverter.encode(item.color),
                  'icon': _iconDataConverter.encode(item.icon),
                  'fee': item.fee,
                  'feeType': _feeTypeConverter.encode(item.feeType),
                  'due': item.due
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CreditCard> _creditCardInsertionAdapter;

  final UpdateAdapter<CreditCard> _creditCardUpdateAdapter;

  final DeletionAdapter<CreditCard> _creditCardDeletionAdapter;

  @override
  Future<List<CreditCard>> allCreditCards() async {
    return _queryAdapter.queryList('SELECT * FROM CreditCard',
        mapper: (Map<String, Object?> row) => CreditCard(
            name: row['name'] as String,
            color: _colorConverter.decode(row['color'] as int),
            icon: _iconDataConverter.decode(row['icon'] as int?),
            fee: row['fee'] as double,
            feeType: _feeTypeConverter.decode(row['feeType'] as int),
            due: row['due'] as int?));
  }

  @override
  Future<CreditCard?> getCreditCard(String name) async {
    return _queryAdapter.query('SELECT * FROM CreditCard WHERE name = ?1',
        mapper: (Map<String, Object?> row) => CreditCard(
            name: row['name'] as String,
            color: _colorConverter.decode(row['color'] as int),
            icon: _iconDataConverter.decode(row['icon'] as int?),
            fee: row['fee'] as double,
            feeType: _feeTypeConverter.decode(row['feeType'] as int),
            due: row['due'] as int?),
        arguments: [name]);
  }

  @override
  Future<List<Credit?>> cardCredits(String name) async {
    return _queryAdapter.queryList(
        'SELECT * FROM CreditCard p INNER JOIN Credit c ON c.card = p.name WHERE p.name = ?1',
        mapper: (Map<String, Object?> row) => Credit(name: row['name'] as String, card: row['card'] as String?, loan: _decimalConverter.decode(row['loan'] as String), interest: _decimalConverter.decode(row['interest'] as String), installments: row['installments'] as int, payments: _paymentListConverter.decode(row['payments'] as String)),
        arguments: [name]);
  }

  @override
  Future<void> insertCreditCard(CreditCard creditCard) async {
    await _creditCardInsertionAdapter.insert(
        creditCard, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCreditCard(CreditCard creditCard) async {
    await _creditCardUpdateAdapter.update(creditCard, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCreditCard(CreditCard creditCard) async {
    await _creditCardDeletionAdapter.delete(creditCard);
  }
}

class _$CreditDao extends CreditDao {
  _$CreditDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _creditInsertionAdapter = InsertionAdapter(
            database,
            'Credit',
            (Credit item) => <String, Object?>{
                  'name': item.name,
                  'card': item.card,
                  'loan': _decimalConverter.encode(item.loan),
                  'interest': _decimalConverter.encode(item.interest),
                  'installments': item.installments,
                  'payments': _paymentListConverter.encode(item.payments)
                }),
        _creditUpdateAdapter = UpdateAdapter(
            database,
            'Credit',
            ['name'],
            (Credit item) => <String, Object?>{
                  'name': item.name,
                  'card': item.card,
                  'loan': _decimalConverter.encode(item.loan),
                  'interest': _decimalConverter.encode(item.interest),
                  'installments': item.installments,
                  'payments': _paymentListConverter.encode(item.payments)
                }),
        _creditDeletionAdapter = DeletionAdapter(
            database,
            'Credit',
            ['name'],
            (Credit item) => <String, Object?>{
                  'name': item.name,
                  'card': item.card,
                  'loan': _decimalConverter.encode(item.loan),
                  'interest': _decimalConverter.encode(item.interest),
                  'installments': item.installments,
                  'payments': _paymentListConverter.encode(item.payments)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Credit> _creditInsertionAdapter;

  final UpdateAdapter<Credit> _creditUpdateAdapter;

  final DeletionAdapter<Credit> _creditDeletionAdapter;

  @override
  Future<List<Credit>> allCredits() async {
    return _queryAdapter.queryList('SELECT * FROM Credit',
        mapper: (Map<String, Object?> row) => Credit(
            name: row['name'] as String,
            card: row['card'] as String?,
            loan: _decimalConverter.decode(row['loan'] as String),
            interest: _decimalConverter.decode(row['interest'] as String),
            installments: row['installments'] as int,
            payments: _paymentListConverter.decode(row['payments'] as String)));
  }

  @override
  Future<Credit?> getCredit(String name) async {
    return _queryAdapter.query('SELECT * FROM Credit WHERE name = ?1',
        mapper: (Map<String, Object?> row) => Credit(
            name: row['name'] as String,
            card: row['card'] as String?,
            loan: _decimalConverter.decode(row['loan'] as String),
            interest: _decimalConverter.decode(row['interest'] as String),
            installments: row['installments'] as int,
            payments: _paymentListConverter.decode(row['payments'] as String)),
        arguments: [name]);
  }

  @override
  Future<void> insertCredit(Credit creditCard) async {
    await _creditInsertionAdapter.insert(creditCard, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCredit(Credit creditCard) async {
    await _creditUpdateAdapter.update(creditCard, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCredit(Credit creditCard) async {
    await _creditDeletionAdapter.delete(creditCard);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _iconDataConverter = IconDataConverter();
final _colorConverter = ColorConverter();
final _feeTypeConverter = FeeTypeConverter();
final _paymentListConverter = PaymentListConverter();
final _decimalConverter = DecimalConverter();
