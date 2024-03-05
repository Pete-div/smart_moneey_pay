import 'package:smartpay/model/dashboard_model.dart';
import 'package:smartpay/model/network_response.dart';
import 'package:smartpay/service/remote/api_endpoints.dart';
import 'package:smartpay/service/remote/http_requests.dart';

DashboardRemoteRepo dashboardRepo = DashboardRemoteRepoImp();

abstract class DashboardRemoteRepo {
  Future<EmptyResponse> dashboard(

  );

   
}
class DashboardRemoteRepoImp extends DashboardRemoteRepo {

  @override
  Future<EmptyResponse> dashboard(

  ) async {
    final result = await http.get(
      path: ApiEndPoints.dashboard,
      addAuth: true,
    );

    if (result['status'] ==false) {
      return ErrorResponse.fromJson(result);
    }
    return DashboardResModel.fromJson(result);
  }
}