// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scenario.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scenarioHash() => r'd1c3960b3e322912f08e73a43d4aeaf90d96c763';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [scenario].
@ProviderFor(scenario)
const scenarioProvider = ScenarioFamily();

/// See also [scenario].
class ScenarioFamily extends Family<AsyncValue<Scenario>> {
  /// See also [scenario].
  const ScenarioFamily();

  /// See also [scenario].
  ScenarioProvider call(
    int id,
  ) {
    return ScenarioProvider(
      id,
    );
  }

  @override
  ScenarioProvider getProviderOverride(
    covariant ScenarioProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'scenarioProvider';
}

/// See also [scenario].
class ScenarioProvider extends AutoDisposeFutureProvider<Scenario> {
  /// See also [scenario].
  ScenarioProvider(
    int id,
  ) : this._internal(
          (ref) => scenario(
            ref as ScenarioRef,
            id,
          ),
          from: scenarioProvider,
          name: r'scenarioProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$scenarioHash,
          dependencies: ScenarioFamily._dependencies,
          allTransitiveDependencies: ScenarioFamily._allTransitiveDependencies,
          id: id,
        );

  ScenarioProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<Scenario> Function(ScenarioRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ScenarioProvider._internal(
        (ref) => create(ref as ScenarioRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Scenario> createElement() {
    return _ScenarioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScenarioProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ScenarioRef on AutoDisposeFutureProviderRef<Scenario> {
  /// The parameter `id` of this provider.
  int get id;
}

class _ScenarioProviderElement
    extends AutoDisposeFutureProviderElement<Scenario> with ScenarioRef {
  _ScenarioProviderElement(super.provider);

  @override
  int get id => (origin as ScenarioProvider).id;
}

String _$scenarioNotifierHash() => r'080a62ee47de4c25229502fd0cf0de1446f50fa7';

/// See also [ScenarioNotifier].
@ProviderFor(ScenarioNotifier)
final scenarioNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ScenarioNotifier, List<Scenario>>.internal(
  ScenarioNotifier.new,
  name: r'scenarioNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$scenarioNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ScenarioNotifier = AutoDisposeAsyncNotifier<List<Scenario>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
