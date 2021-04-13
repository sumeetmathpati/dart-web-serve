const String HOST_NAME = 'localhost';
const int PORT_NUMBER = 8080;              
const SECRET_KEY = "c&u4!s!-zhx!l*3obc4ee-u5f-k=jxt^&a31!a#@nvok1ztg4p";       // Change this key. Secret key is used for generating JWTs.
const AUTH_ENABLE = false;          // If this is true, then only we require JWTs for accessing APIs.
const PACKAGE_RESOURCE_BASE_URL = 'https://hosted-pub-server.herokuapp.com'; // This will be used for generating links for downloadable tarballs i.e. 'archive_url' key for packages.