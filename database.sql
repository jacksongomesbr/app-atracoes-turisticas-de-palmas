create table
  public.categorias (
    id bigint generated by default as identity not null,
    criado_em timestamp with time zone not null default timezone ('utc'::text, now()),
    atualizado_em timestamp with time zone not null default timezone ('utc'::text, now()),
    nome text not null,
    constraint categorias_pkey primary key (id)
  ) tablespace pg_default;

create table
  public.tipos_de_custos (
    id bigint generated by default as identity not null,
    criado_em timestamp with time zone not null default timezone ('utc'::text, now()),
    atualizado_em timestamp with time zone not null default timezone ('utc'::text, now()),
    nome text not null,
    constraint tipos_de_custos_pkey primary key (id)
  ) tablespace pg_default;

create table
  public.atracoes_turisticas (
    id bigint generated by default as identity not null,
    criado_em timestamp with time zone not null default timezone ('utc'::text, now()),
    atualizado_em timestamp with time zone not null default timezone ('utc'::text, now()),
    nome text not null,
    ranking smallint null,
    categoria_id bigint not null,
    media_de_avaliacoes double precision null default 0.0,
    quantidade_de_avaliacoes integer null default 0,
    tipo_de_custo_id bigint not null,
    valor_do_custo double precision not null,
    localizacao text not null,
    descricao text not null,
    foto_thumbnail_url text null,
    foto_big_url text null,
    constraint atracoes_turisticas_pkey primary key (id),
    constraint atracoes_turisticas_categoria_id_fkey foreign key (categoria_id) references categorias (id),
    constraint atracoes_turisticas_tipo_de_custo_id_fkey foreign key (tipo_de_custo_id) references tipos_de_custos (id)
  ) tablespace pg_default;

create table
  public.destaques_de_atracoes_turisticas (
    id bigint generated by default as identity not null,
    criado_em timestamp with time zone not null default timezone ('utc'::text, now()),
    atualizado_em timestamp with time zone not null default timezone ('utc'::text, now()),
    atracao_turistica_id bigint not null,
    valor text not null,
    titulo text not null,
    constraint destaques_de_atracoes_turisticas_pkey primary key (id),
    constraint destaques_de_atracoes_turisticas_atracao_turistica_id_fkey foreign key (atracao_turistica_id) references atracoes_turisticas (id)
  ) tablespace pg_default;

create table
  public.horarios_de_atracoes_turisticas (
    id bigint generated by default as identity not null,
    criado_em timestamp with time zone not null default timezone ('utc'::text, now()),
    atualizado_em timestamp with time zone not null default timezone ('utc'::text, now()),
    atracao_turistica_id bigint not null,
    dia public.dia_da_semana not null,
    inicio time without time zone null default '00:00:00'::time without time zone,
    fim time without time zone null default '23:59:59'::time without time zone,
    constraint horarios_de_atracoes_turisticas_pkey primary key (id),
    constraint horarios_de_atracoes_turisticas_atracao_turistica_id_fkey foreign key (atracao_turistica_id) references atracoes_turisticas (id)
  ) tablespace pg_default;