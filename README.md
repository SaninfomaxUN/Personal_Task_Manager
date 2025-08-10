# Personal Task Manager

#### **Presentado por:** David Santiago Cruz Hernandez


## Descripcion
_Personal Task Manager_ es un prototipo de una aplicación para gestionar tareas personales. Permite crear, actualizar y eliminar tareas, asi como marcarlas como completadas. Además, contiene un panel de control para visualizar las tareas pendientes y completadas.
La aplicación móvil se desarrolló utilizando Flutter. El backend utiliza NestJS, implementa Mikro-ORM para la gestión de la base de datos, siguiendo las mejores prácticas del framework. Adicionalmente, se utiliza Docker para desplegar la aplicación en Google Cloud Platform (GCP). La base de datos es un modelo relacional sencillo, que se almacena en una base de datos PostgreSQL en GCP.

## Instrucciones de uso
1. Clonar el repositorio:
```bash 
git clone https://github.com/SaninfomaxUN/Personal_Task_Manager
```

2. Instalar las dependencias:
```bash
flutter pub get
```

3. Configurar la variable de entorno: `cp .env.ref .env`, donde `.env.ref` es el archivo de referencia que viene con el repositorio. Se debe reemplazar la variable de entorno `API_URL` con la URL del backend que se presenta mas adelante.

4. Ejecutar la aplicación:
```bash
flutter run
```

## Usuarios de prueba
- **usuario1**: password1
- **usuario2**: password2
- **usuario3**: password3

<br/>

## URL del backend desplegado en GCP
### `https://personal-task-manager-738021827547.us-central1.run.app/`

<br/>

## Información sobre la API
Cada uno de los endpoints se encuentra documentado en el siguiente enlace:
### `https://personal-task-manager-738021827547.us-central1.run.app/docs`

<br/>

## Capturas de pantalla

### Formulario de Sesión
![App Login](/docs/App_login.png)

### Lista de Tareas Pendientes
![App Pending Tasks](/docs/App_home.png)

### Lista de Tareas Completadas
![App Completed Tasks](/docs/App_completed.png)

### Agregar Tarea
![App Add Task](/docs/App_add.png)

### Actualizar Tarea
![App Update Task](/docs/App_update.png)

### Eliminar Tarea
![App Delete Task](/docs/App_delete.png)

## Decisiones técnicas

### Arquitectura

- El frontend y el backend se desarrollaron bajo la siguiente arquitectura de capas:

![Frontend Architecture](/docs/Frontend_architecture.png)
![Backend Architecture](/docs/Backend_architecture.png)

- <br/>

    - **auth**: En esta capa se encuentra la autenticación y protección de las rutas.
    - **config**: En esta capa se encuentran las configuraciones de la base de datos.
    - **controllers**: En esta capa se encuentran los endpoints de la API.
    - **docs**: En esta capa se encuentran la documentación de la API.
    - **models**: En esta capa se encuentran los modelos (DTOs y entidades) de la base de datos.
    - **modules**: En esta capa se encuentran los módulos de la aplicación.
    - **services**: En esta capa se encuentran la lógica de negocio.

<br/>

- La base de datos se desarrolló bajo los siguientes modelos planteados:

  - Modelo Conceptual
  
![Database Conceptual](/docs/DB_conceptual.png)

  - Modelo Lógico

![Database Logical](/docs/DB_logical.png)

  - Modelo Físico

![Database Physical](/docs/DB_physical.png)

## Soporte
- Articulos consultados
    - [Authentication](https://docs.nestjs.com/security/authentication)
    - [Encryption and Hashing](https://docs.nestjs.com/security/encryption-and-hashing)
    - [Setup NodeJS API with NestJS and Mikro-ORM](https://shiftasia.com/community/setup-nodejs-api-with-nestjs-and-mikro-orm/)
    - [Mastering DTOS in NestJS](https://dev.to/cendekia/mastering-dtos-in-nestjs-24e4)
- IAs consultadas: Qween, Gemini y ChatGPT
    - Se utilizaron como herramientas de consulta, soporte y resolución de errores.
    - En la carpeta `ai-conversations` se encuentran capturas de algunos de los prompts utilizados.



---

[![Imagen](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/SaninfomaxUN/Personal_Task_Manager)


