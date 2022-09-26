function() {
 // var env = karate.env; // get java system property 'karate.env'
  var env = 'e2e'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'stage';

  }
  var config = {
    baseURL : 'https://ssd-api.jpl.nasa.gov/',
    path: 'cad.api'
  };
  if (env == 'stage') {
    config.someUrlBase = 'https://ssd-api.jpl.nasa.gov/';
  } else if (env == 'e2e') {
    config.someUrlBase = 'https://ssd-api.jpl.nasa.gov/';

  }
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  return config;
}

