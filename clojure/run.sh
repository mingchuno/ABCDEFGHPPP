#!/bin/sh

# jre >=1.6
# download clojure jar from http://repo1.maven.org/maven2/org/clojure/clojure/1.8.0/clojure-1.8.0.zip

java -cp /opt/clojure/clojure-1.8.0.jar clojure.main abcdefghppp.clj
