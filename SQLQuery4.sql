USE DivisionPolitica;
GO

ALTER TABLE Pais
ADD 
    MonedaNombre VARCHAR(50) NULL,   -- Campo para almacenar el nombre de la moneda
    Mapa VARBINARY(MAX) NULL,        -- Imagen del mapa
    Bandera VARBINARY(MAX) NULL;     -- Imagen de la bandera
GO
UPDATE Pais
SET MonedaNombre = 'Yen japonés'
WHERE Nombre = 'Japón';
GO
SELECT 
    Id AS IdPais,
    Nombre AS Pais,
    MonedaNombre AS Moneda,
    Mapa,
    Bandera
FROM Pais;
GO
