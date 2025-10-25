# flutter_cinemapedia

Aplicación Flutter para explorar películas usando la API de The MovieDB.

## 🚀 Instalación rápida

1. Clona el repositorio:
   ```sh
   git clone https://github.com/ImSoulRebel/flutter_cinemapedia.git
   cd flutter_cinemapedia
   ```
2. Instala dependencias:
   ```sh
   flutter pub get
   ```

## 🔑 Configuración de entorno

1. Copia el archivo de ejemplo:
   ```
   cp env.template .env
   ```
2. Agrega tus credenciales de The MovieDB en `.env`.

## 🛠️ Generación de entidades

Si realizas cambios en las entidades, ejecuta:

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📦 Estructura del proyecto

- `lib/` Código principal de la app (config, domain, infrastructure, presentation)
- `assets/` Imágenes y recursos
- `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/` Soporte multiplataforma

## 📄 Recursos útiles

- [Documentación oficial de Flutter](https://flutter.dev/docs)
- [The MovieDB API](https://developers.themoviedb.org/3)

# Prod

Para cambiar el nombre del bundle de la App:

```
dart run change_app_package_name:main com.tudominio.package.appname
```
