part of dart_force_server_lib;

class ForceMessageSecurity {

  Map<String, List> requestList = new Map<String, List>();
  SecurityContextHolder securityContextHolder;
  
  ForceMessageSecurity(this.securityContextHolder);
  
  void register(String request, List<String> roles) {
    requestList[request] = roles;
  }
  
  bool checkSecurity(HttpRequest req, ForceMessageEvent fme) {
    if (requestList[fme.request] != null && requestList[fme.request].isNotEmpty) {
      // check if you are logged in against correct credentials
      return this.securityContextHolder.checkAuthorization(req, requestList[fme.request], data: fme);
    } else {
      return true;
    }
  }
}