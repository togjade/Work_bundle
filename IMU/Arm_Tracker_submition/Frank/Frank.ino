// Uncomment the following line to use a MinIMU-9 v5 or AltIMU-10 v5. Leave commented for older IMUs (up through v4).
#define IMU_V5

// Uncomment the below line to use this axis definition:
   // X axis pointing forward
   // Y axis pointing to the right
   // and Z axis pointing down.
// Positive pitch : nose up
// Positive roll : right wing down
// Positive yaw : clockwise
//int SENSOR_SIGN[9] = {1,1,1,-1,-1,-1,1,1,1}; //Correct directions x,y,z - gyro, accelerometer, magnetometer
// Uncomment the below line to use this axis definition:
   // X axis pointing forward
   // Y axis pointing to the left
   // and Z axis pointing up.
// Positive pitch : nose down
// Positive roll : right wing down
// Positive yaw : counterclockwise
int SENSOR_SIGN[9] = {1,-1,-1,-1,1,1,1,-1,-1}; //Correct directions x,y,z - gyro, accelerometer, magnetometer

#include <Wire.h>

// accelerometer: 8 g sensitivity
// 3.9 mg/digit; 1 g = 256
#define GRAVITY 256  //this equivalent to 1G in the raw data coming from the accelerometer

#define ToRad(x) ((x)*0.01745329252)  // *pi/180
#define ToDeg(x) ((x)*57.2957795131)  // *180/pi

// gyro: 2000 dps full scale
// 70 mdps/digit; 1 dps = 0.07
#define Gyro_Gain_X 0.07 //X axis Gyro gain
#define Gyro_Gain_Y 0.07 //Y axis Gyro gain
#define Gyro_Gain_Z 0.07 //Z axis Gyro gain
#define Gyro_Scaled_X(x) ((x)*ToRad(Gyro_Gain_X)) //Return the scaled ADC raw data of the gyro in radians for second
#define Gyro_Scaled_Y(x) ((x)*ToRad(Gyro_Gain_Y)) //Return the scaled ADC raw data of the gyro in radians for second
#define Gyro_Scaled_Z(x) ((x)*ToRad(Gyro_Gain_Z)) //Return the scaled ADC raw data of the gyro in radians for second

// LSM303/LIS3MDL magnetometer calibration constants; use the Calibrate example from
// the Pololu LSM303 or LIS3MDL library to find the right values for your board

#define M_X_MIN -1000
#define M_Y_MIN -1000
#define M_Z_MIN -1000
#define M_X_MAX +1000
#define M_Y_MAX +1000
#define M_Z_MAX +1000


#define STATUS_LED 13

float G_Dt=0.02;    // Integration time (DCM algorithm)  We will run the integration loop at 50Hz if possible

long timer=0;   //general purpuse timer
long timer_old;
long timer24=0; //Second timer used to print values
int AN[9]; //array that stores the gyro and accelerometer data
int AN_OFFSET[6][6]={{0,0,0,0,0,0},
                     {0,0,0,0,0,0},
                     {0,0,0,0,0,0},
                     {0,0,0,0,0,0},
                     {0,0,0,0,0,0},
                     {0,0,0,0,0,0}}; //Array that stores the Offset of the sensors

int gyro_x;
int gyro_y;
int gyro_z;
int accel_x;
int accel_y;
int accel_z;
int magnetom_x;
int magnetom_y;
int magnetom_z;
float c_magnetom_x;
float c_magnetom_y;
float c_magnetom_z;
float MAG_Heading;

float Accel_Vector[3]= {0,0,0}; //Store the acceleration in a vector
float Gyro_Vector[3]= {0,0,0};//Store the gyros turn rate in a vector
float Omega_Vector[3]= {0,0,0}; //Corrected Gyro_Vector data
float Omega_P[3]= {0,0,0};//Omega Proportional correction
float Omega_I[3]= {0,0,0};//Omega Integrator
float Omega[3]= {0,0,0};

// Euler angles
float roll;
float pitch;
float yaw;

float errorRollPitch[3]= {0,0,0};
float errorYaw[3]= {0,0,0};

unsigned int counter=0;
byte gyro_sat=0;

int num_sensors=6;

#define TCAADDR 0x70

void tcaselect(uint8_t i) {
  if (i > 7) return;
 
  Wire.beginTransmission(TCAADDR);
  Wire.write(1 << i);
  Wire.endTransmission();  
}

void setup()
{
  Serial.begin(115200);
  pinMode (STATUS_LED,OUTPUT);  // Status LED
  I2C_Init();

  Serial.println("Pololu MinIMU-9 + Arduino AHRS");

  digitalWrite(STATUS_LED,LOW);
  delay(1500);
  
for (uint8_t i=0;i<num_sensors;i++){
  tcaselect(i);
  Serial.print("Start Offseting ");
  Serial.println(i);
  Accel_Init();
  Compass_Init();
  Gyro_Init();

  delay(20);
  Serial.println("Init succeed");
  for(int j=0;j<12;j++)    // We take some readings...
    {
    Serial.println(i);
    Read_Gyro(i);Serial.println(i);
    Read_Compass();Serial.println(i);
    Read_Accel(i);Serial.println(i);
    for(int y=0; y<6; y++)  // Cumulate values
      AN_OFFSET[i][y] += AN[y];
    delay(20);
    }
  Serial.println("Average Calculation");
  for(int y=0; y<6; y++)
    AN_OFFSET[i][y] = AN_OFFSET[i][y]/12;

  AN_OFFSET[i][5]-=GRAVITY*SENSOR_SIGN[5];

  //Serial.println("Offset:");
  for(int y=0; y<6; y++)
  Serial.println(AN_OFFSET[i][y]);
}

  Serial.println("initialization finished");
  delay(2000);
  digitalWrite(STATUS_LED,HIGH);

  timer=millis();
  delay(20);
  counter=0;
}

void loop() //Main Loop
{
  if((millis()-timer)>=25)  // Main loop runs at 40Hz
  {
    timer_old = timer;
    timer=millis();
    for (uint8_t i=0;i<num_sensors;i++){
      tcaselect(i);
      Read_Accel(i);Read_Gyro(i);Read_Compass();
    
      Serial.print(777); Serial.print(i); Serial.print(" ");
      float temp=AN[0];
      if (abs(temp)<2) Serial.print(0);
      else Serial.print(AN[0]);  
      Serial.print(" ");
      temp=AN[1];
      if (abs(temp)<2) Serial.print(0);
      else Serial.print(AN[1]); 
      Serial.print(" ");
      temp=AN[2];
      if (abs(temp)<2) Serial.print(0);
      else Serial.print(AN[2]);   
      Serial.print(" ");
      Serial.print(AN[3]); Serial.print (" "); Serial.print(AN[4]); Serial.print (" "); Serial.print(AN[5]); Serial.print(" ");
      Serial.print(AN[6]); Serial.print (" "); Serial.print(AN[7]); Serial.print (" "); Serial.print(AN[8]); Serial.print(" ");
      Serial.println(timer);
    }
  }
}
