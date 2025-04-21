#!/bin/bash


# --- Configuration ---

PROJECT_NAME="myapp"

SRC_DIR="src"

BUILD_DIR="build"

WEB_INF_DIR="WEB-INF"

CLASSES_DIR="$BUILD_DIR/$WEB_INF_DIR/classes"

WAR_FILE="$PROJECT_NAME.war"

TOMCAT_WEBAPPS_DIR="/path/to/tomcat/webapps"

SERVLET_API_JAR="/path/to/tomcat/lib/servlet-api.jar"


# --- Clean Previous Build ---

echo "Cleaning old build..."

rm -rf "$BUILD_DIR" "$WAR_FILE"


# --- Create Directory Structure ---

echo "Creating build directory structure..."

mkdir -p "$CLASSES_DIR"

mkdir -p "$BUILD_DIR/$WEB_INF_DIR"


# --- Copy web.xml and static files ---

echo "Copying WEB-INF/web.xml and other resources..."

cp -r web "$BUILD_DIR"


# --- Compile Java source files ---

echo "Compiling source files..."

find "$SRC_DIR" -name "*.java" > sources.txt

javac -d "$CLASSES_DIR" -cp "$SERVLET_API_JAR" @sources.txt

rm sources.txt


# --- Create WAR file ---

echo "Creating WAR file..."

cd "$BUILD_DIR"

jar -cvf "../$WAR_FILE" .

cd ..


# --- Deploy to Tomcat ---

echo "Deploying WAR to Tomcat..."

cp "$WAR_FILE" "$TOMCAT_WEBAPPS_DIR"


echo "Build and deployment complete."

