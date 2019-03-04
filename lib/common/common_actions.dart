

import 'package:crypto_exchange/data/loading_status.dart';
import 'package:crypto_exchange/data/screen.dart';

class ChangeLoadingStatusAction{
  final LoadingStatus status;
  final Screen screen;
  ChangeLoadingStatusAction(this.status, this.screen);
}

class ShowBackendErrorAction{
  final String error;
  final Screen screen;
  ShowBackendErrorAction(this.error, this.screen);
}

class HideBackendErrorAction{
}

class NavigateBackAction{
}

class NavigateToSettingsAction{
}