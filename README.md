# coink-coding-challenge
Coding challenge para Coink

Se entrega el repositorio git coink-coding-challenge con lo siguiente:
Scripts de base de datos: PostgreSQL.
Código fuente: C# con Web API REST.

Pasos para probarlo:

** Clonar el proyecto:
Desde GitHub usando Git Bash con el comando:
git clone https://github.com/se-juanmercado/coink-coding-challenge.git

** Configurar la base de datos:
Crear las tablas de la base de datos ejecutando los scripts dentro del directorio bd_scripts. Ejecutarlos en el siguiente orden:
- create_tables.sql: Creación de tablas.
- inserts_params_tables.sql: Alimentación de las tablas de parámetros (countries, departments, municipalities).
- sp_create_user.sql: Creación del procedimiento almacenado.
	Notas:
		- Se pueden encontrar datos de prueba en el archivo sp_create_user_test.sql.
		- Existe un archivo de funciones, pero se debe ignorar, ya que inicialmente se creó una función en lugar de un procedimiento almacenado.
		- En utils.sql se pueden encontrar algunas consultas para revisar los datos parametrizados y consultar usuarios.
		- En la tabla users pueden encontrar algunos campos para actualizar debido a que en el diseño se pensó para dejarlo escalable.

** Conexión a la base de datos:
	El usuario de la BD está configurado en el archivo appsettings.json (nombre de la base de datos: coink_test).

** Ejecución del proyecto:
	Una vez alimentada la base de datos y descargado el proyecto, abrir el directorio con un editor de código como VS Code o Visual Studio. Para arrancar el proyecto, ejecutar el comando:
	dotnet run.
	
	La aplicación debería desplegarse sin ningún problema.

** Documentación de la API
	La interfaz de Swagger está disponible en la siguiente dirección, donde se puede probar el endpoint:
	http://localhost:5055/swagger/index.html
	
	
- Importante:

Se realizaron todas las validaciones pertinentes. Se debe tener en cuenta que, al momento de consumir la API, los datos son sensibles a mayúsculas, minúsculas y tildes. 
Esta decisión se tomó debido a que en el proyecto solo se expone una API y no cuenta con una interfaz gráfica; por lo tanto, la lógica del procedimiento 
almacenado en la base de datos asegura la integridad de la información.

Les comparto un ejemplo de request funcional:

{
  "name": "Juan Coink",
  "phone": "3234450273",
  "address": "Cll 13",
  "country": "Colombia",
  "department": "Atlántico",
  "municipality": "Barranquilla",
  "createdBy": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
} 

