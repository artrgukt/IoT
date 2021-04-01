int a = D5;
int b;

#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>

#define WIFI_SSID "kora"
#define WIFI_PASSWORD "kumar123123"

#define FIREBASE_HOST "iot-firebase-basics-default-rtdb.firebaseio.com/"
#define FIREBASE_AUTH "o3QC14G10g9fKqKSaXmiiGN4uUXRqMjEHwij4MwF"


void setup() {
  Serial.begin(9600);
  pinMode(a, OUTPUT);     // Initialize the LED_BUILTIN pin as an outpu

   // connect to wifi.
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("connecting");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("connected: ");
  Serial.println(WiFi.localIP());

   Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);

  
}

// the loop function runs over and over again forever
void loop() {
  b =  Firebase.getInt("Led");
  Serial.println(b);
  digitalWrite(a,b);
  delay(5000);

  
  
  
}
