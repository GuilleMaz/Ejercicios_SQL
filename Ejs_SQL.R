#Paquete para carga de ficheros
library(data.table) 

# Cargamos el paquete sqldf
if(!require(sqldf)) install.packages("sqldf")
library(sqldf)


# Primero nos conectamos a la base de datos que creamos en "Creacion_BaseDatos.R", llamada "empresa.db"

conexion <- dbConnect(SQLite(), "empresa.db") 
# Verificamos que efectivamente se ha conectado, vemos la ruta y las tablas que hay
conexion
dbListTables(conexion)

empleados <- dbGetQuery(conexion, 'SELECT * FROM empleados')
departamentos <- dbGetQuery(conexion, 'SELECT * FROM departamentos')



#-------------------------------------------------------------------------------
# ENUNCIADOS CONSULTAS:
# 1. Obtener los datos completos de los empleados.
# 2. Obtener los datos completos de los departamentos
# 3. Obtener los datos de los empleados con cargo 'Secretaria'.
# 4. Obtener el nombre y salario de los empleados.
# 5. Obtener los datos de los empleados vendedores, ordenado por nombre.
# 6. Listar el nombre de los departamentos
# 7. Obtener el nombre y cargo de todos los empleados, ordenado por salario
# 8. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión
# 9. Listar todas las comisiones
# 10. Obtener el valor total a pagar que resulta de sumar a los empleados del departamento 3000 una
# bonificación de 500.000, en orden alfabético del empleado
# 11. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
# 12. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
# 13.Elabore un listado donde para cada fila, figure ‘Nombre’ y ‘Cargo’ antes del valor respectivo para cada empleado.
# 14. Hallar el salario y la comisión de aquellos empleados cuyo número de documento de identidad es
# superior al '19.709.802'
# 15. Muestra los empleados cuyo nombre empiece entre las letras J y Z (rango).
# Liste estos empleados y su cargo por orden alfabético.
# 16. Listar el salario, la comisión, el salario total (salario + comisión), documento de identidad del
# empleado y nombre, de aquellos empleados que tienen comisión superior a 1.000.000, ordenar el
# informe por el número del documento de identidad
# 17. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión
# 18. Hallar los empleados cuyo nombre no contiene la cadena "MA"
# 19. Obtener los nombres de los departamentos que no sean “Ventas” ni “Investigación” NI 'MANTENIMIENTO'.
#-------------------------------------------------------------------------------

# 1. Obtener los datos completos de los empleados.
dbGetQuery(conexion, 'SELECT * FROM empleados')

# 2. Obtener los datos completos de los departamentos
dbGetQuery(conexion, 'SELECT * FROM departamentos')

