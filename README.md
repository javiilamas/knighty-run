# Knighty Run

Videojuego de plataformas 2D hecho con **Godot 4.5** y **GDScript**. Un caballero recorre tres niveles recogiendo monedas, esquivando trampas y enfrentándose a slimes.

*2D platformer made with Godot 4.5 and GDScript. Team project, three levels.*

## Qué incluye

- Menú principal con música y efectos de sonido
- Tres niveles con plataformas, pinchos, zonas de caída y un final de nivel
- Enemigos (slimes) con distintos comportamientos
- Monedas y marcador de puntuación
- Power-ups: espada para atacar y una tienda donde comprar un bastón con monedas

## Equipo

Proyecto desarrollado en equipo de tres personas; cada una diseñó y programó un nivel.

- **Javier Lamas Tabuenca**: nivel 3 (`level3/`). Diseño del nivel, personaje jugable con salto y ataque con bastón, power-up del bastón, monedas animadas, un slime rojo que patrulla y persigue al jugador detectando paredes y bordes con raycasts, y zonas de caída con reaparición.

## Controles

| Acción | Tecla |
| --- | --- |
| Moverse | Flechas izquierda y derecha |
| Saltar | Espacio |
| Atacar (con la espada o el bastón) | X |

## Cómo ejecutarlo

1. Instala [Godot 4.5](https://godotengine.org/download).
2. Clona el repositorio y abre `project.godot` desde Godot.
3. Pulsa **Play** (F5).

## Estructura

```
level1/   nivel 1: escenas, scripts y sprites
level2/   nivel 2: escenas, scripts y sprites
level3/   nivel 3: escenas, scripts y sprites
scenes/   escenas compartidas (mundos, audio)
```

## Créditos de los recursos

Los gráficos, sonidos, música y fuentes proceden de recursos gratuitos con licencia **CC0**:

- [Brackeys Platformer Assets](https://brackeysgames.itch.io/brackeys-platformer-bundle) (sonidos de Asbjørn Thirslund, música de Sofia Thirslund)
- Sprites de [analogStudios_](https://analogstudios.itch.io/): [Camelot](https://analogstudios.itch.io/camelot), [Dungeon Sprites](https://analogstudios.itch.io/dungeonsprites) y [Four Seasons Platformer Sprites](https://analogstudios.itch.io/four-seasons-platformer-sprites)
- Tileset de [RottingPixels](https://rottingpixels.itch.io/four-seasons-platformer-tileset-16x16free)
- Fuente [Pixel Operator](https://www.dafont.com/pixel-operator.font) de Jayvee Enaguas
