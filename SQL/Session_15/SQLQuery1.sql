CREATE TABLE Patients_Not_1NF
(
    PatientID INT,
    PatientName VARCHAR(100),
    Diseases VARCHAR(500)
);

INSERT INTO Patients_Not_1NF
VALUES
(1,'Rahul','Diabetes,Hypertension'),
(2,'Priya','Asthma'),
(3,'Ankit','Diabetes,Fever,Cough');

select * from Patients_Not_1NF

---Find  all patients hving diabetes

CREATE TABLE PatientDiseases1NF
(
    PatientID INT,
    PatientName VARCHAR(100),
    Disease VARCHAR(100)
);

insert into PatientDiseases1NF
(
PatientID,
PatientName,
Disease
)
SELECT P.PatientID,P.PatientName,trim(D.value) as Disease FROM Patients_Not_1NF P cross apply string_split(P.Diseases,',') as D

select * from PatientDiseases1NF where Disease = 'Diabetes'

CREATE TABLE PatientTreatment_1NF
(
    PatientID INT,
    DiseaseID INT,
    PatientName VARCHAR(100),
    PatientPhone VARCHAR(20),
    DiseaseName VARCHAR(100),
    TreatmentCost DECIMAL(10,2),
    TreatmentDate DATE,
    PRIMARY KEY (PatientID, DiseaseID)
);

INSERT INTO PatientTreatment_1NF
VALUES
(1,101,'Rahul','9876543210','Diabetes',5000,'2025-01-10'),
(1,102,'Rahul','9876543210','Hypertension',3000,'2025-01-15'),
(2,103,'Priya','9988776655','Asthma',4000,'2025-02-01'),
(3,101,'Ankit','8877665544','Diabetes',5000,'2025-02-10');

select * from PatientTreatment_1NF

CREATE TABLE DimPatient
(
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(100),
    PatientPhone VARCHAR(20)
);

INSERT INTO DimPatient
(
    PatientID,
    PatientName,
    PatientPhone
)
SELECT DISTINCT
       PatientID,
       PatientName,
       PatientPhone
FROM PatientTreatment_1NF;

CREATE TABLE DimDisease
(
    DiseaseID INT PRIMARY KEY,
    DiseaseName VARCHAR(100),
    TreatmentCost DECIMAL(10,2)
);

INSERT INTO DimDisease
(
    DiseaseID,
    DiseaseName,
    TreatmentCost
)
SELECT DISTINCT
       DiseaseID,
       DiseaseName,
       TreatmentCost
FROM PatientTreatment_1NF;

select * from DimDisease
select * from DimPatient
select * from FactPatientTreatment
select * from PatientTreatment_1NF

CREATE TABLE FactPatientTreatment
(
    PatientID INT,
    DiseaseID INT,
    TreatmentDate DATE,
    PRIMARY KEY (PatientID,DiseaseID)
);
INSERT INTO FactPatientTreatment
(
    PatientID,
    DiseaseID,
    TreatmentDate
)
SELECT
       PatientID,
       DiseaseID,
       TreatmentDate
FROM PatientTreatment_1NF;


SELECT
      P.PatientID,
      P.PatientName,
      P.PatientPhone,
      D.DiseaseName,
      D.TreatmentCost,
      F.TreatmentDate
FROM FactPatientTreatment F
INNER JOIN DimPatient P
       ON F.PatientID = P.PatientID
INNER JOIN DimDisease D
       ON F.DiseaseID = D.DiseaseID;


CREATE TABLE DimPatient1
(
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(100),
    ZipCode VARCHAR(10),
    City VARCHAR(50),
    StateName VARCHAR(50)
);

INSERT INTO DimPatient1
VALUES
(1,'Rahul','560001','Bangalore','Karnataka'),
(2,'Priya','400001','Mumbai','Maharashtra'),
(3,'Ankit','560001','Bangalore','Karnataka');
select * from DimPatient1


CREATE TABLE DimZipCode
(
    ZipCode VARCHAR(10) PRIMARY KEY,
    City VARCHAR(50),
    StateName VARCHAR(50)
);
INSERT INTO DimZipCode
(
    ZipCode,
    City,
    StateName
)
SELECT DISTINCT
       ZipCode,
       City,
       StateName
FROM DimPatient1;

select * from DimZipCode

CREATE TABLE DimPatient_3NF
(
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(100),
    ZipCode VARCHAR(10)
);

INSERT INTO DimPatient_3NF
(
    PatientID,
    PatientName,
    ZipCode
)
SELECT
       PatientID,
       PatientName,
       ZipCode
FROM DimPatient1;

SELECT
      P.PatientID,
      P.PatientName,
      Z.ZipCode,
      Z.City,
      Z.StateName
FROM DimPatient_3NF P
INNER JOIN DimZipCode Z
       ON P.ZipCode = Z.ZipCode;