byte key(){  
    int val = analogRead(7); //A7 port with resistive switch
        if (val < 50) return 1; 
        else if (val < 190) return 2; 
        else if (val < 350) return 3; 
        else if (val < 490) return 4; 
        else if (val < 650) return 5; 
        else if (val < 790) return 6; 
        else return 0;  
}

const int ledPin = 7; // Led pin
int previousValue = 0;
int prev_wg_state = 0;
int activeTunnel = 0;
int previousA = 0;
int previousD = 0;

void setup() {
    Serial.begin(9600);
    pinMode(ledPin, OUTPUT);
}
void loop() {

  int value = key();

  if (value != previousValue) {
    Serial.println(value);
    previousValue = value;
  }
  
//COM RX/TX
   
  if (Serial.available() > 0) {

    char command = Serial.read();
    int previousA = 0;
    int previousD = 0;

    if (command == 'N') {
      Serial.println(value);
    }
   	 if (command == 'A') {
    	  if (command != previousA) {
   	    digitalWrite(ledPin, HIGH);
      	    Serial.println("Active");
    	    previousA = 'A';
  }
   
      
    }
    if (command == 'D') {
      if (command != previousD) {
      digitalWrite(ledPin, LOW);
      Serial.println("inActive");
      previousD = 'D';
  }
      
    }
  }
  
        delay(1000);       
}
