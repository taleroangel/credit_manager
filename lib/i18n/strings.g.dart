/// Generated file. Do not edit.
///
/// Locales: 1
/// Strings: 47
///
/// Built on 2022-12-09 at 21:15 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, _StringsEn> {
	en(languageCode: 'en', build: _StringsEn.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _StringsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_StringsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _StringsEn> {
	TranslationProvider({required super.child}) : super(
		initLocale: LocaleSettings.instance.currentLocale,
		initTranslations: LocaleSettings.instance.currentTranslations,
	);

	static InheritedLocaleData<AppLocale, _StringsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_StringsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _StringsEn> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale) => instance.setLocale(locale);
	static AppLocale setLocaleRaw(String rawLocale) => instance.setLocaleRaw(rawLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _StringsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
}

// translations

// Path: <root>
class _StringsEn implements BaseTranslations<AppLocale, _StringsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	late final _StringsAppEn app = _StringsAppEn._(_root);
	late final _StringsFinancialEn financial = _StringsFinancialEn._(_root);
	late final _StringsModelsEn models = _StringsModelsEn._(_root);
	late final _StringsNavigationEn navigation = _StringsNavigationEn._(_root);
	late final _StringsScreensEn screens = _StringsScreensEn._(_root);
}

// Path: app
class _StringsAppEn {
	_StringsAppEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get title => 'Credit Manager';
	String get accept => 'Ok';
	String get cancel => 'Cancel';
	String get add => 'Add';
	String get edit => 'Edit';
	String get erase => 'Erase';
	String get update => 'Update';
	String get invalid => 'This value is not valid';
	String get required => 'This field is required';
	String get optional => '(Optional)';
}

// Path: financial
class _StringsFinancialEn {
	_StringsFinancialEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get fee => 'Fee';
	String get due => 'Due day';
	String get loan => 'Loan';
	String get interest => 'Interest (% M.A)';
	String get term => 'Installments';
	String get others => 'Other expenses';
}

// Path: models
class _StringsModelsEn {
	_StringsModelsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsModelsCreditEn credit = _StringsModelsCreditEn._(_root);
	late final _StringsModelsPaymentEn payment = _StringsModelsPaymentEn._(_root);
	late final _StringsModelsCreditCardEn credit_card = _StringsModelsCreditCardEn._(_root);
}

// Path: navigation
class _StringsNavigationEn {
	_StringsNavigationEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsNavigationCardsEn cards = _StringsNavigationCardsEn._(_root);
	late final _StringsNavigationCreditEn credit = _StringsNavigationCreditEn._(_root);
	late final _StringsNavigationSettingsEn settings = _StringsNavigationSettingsEn._(_root);
}

// Path: screens
class _StringsScreensEn {
	_StringsScreensEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsScreensCardEditEn card_edit = _StringsScreensCardEditEn._(_root);
	late final _StringsScreensCardDetailsEn card_details = _StringsScreensCardDetailsEn._(_root);
	late final _StringsScreensCardsEn cards = _StringsScreensCardsEn._(_root);
	late final _StringsScreensCreditScreenEn credit_screen = _StringsScreensCreditScreenEn._(_root);
}

// Path: models.credit
class _StringsModelsCreditEn {
	_StringsModelsCreditEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get name => 'Credit name';
}

// Path: models.payment
class _StringsModelsPaymentEn {
	_StringsModelsPaymentEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String installment({required Object number}) => 'Installment #${number}';
}

// Path: models.credit_card
class _StringsModelsCreditCardEn {
	_StringsModelsCreditCardEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get name => 'Card name';
	List<String> get fee_type => [
		'None',
		'Fixed monthly',
		'Montly when used',
	];
}

// Path: navigation.cards
class _StringsNavigationCardsEn {
	_StringsNavigationCardsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get appbar_title => 'Your Credit Cards';
	String get bottom_item => 'Cards';
}

// Path: navigation.credit
class _StringsNavigationCreditEn {
	_StringsNavigationCreditEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get appbar_title => 'Credit Simulator';
	String get bottom_item => 'Credit';
}

// Path: navigation.settings
class _StringsNavigationSettingsEn {
	_StringsNavigationSettingsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get appbar_title => 'Settings';
	String get bottom_item => 'Settings';
}

