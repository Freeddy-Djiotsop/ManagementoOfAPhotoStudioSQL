CREATE TABLE employee(-- The studio has employee(Mitarbeiter)
  ID INTEGER NOT NULL AUTO_INCREMENT, 
  firstname VARCHAR(30) NOT NULL,
  surname VARCHAR(30) NOT NULL,
  street VARCHAR(50) NOT NULL,
  houseNumber VARCHAR(10) NOT NULL,
  postCode VARCHAR(5) NOT NULL,/*The case of Germany*/
  city VARCHAR(50) NOT NULL,
  salary DOUBLE,-- can be undefined
  PRIMARY KEY(ID)
  );
  
  ALTER TABLE employee AUTO_INCREMENT=10000;

/*select * from employee;*/


INSERT INTO employee (firstname, surname, street, houseNumber, postCode, city, salary)
VALUES 
  ('Jens', 'Meier', 'Brausestr.', '44C', '42657', 'Solingen', 3500),
  ('Nina', 'Mueller', 'Sternstr.', '10', '50667', 'Koeln', 1800),
  ('Alfred', 'Schmidt', 'Priolweg', '124', '42103', 'Wuppertal', 2700),
  ('Heinz', 'Fischer', 'Steinstr.', '4', '42104', 'Wuppertal', 1300);

/*select * from employee;*/
CREATE TABLE customer(-- he has customer(Kunde)
  ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firstname VARCHAR(30) NOT NULL,
  surname VARCHAR(30) NOT NULL,
  email VARCHAR(60) NOT NULL
  );
  
  INSERT INTO customer (firstname, surname, email)
  VALUES
    ('Nicole', 'Wagner', 'nwagner@provider.com'),
    ('Max', 'Bauer', 'max@bauer.de'),
    ('Renate', 'Schneider', 'rs@webpost.de'),
    ('Melanie', 'Weber', 'melanie@weber.com'),
    ('klaus', 'Windt', 'klaus@mymail.de');

/*select * from customer;*/

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
  
  
  INSERT INTO camera
  VALUES
    ('SF03522156134', 'Canon', 'EOS 5D Mark III',  22.3, 'ISO 102400', 65),
    ('TU04332722131', 'Canon', 'EOS 70D',  20.2, 'ISO 25600', 19),
    ('VX08332322120', 'Canon', 'EOS 70D',  20.2, 'ISO 25600', 19),
    ('14528135913FG', 'Nikon', 'D810',  36, 'ISO 51600', 51),
    ('16529175211CB', 'Nikon', 'D7100',  24.1, 'ISO 25600', 19);
    
/*select * from camera;*/


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

INSERT INTO orders (employeeID, CustomerID, designation, oderDate, totalprice)
  VALUES
    (10000, 1, 'Bewerbungsfotos', '2020-03-24', 100),
    (10001, 2, 'Katalogfotos', '2020-04-06', 1200),
    (10002, 3, 'Porträtfotos', '2020-04-10', 300),
    (10003, 4, 'Porträtfotos', '2020-04-11', 300),
    (10003, 2, 'Profilbild', '2020-04-16', 20.5),
    (10004, 5, 'Veranstaltungsfotos', "2020-04-16", 500);
    
/*select * from orders;*/

CREATE TABLE photo(-- every photo should be assigned to an order and we also store the his camera
  ID INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, -- we want every photo to be UNIQUE
  orderID INTEGER NOT NULL,
  cameraID VARCHAR(50) NOT NULL,
  photoname VARCHAR(50) NOT NULL,-- every photo become automatic a name from the camera and we should store it here
  megapixel DOUBLE NOT NULL,
  lightSensitivity VARCHAR(30) NOT NULL,
  lensSpeed VARCHAR(10) NOT NULL, -- or f-number, ist die fotografische Lichtstärke(Blendenzahl)
  ShutterSpeed VARCHAR(10) NOT NULL, -- Verschlusszeit
  /*We should store this 3 last values to enable digital post-processing
  (Die 3 letzten werte müssen wir speichern, um eine spätere digitale Nachbearbeitung zu ermöglichen)*/
  FOREIGN KEY(orderID) REFERENCES orders(ID),
  FOREIGN KEY(cameraID) REFERENCES camera(serialID)
  );


  INSERT INTO photo (orderID, cameraID, photoname, megapixel, lightSensitivity, lensSpeed, ShutterSpeed)
  VALUES
  ( 1, 'SF03522156134', 'IMG_2033.JPG', 2.8, '1/80', 400, 1),
  ( 2, 'TU04332722131', 'IMG_1010.JPG', 1.8, '1/300', 200, 2),
  ( 3, 'VX08332322120', 'IMG_2041.JPG', 1.8, '1/100', 600, 1),
  ( 4, '14528135913FG', 'DSC_4060.JPG', 10, '1/60', 600, 5),
  ( 5, '16529175211CB', 'DSC_3088.JPG', 10, '1/80', 800, 4),
  ( 6, 'SF03522156134', 'DSC_4090.JPG', 10, '1/60', 600, 5),
  ( 2, 'TU04332722131', 'DSC_3091.JPG', 2.8, '1/100', 200, 4),
  ( 3, 'VX08332322120', 'DSC_4092.JPG', 2.8, '1/100', 100, 5),
  ( 4, '14528135913FG', 'DSC_4040.JPG', 10, '1/60', 1200, 4),
  ( 2, '16529175211CB', 'DSC_4051.JPG', 3, '1/60', 100, 4),
  ( 2, 'SF03522156134', 'DSC_4059.JPG', 4, '1/60', 200, 4),
  ( 5, 'TU04332722131', 'DSC_4060.JPG', 5, '1/80', 500, 3),
  ( 5, 'VX08332322120', 'IMG_1010.JPG', 3, '1/90', 1000, 3),
  ( 2, '14528135913FG', 'IMG_1011.JPG', 11, '1/50', 1200, 3),
  ( 3, '16529175211CB', 'IMG_2042.JPG', 9, '1/60', 1600, 1),
  ( 4, 'SF03522156134', 'IMG_1012.JPG', 3, '1/100', 200, 2);
  
  select * from photo;










