CREATE DATABASE IF NOT EXISTS feedyou
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
  
USE feedyou;

/* USUARIOS */
CREATE TABLE usuarios (
    email VARCHAR(255) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

/* CATEGORÍAS */
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL,
    hashtag_categoria VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

/* SUBCATEGORÍAS */
CREATE TABLE subcategorias (
    id_subcategoria INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    nombre_subcategoria VARCHAR(100) NOT NULL,
    hashtag_subcategoria VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE CASCADE
) ENGINE=InnoDB;

/* PREGUNTAS DEL TEST */
CREATE TABLE preguntas (
    id_pregunta INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    id_subcategoria INT NOT NULL,
    texto_pregunta TEXT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE CASCADE,
    FOREIGN KEY (id_subcategoria) REFERENCES subcategorias(id_subcategoria) ON DELETE CASCADE
) ENGINE=InnoDB;

/* RESPUESTAS DEL TEST */
CREATE TABLE respuestas_usuarios (
    id_respuesta INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    id_pregunta INT NOT NULL,
    id_categoria INT NOT NULL,
    id_subcategoria INT NOT NULL,
    seleccion BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY (email) REFERENCES usuarios(email) ON DELETE CASCADE,
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id_pregunta) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE CASCADE,
    FOREIGN KEY (id_subcategoria) REFERENCES subcategorias(id_subcategoria) ON DELETE CASCADE
) ENGINE=InnoDB;

/* PREFERENCIAS DEL TEST */
CREATE TABLE preferencias_test (
    id_preferencia INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    id_categoria INT NOT NULL,
    id_subcategoria INT NOT NULL,
    FOREIGN KEY (email) REFERENCES usuarios(email) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE CASCADE,
    FOREIGN KEY (id_subcategoria) REFERENCES subcategorias(id_subcategoria) ON DELETE CASCADE
) ENGINE=InnoDB;

/* PUBLICACIONES */
CREATE TABLE publicaciones (
    id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    email_autor VARCHAR(255) NOT NULL,
    id_categoria INT NOT NULL,
    id_subcategoria INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL,
    tipo ENUM('video', 'imagen', 'articulo') NOT NULL,
    url_media VARCHAR(500),
    enlace_externo VARCHAR(500),
    estado ENUM('pendiente', 'aprobado', 'rechazado') DEFAULT 'pendiente',
    fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (email_autor) REFERENCES usuarios(email) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE CASCADE,
    FOREIGN KEY (id_subcategoria) REFERENCES subcategorias(id_subcategoria) ON DELETE CASCADE
) ENGINE=InnoDB;

/* INTERACCIONES */
CREATE TABLE interacciones (
    id_interaccion INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    id_publicacion INT NOT NULL,
    tipo_interaccion ENUM('me_gusta', 'comentario', 'compartir', 'favorito') NOT NULL,
    comentario TEXT,
    tiempo_visualizacion INT,
    fecha_interaccion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (email) REFERENCES usuarios(email) ON DELETE CASCADE,
    FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion) ON DELETE CASCADE
) ENGINE=InnoDB;

/* HISTORIAL DE YOUBOT */
CREATE TABLE chat_youbot (
    id_chat INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    pregunta TEXT NOT NULL,
    respuesta TEXT NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (email) REFERENCES usuarios(email) ON DELETE CASCADE
) ENGINE=InnoDB;
