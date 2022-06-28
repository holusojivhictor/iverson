import 'package:iverson/domain/services/services.dart';

class IverServiceImpl implements IversonService {
  final AuthService _authService;

  IverServiceImpl(this._authService);

  @override
  Future<bool> isUserSignedIn() async {
    return false;
  }
}