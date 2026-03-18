# En este script vamos a crear la base de datos sobre la que vamos a realizar las consultas SQL

# Datos extraídos de los un archivo de MySQL del vídeo de youtube

# Tabla DEPARTAMENTOS
departamentos <- data.frame(
  codDepto = c('1000','1500','2000','2100','2200','2300','3000','3500','4000','4100','4200','4300'),
  nombreDpto = c('GERENCIA','PRODUCCIÓN','VENTAS','VENTAS','VENTAS','VENTAS','INVESTIGACIÓN','MERCADEO','MANTENIMIENTO','MANTENIMIENTO','MANTENIMIENTO','MANTENIMIENTO'),
  ciudad = c('CIUDAD REAL','CIUDAD REAL','CIUDAD REAL','BARCELONA','VALENCIA','MADRID','CIUDAD REAL','CIUDAD REAL','CIUDAD REAL','BARCELONA','VALENCIA','MADRID'),
  codDirector = c('31.840.269','16.211.383','31.178.144','16.211.383','16.211.383','16.759.060','16.759.060','22.222.222','333.333.333','16.759.060','16.759.060','16.759.060'),
  stringsAsFactors = FALSE
)

# Tabla de EMPLEADOS

empleados <- data.frame(
  nDIEmp = c('1.130.222','1.130.333','1.130.444','1.130.555','1.130.666','1.130.777','1.130.782','1.751.219','11.111.111','16.211.383','16.759.060','19.709.802','22.222.222','22.222.333','31.174.099','31.178.144','31.840.269','333.333.333','333.333.334','333.333.335','333.333.336','333.333.337','444.444','737.689','768.782','888.888'),
  nomEmp = c('José Giraldo','Pedro Blanco','Jesús Alfonso','Julián Mora','Manuel Millán','Marcos Cortez','Antonio Gil','Melissa Roa','Irene Díaz','Luis Pérez','Darío Casas','William Daza','Carla López','Carlos Rozo','Diana Solarte','Rosa Angulo','María Rojas','Elisa Rojas','Marisol Pulido','Ana Moreno','Carolina Ríos','Edith Muñoz','Abel Gómez','Mario Llano','Joaquín Rosas','Iván Duarte'),
  sexEmp = c('M','M','M','M','M','M','M','F','F','M','M','M','F','M','F','F','F','F','F','F','F','F','M','M','M','M'),
  fecNac = as.Date(c('1985-01-20','1987-10-28','1988-03-14','1989-07-03','1990-12-08','1986-06-23','1980-01-23','1960-06-19','1979-09-28','1956-02-25','1960-04-05','1982-10-09','1975-05-11','1975-05-11','1957-11-19','1957-03-15','1959-01-15','1979-09-28','1979-10-01','1992-01-05','1992-02-15','1992-03-31','1939-12-24','1945-08-30','1947-07-07','1955-08-12')),
  fecIncorporacion = as.Date(c('2000-11-01','2000-10-01','2000-10-01','2000-10-01','2004-06-01','2000-04-16','2010-04-16','2001-03-16','2004-06-01','2000-01-01','1992-11-01','1999-12-16','2005-07-16','2001-09-16','1990-05-16','1998-08-16','1990-05-16','2004-06-01','1990-05-16','2004-06-01','2000-10-01','2000-10-01','2000-10-01','1990-05-16','1990-05-16','1998-05-16')),
  salEmp = c(1200000,800000,800000,800000,800000,2550000,850000,2250000,1050000,5050000,4500000,2250000,4500000,750000,1250000,3250000,6250000,3000000,3250000,1200000,1250000,800000,1050000,2250000,2250000,1050000),
  comisionE = c(400000,3000000,3500000,3100000,3700000,500000,1500000,2500000,200000,0,500000,1000000,500000,500000,500000,3500000,1500000,1000000,1000000,400000,500000,3600000,200000,2500000,2500000,200000),
  cargoE = c('Asesor','Vendedor','Vendedor','Vendedor','Vendedor','Mecánico','Técnico','Vendedor','Mecánico','Director','Investigador','Investigador','Jefe Mercadeo','Vigilante','Secretaria','Jefe Ventas','Gerente','Jefe Mecánicos','Investigador','Secretaria','Secretaria','Vendedor','Mecánico','Vendedor','Vendedor','Mecánico'),
  jefeID = c('22.222.222','31.178.144','31.178.144','31.178.144','31.178.144','333.333.333','16.211.383','31.178.144','333.333.333','31.840.269','31.840.269','16.759.060','31.840.269','31.840.269','31.840.269','31.840.269',NA,'31.840.269','16.759.060','16.759.060','16.211.383','31.178.144','333.333.333','31.178.144','31.178.144','333.333.333'),
  codDepto = c('3500','2000','2000','2200','2300','4000','1500','2100','4200','1500','3000','3000','3500','3500','1000','2000','1000','4000','3000','3000','1500','2100','4300','2300','2200','4100'),
  stringsAsFactors = FALSE
)

# Interfaz que permite comunicar con DBMS
if(!require(DBI)) install.packages("DBI")
library(DBI)

# Paquete para conexión BBDD SQL:
if(!require(RSQLite)) install.packages("RSQLite")
library(RSQLite) # DBMS específico (ej: MySQL, PostgreSQL)


# Conexión a la Base de Datos
conexion <- dbConnect(SQLite(), "empresa.db") 
conexion  # Ruta y check verificación

# Ahora escribimos en la base de datos los data frames DEPARTAMENTOS y EMPLEADOS creados

# Escribir la tabla departamentos
dbWriteTable(conexion, "departamentos", departamentos, overwrite = TRUE)

# Escribir la tabla empleados
dbWriteTable(conexion, "empleados", empleados, overwrite = TRUE)

# NOTA: overwrite = TRUE borrará la tabla si ya existía en la base de datos y la 
# creará de nuevo. Si se quisiera añadir datos a una tabla existente sin borrarla, 
# usaríamos append = TRUE

dbListTables(conexion) # Para saber las tablas que hay en la base de datos

# Imprescindibel desconectarse de la base de datos:
dbDisconnect(conexion)


