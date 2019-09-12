function jenv
  set -x JAVA_HOME (/usr/libexec/java_home -v $argv)
  echo $JAVA_HOME
  java -version
end
