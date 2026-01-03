import 'package:flutter_test/flutter_test.dart';
import 'package:instacare_components/instacare_components.dart';
import 'package:instacare_components/instacare_components_platform_interface.dart';
import 'package:instacare_components/instacare_components_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInstacareComponentsPlatform
    with MockPlatformInterfaceMixin
    implements InstacareComponentsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final InstacareComponentsPlatform initialPlatform = InstacareComponentsPlatform.instance;

  test('$MethodChannelInstacareComponents is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInstacareComponents>());
  });

  test('getPlatformVersion', () async {
    InstacareComponents instacareComponentsPlugin = InstacareComponents();
    MockInstacareComponentsPlatform fakePlatform = MockInstacareComponentsPlatform();
    InstacareComponentsPlatform.instance = fakePlatform;

    expect(await instacareComponentsPlugin.getPlatformVersion(), '42');
  });
}
