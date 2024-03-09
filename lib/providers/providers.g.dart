// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$navSelectionHash() => r'd9c09ba7d1483bb1de2c76f35a3ce273182a9e45';

/// See also [NavSelection].
@ProviderFor(NavSelection)
final navSelectionProvider =
    AutoDisposeNotifierProvider<NavSelection, int>.internal(
  NavSelection.new,
  name: r'navSelectionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$navSelectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NavSelection = AutoDisposeNotifier<int>;
String _$serverHash() => r'a5951aac03ecbfccdb73b2af2568b5c4a7f08466';

/// See also [Server].
@ProviderFor(Server)
final serverProvider =
    AutoDisposeAsyncNotifierProvider<Server, String?>.internal(
  Server.new,
  name: r'serverProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$serverHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Server = AutoDisposeAsyncNotifier<String?>;
String _$authHash() => r'0ad5619f2131a2bcf43f9b1daa8d8cecfe958f42';

/// See also [Auth].
@ProviderFor(Auth)
final authProvider = AutoDisposeNotifierProvider<Auth, String?>.internal(
  Auth.new,
  name: r'authProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Auth = AutoDisposeNotifier<String?>;
String _$appsHash() => r'2b7f4880f40569d3f5a9affdcd341345593c760a';

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

abstract class _$Apps
    extends BuildlessAutoDisposeAsyncNotifier<ApplicationListResponse> {
  late final int pageNo;

  FutureOr<ApplicationListResponse> build(
    int pageNo,
  );
}

/// See also [Apps].
@ProviderFor(Apps)
const appsProvider = AppsFamily();

/// See also [Apps].
class AppsFamily extends Family<AsyncValue<ApplicationListResponse>> {
  /// See also [Apps].
  const AppsFamily();

  /// See also [Apps].
  AppsProvider call(
    int pageNo,
  ) {
    return AppsProvider(
      pageNo,
    );
  }

  @override
  AppsProvider getProviderOverride(
    covariant AppsProvider provider,
  ) {
    return call(
      provider.pageNo,
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
  String? get name => r'appsProvider';
}

/// See also [Apps].
class AppsProvider extends AutoDisposeAsyncNotifierProviderImpl<Apps,
    ApplicationListResponse> {
  /// See also [Apps].
  AppsProvider(
    int pageNo,
  ) : this._internal(
          () => Apps()..pageNo = pageNo,
          from: appsProvider,
          name: r'appsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$appsHash,
          dependencies: AppsFamily._dependencies,
          allTransitiveDependencies: AppsFamily._allTransitiveDependencies,
          pageNo: pageNo,
        );

  AppsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pageNo,
  }) : super.internal();

  final int pageNo;

  @override
  FutureOr<ApplicationListResponse> runNotifierBuild(
    covariant Apps notifier,
  ) {
    return notifier.build(
      pageNo,
    );
  }

  @override
  Override overrideWith(Apps Function() create) {
    return ProviderOverride(
      origin: this,
      override: AppsProvider._internal(
        () => create()..pageNo = pageNo,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pageNo: pageNo,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Apps, ApplicationListResponse>
      createElement() {
    return _AppsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AppsProvider && other.pageNo == pageNo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pageNo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AppsRef on AutoDisposeAsyncNotifierProviderRef<ApplicationListResponse> {
  /// The parameter `pageNo` of this provider.
  int get pageNo;
}

class _AppsProviderElement extends AutoDisposeAsyncNotifierProviderElement<Apps,
    ApplicationListResponse> with AppsRef {
  _AppsProviderElement(super.provider);

  @override
  int get pageNo => (origin as AppsProvider).pageNo;
}

String _$appHash() => r'2fe7bcb6ad9ec67b885ff0c9163dbcd9d0ac3949';

/// See also [App].
@ProviderFor(App)
final appProvider = AutoDisposeNotifierProvider<App, Application>.internal(
  App.new,
  name: r'appProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$App = AutoDisposeNotifier<Application>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
