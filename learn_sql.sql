CREATE DATABASE LearnSQL

CREATE TABLE Fakultas(
    ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FakultasName varchar(100),
)

INSERT INTO Fakultas(FakultasName)
VALUES('Teknik Elektro'),
      ('Rekayasa Industri'),
      ('Informatika'),
      ('Ekonomi dan Bisnis'),
      ('Komunikasi dan Bisnis'),
      ('Industri Kreatif'),
      ('Ilmu Terapan')

CREATE TABLE Jurusan(
    ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    JurusanName varchar(100),
    FakultasID int FOREIGN KEY REFERENCES Fakultas(ID)
)

INSERT INTO Jurusan(JurusanName, FakultasID)
VALUES ('Teknik Telekomunikasi', 1),
       ('Teknik Elektro', 1),
       ('Teknik Fisika', 1),
       ('Teknik Komputer', 1),
       ('Teknik Industri', 2),
       ('Administrasi Bisnis', 5),
       ('Akuntansi', 4),
       ('Manajemen Bisnis Telekomunikasi dan Informatika', 4),
       ('Desain Komunikasi Visual', 6)

SELECT Jurusan.ID, Jurusan.JurusanName, Fakultas.ID, Fakultas.FakultasName
FROM Jurusan
RIGHT JOIN Fakultas ON Jurusan.FakultasID = Fakultas.ID

CREATE TABLE Jabatan(
    ID int IDENTITY(1,1) NOT NULL PRIMARY KEY ,
    JabatanName varchar(100)
)

CREATE TABLE Departemen(
    ID int IDENTITY(1,1) NOT NULL PRIMARY KEY ,
    DepartemenName varchar(100)
)

CREATE TABLE Anggota(
    ID int IDENTITY (1,1) NOT NULL PRIMARY KEY ,
    AnggotaNIM varchar(30),
    AnggotaName varchar(255),
    AnggotaPhoneNumber varchar(20),
    DepartemenID int FOREIGN KEY REFERENCES Departemen(ID),
    JabatanID int FOREIGN KEY REFERENCES Jabatan(ID),
    JurusanID int FOREIGN KEY REFERENCES Jurusan(ID),
    IsAlumni bit
)

INSERT INTO Anggota(AnggotaNIM, AnggotaName, AnggotaPhoneNumber, DepartemenID, JabatanID, JurusanID, IsAlumni)
VALUES ('11017405', 'Muhammad Rafly Rafsanjani', '081295940847', 1, 1, 4, 0),
       ('11017105', 'Iqbal Arbai', '081225940847', 1, 2, 1, 1)

SELECT * FROM Anggota

SELECT Anggota.ID, Anggota.AnggotaNIM, Anggota.AnggotaName, Departemen.DepartemenName, Jabatan.JabatanName, Jurusan.JurusanName
FROM Anggota
INNER JOIN Departemen on Anggota.DepartemenID = Departemen.ID
INNER JOIN Jabatan on Anggota.JabatanID = Jabatan.ID
INNER JOIN Jurusan on Anggota.JurusanID = Jurusan.ID


CREATE TABLE Users(
    ID int IDENTITY (1,1) NOT NULL PRIMARY KEY ,
    FullName varchar(255),
    EmailAddress varchar(255),
    Password varchar(255),
    AnggotaID int FOREIGN key REFERENCES Anggota(ID),
    IsActive BIT,
)

INSERT INTO Users(FullName, EmailAddress, Password, AnggotaID, IsActive)
VALUES ('Iqbal A', 'iqbal.a@gmail.com', 'iqbal', 2, 0)

SELECT FullName, EmailAddress, AnggotaName, DepartemenName, JabatanName, JurusanName
FROM Users
INNER JOIN Anggota on Users.AnggotaID = Anggota.ID
INNER JOIN Departemen on Anggota.DepartemenID = Departemen.ID
INNER JOIN Jurusan On Anggota.JurusanID = Jurusan.ID
INNER JOIN Jabatan On Anggota.JabatanID = Jabatan.ID