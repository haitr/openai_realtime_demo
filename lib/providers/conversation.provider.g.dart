// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioStreamHash() => r'5c811b24225bc43e6241e2467ae4e8cc7fcde2ee';

/// See also [audioStream].
@ProviderFor(audioStream)
final audioStreamProvider = AutoDisposeStreamProvider<Uint8List>.internal(
  audioStream,
  name: r'audioStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$audioStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AudioStreamRef = AutoDisposeStreamProviderRef<Uint8List>;
String _$conversationHash() => r'b35571892b22c3306f10eadf59edcfd2eb9b660c';

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

/// See also [conversation].
@ProviderFor(conversation)
const conversationProvider = ConversationFamily();

/// See also [conversation].
class ConversationFamily extends Family<AsyncValue<ConversationItemList>> {
  /// See also [conversation].
  const ConversationFamily();

  /// See also [conversation].
  ConversationProvider call(
    int scenarioId,
  ) {
    return ConversationProvider(
      scenarioId,
    );
  }

  @override
  ConversationProvider getProviderOverride(
    covariant ConversationProvider provider,
  ) {
    return call(
      provider.scenarioId,
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
  String? get name => r'conversationProvider';
}

/// See also [conversation].
class ConversationProvider
    extends AutoDisposeStreamProvider<ConversationItemList> {
  /// See also [conversation].
  ConversationProvider(
    int scenarioId,
  ) : this._internal(
          (ref) => conversation(
            ref as ConversationRef,
            scenarioId,
          ),
          from: conversationProvider,
          name: r'conversationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$conversationHash,
          dependencies: ConversationFamily._dependencies,
          allTransitiveDependencies:
              ConversationFamily._allTransitiveDependencies,
          scenarioId: scenarioId,
        );

  ConversationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.scenarioId,
  }) : super.internal();

  final int scenarioId;

  @override
  Override overrideWith(
    Stream<ConversationItemList> Function(ConversationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ConversationProvider._internal(
        (ref) => create(ref as ConversationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        scenarioId: scenarioId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<ConversationItemList> createElement() {
    return _ConversationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationProvider && other.scenarioId == scenarioId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, scenarioId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ConversationRef on AutoDisposeStreamProviderRef<ConversationItemList> {
  /// The parameter `scenarioId` of this provider.
  int get scenarioId;
}

class _ConversationProviderElement
    extends AutoDisposeStreamProviderElement<ConversationItemList>
    with ConversationRef {
  _ConversationProviderElement(super.provider);

  @override
  int get scenarioId => (origin as ConversationProvider).scenarioId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
