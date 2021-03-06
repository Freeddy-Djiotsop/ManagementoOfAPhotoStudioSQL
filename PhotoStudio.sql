--We create the Database

CREATE DATABASE photoStudio;

-- We need to create relation intances and associated attributes
-- Wir legen erst Relationen mit ihren zugehörigen Daten an

USE photoStudio;
CREATE TABLE employee(-- The studio has employee(Mitarbeiter)
  ID INTEGER NOT NULL AUTO_INCREMENT, --we can use after creating this table ALTER TABLE employee AUTO_INCREMENT=10000; to set the start value, otherwise it starts at 1
  --AUTO_INCREMENT ist valid for MySQL, AUTOINCREMENT for Access
  firstname VARCHAR(30) NOT NULL, --with not null we prevent Insertion anomaly, so the value must be always given, mit NOT NULL wird Einfügeanomalie verhindert, vorname muss immer angegeben werden
  surname VARCHAR(30) NOT NULL,
  street VARCHAR(50) NOT NULL,
  houseNumber VARCHAR(10) NOT NULL,
  postCode VARCHAR(5) NOT NULL,/*The case of Germany*/
  city VARCHAR(50) NOT NULL,
  salary DOUBLE,-- can be undefined
  PRIMARY KEY(ID)
  );

CREATE TABLE customer(-- he has customer(Kunde)
  ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firstname VARCHAR(30) NOT NULL,
  surname VARCHAR(30) NOT NULL,
  email VARCHAR(60) NOT NULL
  );
  
  CREATE TABLE camera(-- The work tool
  serialID VARCHAR(50) NOT NULL UNIQUE PRIMARY KEY, /*every camera has an unique serial number*/
  maker VARCHAR(50) NOT NULL,
  model VARCHAR(50) NOT NULL,
  megapixel DOUBLE NOT NULL,
  lightSensitivity VARCHAR(30) NOT NULL, -- we store the maximum available light sensitivity of the camera(die maximale verfügbare Lichtempfindlichkeit der Kamera)
  NumberOfCrossSensors INTEGER NOT NULL
  /*These last two attributes are very important and will help the photographer for creating successful shots
  (Lichtempfindlichkeit und AnzahlDerKreuzsensoren helfen zur Erstellung gelungener Aufnahmen)*/
  );
  
  CREATE TABLE orders(-- Customer can order and an employee does  it
  ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  employeeID INTEGER NOT NULL,
  customerID INTEGER NOT NULL,
  designation VARCHAR(50) NOT NULL, -- Bezeichnung
  oderDate DATE,
  totalPrice DOUBLE, -- can be undefined at the start
  FOREIGN KEY(employeeID) REFERENCES employee(ID),
  FOREIGN KEY(customerID) REFERENCES customer(ID)
  );
  

CREATE TABLE photo(-- every photo should be assigned to an order and we also store the his camera
  ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, -- we want every photo to be UNIQUE
  orderID INTEGER NOT NULL,
  cameraID VARCHAR(50) NOT NULL,
  photoname VARCHAR(50) NOT NULL,-- every photo become automatic a name from the camera and we should store it here
  megapixel DOUBLE NOT NULL,
  lightSensitivity VARCHAR(30) NOT NULL,
  lensSpeed VARCHAR(10) NOT NULL, -- or f-number, ist die fotografische Lichtstärke(Blendenzahl)
  ShutterSpeed VARCHAR(10) NOT NULL, --Verschlusszeit
  /*We should store this 3 last values to enable digital post-processing
  (Die 3 letzten werte müssen wir speichern, um eine spätere digitale Nachbearbeitung zu ermöglichen)*/
  FOREIGN KEY(orderID) REFERENCES orders(ID),
  FOREIGN KEY(cameraID) REFERENCES camera(serialID)
  );
  
  CREATE TABLE payout( --salary payout for every employee
    ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    month DATE,
    employeeID INTEGER NOT NULL,
    salary DOUBLE NOT NULL,
    sent BOOLEAN DEFAULT 0, -- If sent, then 1
    FOREIGN KEY(employeeID) REFERENCES employee(ID)
    );
    /*this table can help all the month EXPENSES to know using SELECT SUM(salary) FROM payout WHERE NOT sent=0*/
    
    
    
    
