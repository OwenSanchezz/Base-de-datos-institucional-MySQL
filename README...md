# Base de datos institucional (MySQL)

Modelo relacional para el área de TI de una organización: empleados por departamento, equipos asignados, usuarios del sistema con roles, bitácora de accesos y control de respaldos.

Proyecto de la materia de Administración de Bases de Datos, Universidad ICEL.

## Tecnologías

- MySQL 8.x

## Tablas

| Tabla | Contenido |
|---|---|
| `departamentos` | Áreas de la organización y su ubicación |
| `empleados` | Personal, con puesto, correo único y departamento |
| `equipos` | Laptops, desktops y monitores, con número de serie único, estado y empleado responsable |
| `usuariossistema` | Cuentas de la base de datos con rol: Administrador, Consulta, Captura o Auditor |
| `bitacoraaccesos` | Registro de acciones (SELECT, INSERT, GRANT, REVOKE...) por usuario y tabla |
| `respaldos` | Respaldos completos, incrementales y diferenciales, con su responsable |

Relaciones: `empleados.id_departamento → departamentos` y `equipos.id_empleado → empleados`.

## Cómo usarlo

```bash
mysql -u root -p < sgbd_institucional.sql
```

Crea la base `sgbd_institucional` con las tablas y datos de prueba.

## Autor

Owen Yamil Campuzano Sanchez ([@owensanchezz](https://github.com/owensanchezz))
