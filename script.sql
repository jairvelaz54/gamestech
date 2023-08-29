create table categoria
(
    id_categoria int auto_increment
        primary key,
    categoria    varchar(100) null
)
    engine = InnoDB;

create table cliente
(
    id_cliente       int auto_increment
        primary key,
    nombre           varchar(100) null,
    primer_apellido  varchar(100) null,
    segundo_apellido varchar(100) null,
    telefono         varchar(10)  null
)
    engine = InnoDB;

create table cliente_telefono
(
    id_cliente int         not null,
    telefono   varchar(20) not null,
    primary key (id_cliente, telefono),
    constraint cliente_telefono_ibfk_1
        foreign key (id_cliente) references cliente (id_cliente)
)
    engine = InnoDB;

create table estado_reparacion
(
    id_estado_reparacion int auto_increment
        primary key,
    estado_reparacion    varchar(150) null
)
    engine = InnoDB;

create table falla
(
    id_falla int auto_increment
        primary key,
    falla    varchar(200) null
)
    engine = InnoDB;

create table marca
(
    id_marca int auto_increment
        primary key,
    marca    varchar(100) null
)
    engine = InnoDB;

create table marca_categoria
(
    id_marca     int not null,
    id_categoria int not null,
    primary key (id_marca, id_categoria),
    constraint marca_categoria_ibfk_1
        foreign key (id_marca) references marca (id_marca),
    constraint marca_categoria_ibfk_2
        foreign key (id_categoria) references categoria (id_categoria)
)
    engine = InnoDB;

create index id_categoria
    on marca_categoria (id_categoria);

create table producto
(
    id_producto int auto_increment
        primary key,
    producto    varchar(150)   null,
    precio      decimal(10, 2) null,
    stock       int            null,
    id_marca    int            null,
    constraint producto_ibfk_1
        foreign key (id_marca) references marca (id_marca),
    check (`stock` >= 0)
)
    engine = InnoDB;

create index id_marca
    on producto (id_marca);

create table refaccion
(
    id_refaccion int auto_increment
        primary key,
    refaccion    varchar(150)   null,
    precio       decimal(10, 2) null,
    stock        bigint         null
)
    engine = InnoDB;

create table reparacion_caracteristica
(
    id_reparacion_caracteristica int auto_increment
        primary key,
    reparacion_caracteristica    varchar(150) null
)
    engine = InnoDB;

create table rol
(
    id_rol int auto_increment
        primary key,
    rol    varchar(100) null
)
    engine = InnoDB;

create table sucursal
(
    id_sucursal int auto_increment
        primary key,
    sucursal    varchar(100) null,
    domicilio   varchar(300) null
)
    engine = InnoDB;

create table tipo_pago
(
    id_tipo_pago int auto_increment
        primary key,
    tipo_pago    varchar(150) null
)
    engine = InnoDB;

create table tipo_venta
(
    id_tipo_venta int auto_increment
        primary key,
    tipo_venta    varchar(100) null
)
    engine = InnoDB;

create table usuario
(
    id_usuario  int auto_increment
        primary key,
    usuario     varchar(30)  null,
    contrasenia varchar(100) null
)
    engine = InnoDB;

create table asistencia
(
    id_asistencia int auto_increment
        primary key,
    id_usuario    int                  null,
    fecha_entrada datetime             null,
    fecha_salida  datetime             null,
    estado        tinyint(1) default 0 null,
    constraint asistencia_ibfk_1
        foreign key (id_usuario) references usuario (id_usuario)
)
    engine = InnoDB;

create index id_usuario
    on asistencia (id_usuario);

create table empleado
(
    id_empleado      int auto_increment
        primary key,
    nombre           varchar(100) null,
    primer_apellido  varchar(100) null,
    segundo_apellido varchar(100) null,
    telefono         varchar(10)  null,
    domicilio        varchar(200) null,
    id_usuario       int          null,
    rfc              varchar(13)  null,
    curp             varchar(18)  null,
    constraint empleado_ibfk_1
        foreign key (id_usuario) references usuario (id_usuario)
)
    engine = InnoDB;

