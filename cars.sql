CREATE TABLE `cars` (
  `vehicleId` int NOT NULL AUTO_INCREMENT,
  `model` varchar(225) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `vehicleType` enum('compact','medium','large','suv','truck','van') DEFAULT NULL,
  `IsAvailable` tinyint(1) DEFAULT NULL,
  `carType` enum('luxury','regular') DEFAULT NULL,
  `dailyRate` double DEFAULT NULL,
  `weeklyrate` double DEFAULT NULL,
  `ownerType` enum('rental company','bank','individual') DEFAULT NULL,
  PRIMARY KEY (`vehicleId`)
) AUTO_INCREMENT=1001;

DELIMITER $$
CREATE  TRIGGER `insert_availability` AFTER INSERT ON `cars` FOR EACH ROW BEGIN
   IF NEW.IsAvailable = 1 THEN
     INSERT INTO Availability (vehicleId, startDate, endDate) 
     VALUES (NEW.vehicleId, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 6 MONTH));
   END IF;
END;


INSERT INTO `cars` (`model`, `year`, `vehicleType`, `IsAvailable`, `carType`, `dailyRate`, `weeklyrate`, `ownerType`)
VALUES
('Toyota Camry', 2022, 'medium', 1, 'regular', 50, 300, 'rental company'),
('Honda Civic', 2021, 'compact', 1, 'regular', 40, 250, 'rental company'),
('Jeep Wrangler', 2022, 'SUV', 1, 'luxury', 150, 900, 'individual'),
('Ford F-150', 2021, 'truck', 1, 'regular', 80, 500, 'bank'),
('Toyota Sienna', 2021, 'van', 1, 'luxury', 120, 720, 'individual'),
('Chevrolet Impala', 2022, 'large', 1, 'regular', 70, 420, 'rental company'),
('Tesla Model S', 2021, 'medium', 1, 'luxury', 200, 1200, 'individual'),
('Nissan Rogue', 2022, 'SUV', 1, 'regular', 90, 540, 'bank'),
('Dodge Grand Caravan', 2021, 'van', 1, 'regular', 60, 360, 'rental company'),
('Ford Mustang', 2022, 'compact', 1, 'luxury', 100, 600, 'individual'),
('GMC Sierra 1500', 2021, 'truck', 1, 'regular', 110, 660, 'bank'),
('Toyota Corolla', 2022, 'compact', 1, 'regular', 45, 270, 'rental company'),
('Honda Odyssey', 2021, 'van', 1, 'regular', 70, 420, 'bank'),
('BMW 3 Series', 2022, 'medium', 1, 'luxury', 180, 1080, 'individual'),
('Chevrolet Silverado 1500', 2021, 'truck', 1, 'regular', 100, 600, 'bank'),
('Nissan Altima', 2022, 'medium', 1, 'regular', 50, 300, 'rental company'),
('Ford Transit Connect', 2021, 'van', 1, 'regular', 55, 330, 'rental company'),
('Mercedes-Benz C-Class', 2022, 'medium', 1, 'luxury', 220, 1320, 'individual'),
('Chevrolet Tahoe', 2021, 'SUV', 1, 'regular', 120, 720, 'bank'),
('Kia Sportage', 2022, 'SUV', 1, 'regular', 60, 360, 'rental company'),
('GMC Acadia', 2021, 'SUV', 1, 'luxury', 150, 900, 'individual'),
('Ram 1500', 2022, 'truck', 1, 'regular', 90, 540, 'bank'),
('Chevrolet Malibu', 2021, 'medium', 1, 'regular', 50, 300, 'rental company'),
('Toyota RAV4', 2022, 'SUV', 1, 'regular', 80, 480, 'bank'),
('Ford Explorer', 2021, 'SUV', 1, 'regular', 100, 600, 'rental company'),
('Chevrolet Camaro', 2022, 'compact', 1, 'luxury', 110, 660, 'individual'),
('GMC Yukon', 2021, 'SUV', 1, 'regular', 150, 900, 'bank'),
('Honda Accord', 2022, 'medium', 1, 'regular', 60, 360, 'rental company'),
('Ford Escape', 2021, 'SUV', 1, 'regular', 70, 420, 'bank'),
('Toyota Highlander', 2022, 'SUV', 1, 'luxury', 180, 1080, 'individual'),
('Nissan Sentra', 2021, 'compact', 1, 'regular', 40, 240, 'rental company'),
('Ford Edge', 2022, 'SUV', 1, 'regular', 80, 480, 'bank'),
('BMW X5', 2021, 'SUV', 1, 'luxury', 250, 1500, 'individual'),
('Jeep Grand Cherokee', 2022, 'SUV', 1, 'regular', 120, 720, 'bank'),
('Chevrolet Equinox', 2021, 'SUV', 1, 'regular', 60, 360, 'rental company'),
('Toyota Tacoma', 2022, 'truck', 1, 'regular', 80, 480, 'bank'),
('Honda Pilot', 2021, 'SUV', 1, 'regular', 90, 540, 'bank'),
('Jeep Compass', 2022, 'SUV', 1, 'regular', 70, 420, 'rental company'),
('Ram 2500', 2021, 'truck', 1, 'regular', 120, 720, 'bank'),
('Ford Ranger', 2022, 'truck', 1, 'regular', 70, 420, 'rental company'),
('Chevrolet Traverse', 2021, 'SUV', 1, 'luxury', 140, 840, 'individual'),
('Toyota Tundra', 2022, 'truck', 1, 'luxury', 200, 1200, 'individual'),
('Jeep Renegade', 2021, 'SUV', 1, 'regular', 50, 300, 'rental company'),
('Ford Bronco', 2022, 'SUV', 1, 'luxury', 220, 1320, 'individual');


select * from cars;