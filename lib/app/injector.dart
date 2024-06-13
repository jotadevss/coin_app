import 'package:auto_injector/auto_injector.dart';
import 'package:coin_app/app/external/repositories/api/http_quote_repository.dart';
import 'package:coin_app/app/external/repositories/api/http_variation_repository.dart';
import 'package:coin_app/app/external/repositories/local/local_combination_repository.dart';
import 'package:coin_app/app/external/repositories/local/local_currency_repository.dart';
import 'package:coin_app/app/interactor/contracts/repositories/combination_repository.dart';
import 'package:coin_app/app/interactor/contracts/repositories/currencies_repository.dart';
import 'package:coin_app/app/interactor/contracts/repositories/quote_repository.dart';
import 'package:coin_app/app/interactor/contracts/repositories/variation_repository.dart';
import 'package:coin_app/app/interactor/reducer/conversor_reducer.dart';
import 'package:flutter/material.dart';

final autoInjector = AutoInjector();

void initializeConfigurations() {
  WidgetsFlutterBinding.ensureInitialized();
}

void registerInstances() {
  // registering repositories
  autoInjector.addSingleton<ICurrencyRepository>(LocalCurrencyRepository.new);
  autoInjector.addSingleton<ICombinationRepository>(LocalCombinationRepository.new);
  autoInjector.addSingleton<IQuoteRepository>(HttpQuoteRepository.new);
  autoInjector.addSingleton<IVariationRepository>(HttpVariationRepository.new);

  // registering reducers
  autoInjector.addLazySingleton(ConversorReducer.new);

  autoInjector.commit();

  // instance reducers
  autoInjector.get<ConversorReducer>();
}