create table caja
(
    id_caja       int auto_increment
        primary key,
    id_empleado   int            null,
    saldo_inicial decimal(10, 2) null,
    saldo_final   decimal(10, 2) null,
    fecha         datetime       null,
    constraint caja_ibfk_1
        foreign key (id_empleado) references empleado (id_empleado)
)
    engine = InnoDB;

create index id_empleado
    on caja (id_empleado);

create table caja_sucursal
(
    id_caja     int      not null,
    id_sucursal int      not null,
    fecha       datetime null,
    primary key (id_caja, id_sucursal),
    constraint caja_sucursal_ibfk_1
        foreign key (id_caja) references caja (id_caja),
    constraint caja_sucursal_ibfk_2
        foreign key (id_sucursal) references sucursal (id_sucursal)
)
    engine = InnoDB;

create index id_sucursal
    on caja_sucursal (id_sucursal);

create index id_usuario
    on empleado (id_usuario);

create table recepcion
(
    id_recepcion   int auto_increment
        primary key,
    id_cliente     int            null,
    id_empleado    int            null,
    id_falla       int            null,
    id_marca       int            null,
    id_sucursal    int            null,
    observaciones  text           null,
    fecha_ingreso  datetime       null,
    presupuesto    decimal(10, 2) null,
    fecha_estimada datetime       null,
    modelo         varchar(150)   null,
    constraint recepcion_ibfk_1
        foreign key (id_cliente) references cliente (id_cliente),
    constraint recepcion_ibfk_2
        foreign key (id_empleado) references empleado (id_empleado),
    constraint recepcion_ibfk_3
        foreign key (id_falla) references falla (id_falla),
    constraint recepcion_ibfk_4
        foreign key (id_marca) references marca (id_marca),
    constraint recepcion_ibfk_5
        foreign key (id_sucursal) references sucursal (id_sucursal)
)
    engine = InnoDB;

create index id_cliente
    on recepcion (id_cliente);

create index id_empleado
    on recepcion (id_empleado);

create index id_falla
    on recepcion (id_falla);

create index id_marca
    on recepcion (id_marca);

create index id_sucursal
    on recepcion (id_sucursal);

create table recepcion_detalle
(
    id_recepcion                 int not null,
    id_reparacion_caracteristica int not null,
    primary key (id_recepcion, id_reparacion_caracteristica),
    constraint recepcion_detalle_ibfk_1
        foreign key (id_recepcion) references recepcion (id_recepcion),
    constraint recepcion_detalle_ibfk_2
        foreign key (id_reparacion_caracteristica) references reparacion_caracteristica (id_reparacion_caracteristica)
)
    engine = InnoDB;

create index id_reparacion_caracteristica
    on recepcion_detalle (id_reparacion_caracteristica);

create table reparacion_detalle
(
    id_recepcion         int      not null,
    id_empleado          int      not null,
    id_estado_reparacion int      null,
    fecha_reparacion     datetime null,
    fecha_entrega        datetime null,
    primary key (id_recepcion, id_empleado),
    constraint reparacion_detalle_ibfk_1
        foreign key (id_recepcion) references recepcion (id_recepcion),
    constraint reparacion_detalle_ibfk_2
        foreign key (id_empleado) references empleado (id_empleado),
    constraint reparacion_detalle_ibfk_3
        foreign key (id_estado_reparacion) references estado_reparacion (id_estado_reparacion)
)
    engine = InnoDB;

create table refaccion_reparacion
(
    id_recepcion int null,
    id_empleado  int null,
    id_refaccion int null,
    constraint refaccion_reparacion_ibfk_1
        foreign key (id_recepcion, id_empleado) references reparacion_detalle (id_recepcion, id_empleado),
    constraint refaccion_reparacion_ibfk_2
        foreign key (id_refaccion) references refaccion (id_refaccion)
)
    engine = InnoDB;

create index id_recepcion
    on refaccion_reparacion (id_recepcion, id_empleado);

