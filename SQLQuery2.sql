USE DivisionPolitica;
GO

/* ============================================================
   1️⃣  ELIMINAR LA TABLA TEMPORAL SI YA EXISTE
   ============================================================ */
IF OBJECT_ID('tempdb..#Japon') IS NOT NULL
    DROP TABLE #Japon;
GO

/* ============================================================
   2️⃣  CREAR LA TABLA TEMPORAL #Japon
   ============================================================ */
CREATE TABLE #Japon (
    Prefectura VARCHAR(100) NOT NULL,
    Capital VARCHAR(100) NOT NULL,
    Area FLOAT NULL,
    Poblacion INT NULL
);
GO

/* ============================================================
   3️⃣  CARGAR LOS DATOS DEL ARCHIVO CSV
   ============================================================ */
BULK INSERT #Japon
FROM 'C:\\Users\\Gabriel Rivero\\Downloads\\Japon.csv'
WITH (
    DATAFILETYPE = 'char',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
GO

/* ============================================================
   4️⃣  VERIFICAR QUE LOS DATOS SE CARGARON CORRECTAMENTE
   ============================================================ */
SELECT COUNT(*) AS TotalFilasCargadas FROM #Japon;
GO

/* ============================================================
   5️⃣  MOSTRAR ALGUNAS FILAS PARA COMPROBAR CONTENIDO
   ============================================================ */
SELECT TOP 10 * FROM #Japon;
GO
DECLARE @IdPais INT, @IdTR INT, @IdC INT;

-- Verificar si existe el país
SET @IdPais = (SELECT TOP 1 Id FROM Pais WHERE Nombre='Japón');

IF @IdPais IS NULL
BEGIN
    -- Verificar tipo de región
    SET @IdTR = (SELECT TOP 1 Id FROM TipoRegion WHERE TipoRegion='Prefectura');
    IF @IdTR IS NULL
    BEGIN
        INSERT INTO TipoRegion (TipoRegion) VALUES ('Prefectura');
        SET @IdTR = @@IDENTITY;
    END

    -- Verificar continente
    SET @IdC = (SELECT TOP 1 Id FROM Continente WHERE Nombre='Asia');
    IF @IdC IS NULL
    BEGIN
        INSERT INTO Continente (Nombre) VALUES ('Asia');
        SET @IdC = @@IDENTITY;
    END

    -- Insertar país Japón
    INSERT INTO Pais (Nombre, IdContinente, IdTipoRegion)
    VALUES ('Japón', @IdC, @IdTR);

    SET @IdPais = @@IDENTITY;
END
INSERT INTO Region (Nombre, IdPais, Area, Poblacion)
SELECT J.Prefectura, @IdPais, J.Area, J.Poblacion
FROM #Japon J;
SELECT P.Nombre AS Pais, R.Nombre AS Region, C.Nombre AS Ciudad
FROM Pais P
JOIN Region R ON P.Id = R.IdPais
JOIN Ciudad C ON R.Id = C.IdRegion
WHERE P.Nombre = 'Japón';