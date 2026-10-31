class AppInfoModel {
  final String name;
  final String packageName;
  final bool isConnected;
  final String iconPath;

  AppInfoModel({
    required this.name,
    required this.packageName,
    this.isConnected = false,
    required this.iconPath,
  });

  AppInfoModel copyWith({bool? isConnected}) {
    return AppInfoModel(
      name: name,
      packageName: packageName,
      isConnected: isConnected ?? this.isConnected,
      iconPath: iconPath,
    );
  }
}