# 3. Obtener los datos de los empleados con cargo 'Secretaria'.
dbGetQuery(conexion, 'SELECT * FROM empleados
                      WHERE lower(cargoE) = "secretaria"') 
# La función lower() transforma a minúsculas: muy útil ya que puede ser que esté 
# escrito en mayúsculas o minúsculas

# 4. Obtener el nombre y salario de los empleados.
dbGetQuery(conexion, 'SELECT nomEmp, salEmp
                      FROM empleados')

# 5. Obtener los datos de los empleados vendedores, ordenado por nombre.
dbGetQuery(conexion, 'SELECT * FROM empleados
                      WHERE lower(cargoE) = "vendedor"
                      ORDER BY nomEmp')

# 6. Listar el nombre de los departamentos
dbGetQuery(conexion, 'SELECT DISTINCT nombreDpto 
                      FROM departamentos')
# Como los departamentos están repetidos: usamos DISTINCT

# 7. Obtener el nombre y cargo de todos los empleados, ordenado por salario
dbGetQuery(conexion, 'SELECT nomEmp, cargoE
                      FROM empleados
                      ORDER BY salEmp')

# 8. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión
dbGetQuery(conexion, 'SELECT salEmp, comisionE
                      FROM empleados
                      WHERE codDepto = "2000"
                      ORDER BY comisionE')

# 9. Listar todas las comisiones
dbGetQuery(conexion, 'SELECT DISTINCT comisionE FROM empleados')

# 10. Obtener el valor total a pagar que resulta de sumar a los empleados del departamento 3000 una
# bonificación de 500.000, en orden alfabético del empleado
dbGetQuery(conexion, 'SELECT salEmp as PagoAntes, (salEmp + 500000) as PagoNuevo
                      FROM empleados
                      WHERE codDEpto = "3000"
                      ORDER BY nomEmp')

# 11. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
dbGetQuery(conexion, 'SELECT nomEmp, salEmp, comisionE
                      FROM empleados
                      WHERE comisionE > salEmp')

# 12. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
dbGetQuery(conexion, 'SELECT nomEmp
                      FROM empleados
                      WHERE comisionE <= (30*salEmp/100)')

# Importante desconcetarse de la base de datos
dbDisconnect(conexion)

# 13.Elabore un listado donde para cada fila, figure ‘Nombre’ y ‘Cargo’ antes del valor respectivo para cada empleado.
dbGetQuery(conexion, 'SELECT nomemp as Nombre, cargoE as Cargo
           FROM empleados')

# 14. Hallar el salario y la comisión de aquellos empleados cuyo número de documento de identidad es superior al '19.709.802'
dbGetQuery(conexion, 'SELECT salEmp, comisionE
           FROM empleados
           WHERE nDIEmp > "19.709.802"') # En SQL podemos comparar cadenas de caracteres "como si fueran números"


# 15. Muestra los empleados cuyo nombre empiece entre las letras J y Z (rango). Liste estos empleados y su cargo por orden alfabético.
dbGetQuery(conexion, 'SELECT nomemp
           FROM empleados
           WHERE lower(nomemp) > "j" and lower(nomemp) < "z"
           ORDER BY nomemp')

# 16. Listar el salario, la comisión, el salario total (salario + comisión), documento de identidad del
# empleado y nombre, de aquellos empleados que tienen comisión superior a 1.000.000, ordenar el informe por el número del documento de identidad
dbGetQuery(conexion, 'SELECT salEmp, comisionE, (salEmp + comisionE) as salario_total, nDIEmp, nomemp
           FROM empleados
           WHERE comisionE > "1000000"
           ORDER BY nDIemp ASC')

# 17. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión
dbGetQuery(conexion, 'SELECT salEmp, comisionE, (salEmp + comisionE) as salario_total, nDIEmp, nomemp
           FROM empleados
           WHERE comisionE = "0"
           ORDER BY nDIemp ASC')

# 18. Hallar los empleados cuyo nombre no contiene la cadena "MA"
dbGetQuery(conexion, 'SELECT nomemp
           FROM empleados
           WHERE lower(nomemp) NOT LIKE "%ma%"')

# 19. Obtener los nombres de los departamentos que no sean “Ventas” ni “Investigación” ni 'MANTENIMIENTO'.
dbGetQuery(conexion, 'SELECT nombreDpto
           FROM departamentos
           WHERE lower(nombreDpto) NOT IN ("ventas", "investigación", "mantenimiento")')



#-------------------------------------------------------------------------------
# ENUNCIADOS MULTITABLAS:
# 20. Obtener el nombre y el departamento de los empleados con cargo 'Secretaria' o 'Vendedor', que
# no trabajan en el departamento de “PRODUCCION”, cuyo salario es superior a $1.000.000,
# ordenados por fecha de incorporación.
# 21. Obtener información de los empleados cuyo nombre tiene exactamente 11 caracteres
# 22. Obtener información de los empleados cuyo nombre tiene al menos 11 caracteres
# 23. Listar los datos de los empleados cuyo nombre inicia por la letra 'M', su salario es mayor a $800.000
# o reciben comisión y trabajan para el departamento de 'VENTAS'
# 24. Obtener los nombres, salarios y comisiones de los empleados que reciben un salario situado entre la
# mitad de la comisión la propia comisión
#-------------------------------------------------------------------------------

# 20. Obtener el nombre y el departamento de los empleados con cargo 'Secretaria' o 'Vendedor', que
# no trabajan en el departamento de “PRODUCCION”, cuyo salario es superior a $1.000.000,
# ordenados por fecha de incorporación.
dbGetQuery(conexion, 'SELECT e.nomEmp, d.nombreDpto, e.cargoE, e.salEmp, e.fecIncorporacion
          FROM empleados as e, departamentos as d
          WHERE e.codDepto = d.codDepto AND lower(e.cargoE) IN ("secretaria","vendedor")
          AND lower(d.nombreDpto) NOT IN ("producción")
          AND e.salEmp > "1000000"')

# 21. Obtener información de los empleados cuyo nombre tiene exactamente 11 caracteres

# 22. Obtener información de los empleados cuyo nombre tiene al menos 11 caracteres

# 23. Listar los datos de los empleados cuyo nombre inicia por la letra 'M', su salario es mayor a $800.000
# o reciben comisión y trabajan para el departamento de 'VENTAS'

# 24. Obtener los nombres, salarios y comisiones de los empleados que reciben un salario situado entre la
# mitad de la comisión la propia comisión

