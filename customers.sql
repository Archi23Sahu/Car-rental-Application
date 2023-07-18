CREATE TABLE `customers` (
  `customerId` int NOT NULL AUTO_INCREMENT,
  `custname` varchar(225) DEFAULT NULL,
  `phone` varchar(225) DEFAULT NULL,
  `customerType` enum('business','individual') DEFAULT NULL,
  PRIMARY KEY (`customerId`),
  CONSTRAINT `chk_name` CHECK (regexp_like(`custname`,_utf8mb4'^[A-Z]\\.[A-Z][a-z]+$')),
  CONSTRAINT `chk_phone` CHECK ((`phone` like _utf8mb4'___-___-____'))
)  AUTO_INCREMENT=1 ;

INSERT INTO `customers` (`custname`, `phone`, `customerType`)
VALUES
  ('J.Doe', '123-456-7890', 'individual'),
  ('J.Smith', '234-567-8901', 'business'),
  ('B.Johnson', '345-678-9012', 'individual'),
  ('S.James', '456-789-0123', 'business'),
  ('B.Brown', '567-890-1234', 'individual'),
  ('A.Green', '678-901-2345', 'business'),
  ('T.Jones', '789-012-3456', 'individual'),
  ('L.White', '890-123-4567', 'business'),
  ('M.Black', '901-234-5678', 'individual'),
  ('K.Lee', '012-345-6789', 'business');

Select * from customers;