CREATE DATABASE Discografia
GO

USE Discografia
GO

CREATE TABLE Pais(
	Id int IDENTITY(0,1) NOT NULL,
	Pais nvarchar(50) NOT NULL)
	
ALTER TABLE Pais
	ADD CONSTRAINT pkPais_Id PRIMARY KEY (Id)
	
CREATE UNIQUE INDEX ixPais_Pais
	ON Pais(Pais)

CREATE TABLE Tipo(
	Id int IDENTITY(0,1) NOT NULL,
	Tipo nvarchar(50) NOT NULL)
	
ALTER TABLE Tipo
	ADD CONSTRAINT pkTipo_Id PRIMARY KEY (Id)
	
CREATE UNIQUE INDEX ixTipo_Tipo
	ON Tipo(Tipo)

CREATE TABLE Ritmo(
	Id int IDENTITY(0,1) NOT NULL,
	CONSTRAINT pkRegion_Id PRIMARY KEY (Id),
	Ritmo nvarchar(50) NOT NULL)

CREATE UNIQUE INDEX ixRitmo_Ritmo
	ON Ritmo(Ritmo)
	
CREATE TABLE Formato(
	Id int IDENTITY(0,1) NOT NULL,
	CONSTRAINT pkFormato_Id PRIMARY KEY (Id),
	Formato nvarchar(50) NOT NULL)
	
CREATE UNIQUE INDEX ixFormato_Formato
	ON Formato(Formato)

CREATE TABLE Medio(
	Id int IDENTITY(0,1) NOT NULL,
	CONSTRAINT pkMedio_Id PRIMARY KEY (Id),
	Medio nvarchar(50) NOT NULL)
	
CREATE UNIQUE INDEX ixMedio_Nombre
	ON Medio(Medio)

CREATE TABLE Idioma(
	Id int IDENTITY(0,1) NOT NULL,
	CONSTRAINT pkIdioma_Id PRIMARY KEY (Id),
	Idioma nvarchar(50) NOT NULL)
	
CREATE UNIQUE INDEX ixIdioma_Idioma
	ON Idioma(Idioma)

CREATE TABLE Compositor(
	Id int IDENTITY(0,1) NOT NULL, 
	CONSTRAINT pkCompositor_Id PRIMARY KEY (Id), 
	Nombre nvarchar(50) NOT NULL, 
	IdPais int NOT NULL, 
	CONSTRAINT fkCompositor_IdPais FOREIGN KEY (IdPais) REFERENCES Pais (Id),
	Foto image NULL)

CREATE UNIQUE INDEX ixCompositor_Nombre
	ON Compositor(Nombre)

CREATE TABLE Cancion(
	Id int IDENTITY(1,1) NOT NULL, 
	CONSTRAINT pkCancion_Id PRIMARY KEY (Id), 
	Titulo nvarchar(50) NOT NULL, 
	IdIdioma int NOT NULL, 
	CONSTRAINT fkCancion_IdIdioma FOREIGN KEY (IdIdioma) REFERENCES Idioma (Id))

CREATE INDEX ixCancion_Titulo
	ON Cancion(Titulo)

ALTER TABLE Cancion
	ADD Letra nvarchar(MAX) NULL

CREATE TABLE Interprete(
	Id int IDENTITY(0,1) NOT NULL, 
	CONSTRAINT pkInterprete_Id PRIMARY KEY (Id), 
	Nombre nvarchar(50) NOT NULL, 
	IdTipo int NOT NULL, 
	CONSTRAINT fkInterprete_IdTipo FOREIGN KEY (IdTipo) REFERENCES Tipo (Id),
	IdPais int NOT NULL, 
	CONSTRAINT fkInterprete_IdPais FOREIGN KEY (IdPais) REFERENCES Pais (Id),
	Foto image NULL)

CREATE UNIQUE INDEX ixInterprete_Nombre
	ON Interprete(Nombre)

CREATE TABLE Interpretacion(
	Id int IDENTITY(1,1) NOT NULL, 
	CONSTRAINT pkInterpretacion_Id PRIMARY KEY (Id), 
	Duracion nvarchar(10) NULL, 
	IdInterprete int NOT NULL, 
	CONSTRAINT fkInterpretacion_IdInterprete FOREIGN KEY (IdInterprete) REFERENCES Interprete (Id),
	IdCancion int NOT NULL, 
	CONSTRAINT fkInterpretacion_IdCancion FOREIGN KEY (IdCancion) REFERENCES Cancion (Id),
	IdRitmo int NOT NULL, 
	CONSTRAINT fkInterpretacion_IdRitmo FOREIGN KEY (IdRitmo) REFERENCES Ritmo (Id))

CREATE TABLE CancionCompositor (
	IdCancion int NOT NULL,
	IdCompositor int NOT NULL,
	CONSTRAINT pkCancionCompositor PRIMARY KEY (IdCancion, IdCompositor),
	CONSTRAINT fkCancionCompositor_IdCancion FOREIGN KEY (IdCancion) REFERENCES Cancion (Id),
	CONSTRAINT fkCancionCompositor_IdCompositor FOREIGN KEY (IdCompositor) REFERENCES Compositor (Id))

CREATE TABLE Album(
	Id int IDENTITY(1,1) NOT NULL, 
	CONSTRAINT pkAlbum_Id PRIMARY KEY (Id), 
	Titulo nvarchar(50) NOT NULL, 
	IdMedio int NOT NULL, 
	CONSTRAINT fkAlbum_IdMedio FOREIGN KEY (IdMedio) REFERENCES Medio (Id),
	Registro nvarchar(50) NULL)

CREATE INDEX ixAlbum_Titulo
	ON Album(Titulo)

CREATE TABLE Grabacion (
	IdInterpretacion int IDENTITY(1,1) NOT NULL,
	IdAlbum int NOT NULL,
	IdFormato int NOT NULL,
	CONSTRAINT pkGrabacion PRIMARY KEY (IdInterpretacion, IdAlbum, IdFormato),
	CONSTRAINT fkGrabacion_IdInterpretacion FOREIGN KEY (IdInterpretacion) REFERENCES Interpretacion (Id),
	CONSTRAINT fkGrabacion_IdAlbum FOREIGN KEY (IdAlbum) REFERENCES Album (Id),
	CONSTRAINT fkGrabacion_IdFormato FOREIGN KEY (IdFormato) REFERENCES Formato (Id))
