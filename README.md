# Gastos App - Flutter 💸

Una aplicación móvil desarrollada con Flutter para registrar y gestionar gastos e ingresos personales de manera sencilla y eficiente.

## ✨ Características Principales

*   **Registro de Transacciones**: Añade fácilmente nuevos gastos o ingresos especificando monto, categoría, descripción y fecha.
*   **Edición y Eliminación**: Modifica o elimina transacciones existentes.
*   **Resumen Financiero**: Visualiza un resumen de tus ingresos, gastos totales y el balance actual.
*   **Gráfico de Gastos**: Un gráfico circular muestra la distribución de tus gastos por categoría.
*   **Historial de Transacciones**: Consulta una lista detallada de todas tus transacciones, con la posibilidad de filtrarlas o buscarlas (funcionalidad futura).
*   **Persistencia de Datos**: Las transacciones se guardan localmente en el dispositivo usando una base de datos SQLite.
*   **Interfaz Intuitiva**: Diseño limpio y fácil de usar siguiendo los principios de Material Design.

## 📸 Capturas de Pantalla (Ejemplos)



<p align="center">
  <img src="https://github.com/IsraelMerlyn/gastos_app/blob/main/lib/screenshot/home.png" width="200" alt="Pantalla Principal">
  <img src="https://github.com/IsraelMerlyn/gastos_app/blob/main/lib/screenshot/history.png" width="200" alt="Formulario de Transacción">
  <img src="https://github.com/IsraelMerlyn/gastos_app/blob/main/lib/screenshot/formulario.png" width="200" alt="Historial">
</p>

_(Próximamente se añadirán capturas de pantalla)_

## 🛠️ Tecnologías y Dependencias Utilizadas

*   **Flutter**: Framework principal para el desarrollo de la interfaz de usuario.
*   **Dart**: Lenguaje de programación utilizado.
*   **Provider**: Para la gestión del estado de la aplicación.
*   **sqflite**: Para la base de datos local SQLite.
*   **path_provider**: Para obtener las rutas del sistema de archivos donde guardar la base de datos.
*   **uuid**: Para generar IDs únicos para las transacciones.
*   **intl**: Para formateo de fechas y números (internacionalización).
*   **fl_chart** (o similar): Para la creación de gráficos (si estás usando una librería específica para el `ExpenseChart`).

## 🚀 Configuración del Proyecto

1.  **Clonar el repositorio**:
    ```bash
    git clone https://tu_repositorio/gastos_app.git
    cd gastos_app
    ```
2.  **Instalar dependencias de Flutter**:
    ```bash
    flutter pub get
    ```
3.  **Ejecutar la aplicación**:
    Asegúrate de tener un emulador en ejecución o un dispositivo conectado.
    ```bash
    flutter run
    ```

## 📋 Uso

1.  **Pantalla Principal (Resumen)**:
    *   Visualiza tus ingresos, gastos y balance.
    *   Observa el gráfico de distribución de gastos.
    *   Usa el botón (+) en la AppBar para añadir una nueva transacción.
    *   Accede al historial de transacciones desde el icono de historial en la AppBar.

2.  **Formulario de Transacción**:
    *   Ingresa el monto y la descripción.
    *   Selecciona la categoría, el tipo (gasto/ingreso) y la fecha.
    *   Guarda la transacción.

3.  **Historial de Transacciones**:
    *   Ve una lista de todas tus transacciones.
    *   Toca una transacción para editarla o deslízala para eliminarla.




