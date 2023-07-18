CREATE TABLE `availability` (
  `availabilityId` int NOT NULL AUTO_INCREMENT,
  `vehicleId` int NOT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  PRIMARY KEY (`availabilityId`),
  KEY `vehicleId` (`vehicleId`),
  CONSTRAINT `availability_ibfk_1` FOREIGN KEY (`vehicleId`) REFERENCES `cars` (`vehicleId`) ON DELETE RESTRICT ON UPDATE CASCADE
) AUTO_INCREMENT=100001 ;

select * from availability;