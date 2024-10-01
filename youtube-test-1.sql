-- Obtener todos los videos y sus respectivos usuarios
SELECT 
    'Videos y Usuarios' AS tipo,
    u.nombre AS nombre_usuario,
    v.titulo AS titulo_video,
    v.likes,
    v.dislikes
FROM 
    youtube.usuarios u
JOIN 
    youtube.videos v ON u.id_usuario = v.id_canal

-- Obtener todos los comentarios y sus respectivos usuarios
SELECT 
    'Comentarios y Usuarios' AS tipo,
    u.nombre AS nombre_usuario,
    c.texto AS comentario,
    v.titulo AS titulo_video,
    NULL AS likes,
    NULL AS dislikes
FROM 
    youtube.comentarios c
JOIN 
    youtube.usuarios u ON c.id_usuario = u.id_usuario
JOIN 
    youtube.videos v ON c.id_video = v.id_video

-- Obtener todas las playlists y sus respectivos videos
SELECT 
    'Playlists y Videos' AS tipo,
    NULL AS nombre_usuario,
    p.nombre AS nombre_playlist,
    v.titulo AS titulo_video,
    NULL AS likes,
    NULL AS dislikes
FROM 
    youtube.playlists p
JOIN 
    youtube.videosplaylist vp ON p.id_playlist = vp.id_playlist
JOIN 
    youtube.videos v ON vp.id_video = v.id_video

-- Obtener todos los likes de videos y sus respectivos usuarios
SELECT 
    'Likes de Videos' AS tipo,
    u.nombre AS nombre_usuario,
    v.titulo AS titulo_video,
    lv.likes,
    NULL AS dislikes
FROM 
    youtube.likesvideo lv
JOIN 
    youtube.usuarios u ON lv.id_usuario = u.id_usuario
JOIN 
    youtube.videos v ON lv.id_video = v.id_video

-- Obtener todos los dislikes de videos y sus respectivos usuarios
SELECT 
    'Dislikes de Videos' AS tipo,
    u.nombre AS nombre_usuario,
    v.titulo AS titulo_video,
    NULL AS likes,
    dv.dislike
FROM 
    youtube.dislikevideo dv
JOIN 
    youtube.usuarios u ON dv.id_usuario = u.id_usuario
JOIN 
    youtube.videos v ON dv.id_video = v.id_video

-- Obtener todas las suscripciones de usuarios a canales
SELECT 
    'Suscripciones' AS tipo,
    u.nombre AS nombre_usuario,
    c.nombre AS nombre_canal,
    NULL AS likes,
    NULL AS dislikes
FROM 
    youtube.subscripciones s
JOIN 
    youtube.usuarios u ON s.id_usuario = u.id_usuario
JOIN 
    youtube.canales c ON s.id_canal = c.id_canal

-- Obtener todas las etiquetas y los videos a los que pertenecen
SELECT 
    'Etiquetas y Videos' AS tipo,
    NULL AS nombre_usuario,
    e.nombre AS nombre_etiqueta,
    v.titulo AS titulo_video,
    NULL AS likes,
    NULL AS dislikes
FROM 
    youtube.etiquetas e
JOIN 
    youtube.etiquetasvideo ev ON e.id_etiqueta = ev.id_etiqueta
JOIN 
    youtube.videos v ON ev.id_video = v.id_video

-- Obtener todos los likes en comentarios y sus respectivos usuarios
SELECT 
    'Likes en Comentarios' AS tipo,
    u.nombre AS nombre_usuario,
    c.texto AS comentario,
    NULL AS likes,
    NULL AS dislikes
FROM 
    youtube.likescomentarios lc
JOIN 
    youtube.usuarios u ON lc.id_usuario = u.id_usuario
JOIN 
    youtube.comentarios c ON lc.id_comentario = c.id_comentario;
