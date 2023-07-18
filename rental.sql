CREATE TABLE `rental` (
  `rentalId` int NOT NULL AUTO_INCREMENT,
  `vehicleId` int NOT NULL,
  `customerId` int NOT NULL,
  `rentalType` enum('daily','weekly') DEFAULT NULL,
  `noOfDaysORWeeks` int NOT NULL,
  `startDate` date DEFAULT NULL,
  `returnDate` date DEFAULT NULL,
  `amountDue` double DEFAULT NULL,
  PRIMARY KEY (`rentalId`),
  KEY `vehicleId` (`vehicleId`),
  KEY `customerId` (`customerId`),
  CONSTRAINT `rental_ibfk_1` FOREIGN KEY (`vehicleId`) REFERENCES `cars` (`vehicleId`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `rental_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `customers` (`customerId`) ON DELETE RESTRICT ON UPDATE CASCADE
)AUTO_INCREMENT=10001 ;

DELIMITER $$
CREATE  TRIGGER `before_rental_insert` BEFORE INSERT ON `rental` FOR EACH ROW BEGIN
  DECLARE daily_rate DOUBLE;
  DECLARE weekly_rate DOUBLE;
  DECLARE rental_rate DOUBLE;
  DECLARE rental_days_or_weeks INT;
  
  SELECT `dailyRate`, `weeklyRate` INTO daily_rate, weekly_rate
  FROM `cars`
  WHERE `vehicleId` = NEW.`vehicleId`;
  
  -- Calculate the rental rate based on the rental type
  IF NEW.`rentalType` = 'daily' THEN
    SET rental_rate = daily_rate;
    SET rental_days_or_weeks = NEW.`noOfDaysORWeeks`;
  ELSEIF NEW.`rentalType` = 'weekly' THEN
    SET rental_rate = weekly_rate;
    SET rental_days_or_weeks = NEW.`noOfDaysORWeeks`;
  END IF;
  -- Calculate the amount due for the rental
  SET NEW.`amountDue` = rental_rate * rental_days_or_weeks;
END;

DELIMITER $$
CREATE  TRIGGER `update_availability` AFTER INSERT ON `rental` FOR EACH ROW BEGIN
    UPDATE Cars SET IsAvailable = 0 WHERE vehicleId = NEW.vehicleId;
    
    SET @avail_start := (SELECT startDate FROM Availability WHERE vehicleId = NEW.vehicleId ORDER BY startDate LIMIT 1);
    SET @avail_end := (SELECT endDate FROM Availability WHERE vehicleId = NEW.vehicleId ORDER BY startDate LIMIT 1);
    
    IF NEW.startDate = @avail_start THEN
        UPDATE Availability SET startDate = DATE_ADD(NEW.returnDate, INTERVAL 1 DAY) WHERE vehicleId = NEW.vehicleId AND startDate = @avail_start;
    ELSEIF NEW.startDate > @avail_start THEN
        UPDATE Availability SET endDate = DATE_SUB(NEW.startDate, INTERVAL 1 DAY) WHERE vehicleId = NEW.vehicleId AND startDate = @avail_start;
        INSERT INTO Availability (vehicleId, startDate, endDate) VALUES (NEW.vehicleId, DATE_ADD(NEW.returnDate, INTERVAL 1 DAY), DATE_ADD(NEW.returnDate, INTERVAL 6 MONTH));
    END IF;
END;

INSERT INTO `rental` (`vehicleId`, `customerId`, `rentalType`, `noOfDaysORWeeks`, `startDate`, `returnDate`)
VALUES (1004, 1, 'daily', 5, '2023-05-01', '2023-05-05');

INSERT INTO `rental` (`vehicleId`, `customerId`, `rentalType`, `noOfDaysORWeeks`, `startDate`, `returnDate`)
VALUES (1013, 2, 'weekly', 2, '2023-06-01', '2023-06-14');

INSERT INTO `rental` (`vehicleId`, `customerId`, `rentalType`, `noOfDaysORWeeks`, `startDate`, `returnDate`)
VALUES (1001, 3, 'daily', 3, '2023-07-01', '2023-07-03');

INSERT INTO `rental` (`vehicleId`, `customerId`, `rentalType`, `noOfDaysORWeeks`, `startDate`, `returnDate`)
VALUES (1031, 4, 'weekly', 1, '2023-08-01', '2023-08-07');

INSERT INTO `rental` (`vehicleId`, `customerId`, `rentalType`, `noOfDaysORWeeks`, `startDate`, `returnDate`)
VALUES (1025, 5, 'daily', 4, '2023-09-01', '2023-09-04');

select * from rental;