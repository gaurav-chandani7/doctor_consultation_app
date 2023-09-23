abstract class BaseService {
  final String baseUrl = "https://my-json-server.typicode.com/githubforekam/doctor-appointment";
  Future getResponse(String url);
}