create index id_refaccion
    on refaccion_reparacion (id_refaccion);

create index id_empleado
    on reparacion_detalle (id_empleado);

create index id_estado_reparacion
    on reparacion_detalle (id_estado_reparacion);

create table usuario_rol
(
    id_usuario int null,
    id_rol     int null,
    constraint usuario_rol_ibfk_1
        foreign key (id_usuario) references usuario (id_usuario),
    constraint usuario_rol_ibfk_2
        foreign key (id_rol) references rol (id_rol)
)
    engine = InnoDB;

create index id_rol
    on usuario_rol (id_rol);

create index id_usuario
    on usuario_rol (id_usuario);

create table venta
(
    id_venta    int auto_increment
        primary key,
    id_cliente  int      null,
    fecha       datetime null,
    id_empleado int      null,
    id_sucursal int      null,
    constraint venta_ibfk_1
        foreign key (id_cliente) references cliente (id_cliente),
    constraint venta_ibfk_2
        foreign key (id_sucursal) references sucursal (id_sucursal),
    constraint venta_ibfk_4
        foreign key (id_empleado) references empleado (id_empleado)
)
    engine = InnoDB;

create table movimiento_caja
(
    id_movimiento_caja int auto_increment
        primary key,
    id_caja            int            null,
    monto              decimal(10, 2) null,
    id_venta           int            null,
    fecha              datetime       null,
    constraint movimiento_caja_ibfk_1
        foreign key (id_caja) references caja (id_caja),
    constraint movimiento_caja_ibfk_2
        foreign key (id_venta) references venta (id_venta)
)
    engine = InnoDB;

create index id_caja
    on movimiento_caja (id_caja);

create index id_venta
    on movimiento_caja (id_venta);

create table transaccion
(
    id_transaccion int auto_increment
        primary key,
    id_venta       int null,
    constraint transaccion_ibfk_1
        foreign key (id_venta) references venta (id_venta)
)
    engine = InnoDB;

create index id_venta
    on transaccion (id_venta);

create table transaccion_detalle
(
    id_transaccion int            not null,
    id_tipo_pago   int            not null,
    consecutivo    int            not null,
    monto          decimal(10, 2) null,
    folio          varchar(20)    null,
    primary key (id_transaccion, id_tipo_pago, consecutivo),
    constraint transaccion_detalle_ibfk_1
        foreign key (id_transaccion) references transaccion (id_transaccion),
    constraint transaccion_detalle_ibfk_2
        foreign key (id_tipo_pago) references tipo_pago (id_tipo_pago)
)
    engine = InnoDB;

create index id_tipo_pago
    on transaccion_detalle (id_tipo_pago);

create index id_cliente
    on venta (id_cliente);

create index id_empleado
    on venta (id_empleado);

create index id_sucursal
    on venta (id_sucursal);

create table venta_detalle
(
    id_venta      int                  not null,
    id_producto   int                  null,
    id_cliente    int                  null,
    id_tipo_venta int                  not null,
    cantidad      int                  null,
    id_recepcion  int                  null,
    estatus       tinyint(1) default 0 null,
    primary key (id_venta, id_tipo_venta),
    constraint venta_detalle_ibfk_1
        foreign key (id_recepcion) references recepcion (id_recepcion),
    constraint venta_detalle_ibfk_2
        foreign key (id_cliente) references cliente (id_cliente),
    constraint venta_detalle_ibfk_3
        foreign key (id_tipo_venta) references tipo_venta (id_tipo_venta),
    constraint venta_detalle_ibfk_4
        foreign key (id_venta) references venta (id_venta),
    constraint venta_detalle_ibfk_5
        foreign key (id_producto) references producto (id_producto)
)
    engine = InnoDB;

create index id_cliente
    on venta_detalle (id_cliente);

create index id_producto
    on venta_detalle (id_producto);

create index id_recepcion
    on venta_detalle (id_recepcion);

create index id_tipo_venta
    on venta_detalle (id_tipo_venta);