// Path: screens.card_edit
class _StringsScreensCardEditEn {
	_StringsScreensCardEditEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get page_title => 'Add a card';
	String get error_due_day => 'Select a day between 1 and 31';
	String get error_card_name => 'You must name your card';
	String get info_card_name => 'You will not be able to edit the name later';
	String get color_picker_title => 'Pick a color';
	String get color_pick => 'Color';
	String get icon_pick => 'Icon';
	String get icon_picker_title => 'Pick an icon';
}

// Path: screens.card_details
class _StringsScreensCardDetailsEn {
	_StringsScreensCardDetailsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get page_title => 'Card Details';
	String delete_confirmation({required Object cardName}) => 'Are you sure you want to delete ${cardName} ?';
	String next_payment({required Object payment}) => 'Next payment: ${payment}';
	String get no_payment => 'No pending payments';
	String get no_credits => 'Looks like you haven\'t added any credits yet';
}

// Path: screens.cards
class _StringsScreensCardsEn {
	_StringsScreensCardsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get no_cards => 'Looks like you haven\'t added any cards yet';
}

// Path: screens.credit_screen
class _StringsScreensCreditScreenEn {
	_StringsScreensCreditScreenEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get calculate => 'Calculate';
	String get credit_summary => 'Credit Summary';
	String get total => 'Total: ';
	String get max_installment => 'Maximum installment: ';
	String get store_on_credit_card => 'Store in credit card';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'app.title': return 'Credit Manager';
			case 'app.accept': return 'Ok';
			case 'app.cancel': return 'Cancel';
			case 'app.add': return 'Add';
			case 'app.edit': return 'Edit';
			case 'app.erase': return 'Erase';
			case 'app.update': return 'Update';
			case 'app.invalid': return 'This value is not valid';
			case 'app.required': return 'This field is required';
			case 'app.optional': return '(Optional)';
			case 'financial.fee': return 'Fee';
			case 'financial.due': return 'Due day';
			case 'financial.loan': return 'Loan';
			case 'financial.interest': return 'Interest (% M.A)';
			case 'financial.term': return 'Installments';
			case 'financial.others': return 'Other expenses';
			case 'models.credit.name': return 'Credit name';
			case 'models.payment.installment': return ({required Object number}) => 'Installment #${number}';
			case 'models.credit_card.name': return 'Card name';
			case 'models.credit_card.fee_type.0': return 'None';
			case 'models.credit_card.fee_type.1': return 'Fixed monthly';
			case 'models.credit_card.fee_type.2': return 'Montly when used';
			case 'navigation.cards.appbar_title': return 'Your Credit Cards';
			case 'navigation.cards.bottom_item': return 'Cards';
			case 'navigation.credit.appbar_title': return 'Credit Simulator';
			case 'navigation.credit.bottom_item': return 'Credit';
			case 'navigation.settings.appbar_title': return 'Settings';
			case 'navigation.settings.bottom_item': return 'Settings';
			case 'screens.card_edit.page_title': return 'Add a card';
			case 'screens.card_edit.error_due_day': return 'Select a day between 1 and 31';
			case 'screens.card_edit.error_card_name': return 'You must name your card';
			case 'screens.card_edit.info_card_name': return 'You will not be able to edit the name later';
			case 'screens.card_edit.color_picker_title': return 'Pick a color';
			case 'screens.card_edit.color_pick': return 'Color';
			case 'screens.card_edit.icon_pick': return 'Icon';
			case 'screens.card_edit.icon_picker_title': return 'Pick an icon';
			case 'screens.card_details.page_title': return 'Card Details';
			case 'screens.card_details.delete_confirmation': return ({required Object cardName}) => 'Are you sure you want to delete ${cardName} ?';
			case 'screens.card_details.next_payment': return ({required Object payment}) => 'Next payment: ${payment}';
			case 'screens.card_details.no_payment': return 'No pending payments';
			case 'screens.card_details.no_credits': return 'Looks like you haven\'t added any credits yet';
			case 'screens.cards.no_cards': return 'Looks like you haven\'t added any cards yet';
			case 'screens.credit_screen.calculate': return 'Calculate';
			case 'screens.credit_screen.credit_summary': return 'Credit Summary';
			case 'screens.credit_screen.total': return 'Total: ';
			case 'screens.credit_screen.max_installment': return 'Maximum installment: ';
			case 'screens.credit_screen.store_on_credit_card': return 'Store in credit card';
			default: return null;
		}
	}
}
