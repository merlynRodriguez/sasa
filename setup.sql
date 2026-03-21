-- Ejecuta este script en el SQL Editor de tu nuevo proyecto de Supabase (Supabase A)

-- 1. Partidos
CREATE TABLE IF NOT EXISTS public.partidos (
    id text PRIMARY KEY,
    nombre text,
    color text,
    hex text
);

-- 2. Candidatos Alcalde
CREATE TABLE IF NOT EXISTS public.candidatos_alcalde (
    id text PRIMARY KEY,
    nombre text,
    partido_id text REFERENCES public.partidos(id)
);

-- 3. Candidatos Concejo
CREATE TABLE IF NOT EXISTS public.candidatos_concejo (
    id text PRIMARY KEY,
    partido_id text REFERENCES public.partidos(id),
    nombre text,
    jerarquia text CHECK (jerarquia IN ('C01', 'C02', 'C03', 'C04'))
);

-- 4. Recintos
CREATE TABLE IF NOT EXISTS public.recintos (
    id text PRIMARY KEY,
    nombre text,
    total_mesas integer,
    codigo_acceso text UNIQUE
);

-- 5. Mesas
CREATE TABLE IF NOT EXISTS public.mesas (
    id text PRIMARY KEY,
    recinto_id text REFERENCES public.recintos(id),
    numero integer,
    estado text DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'escrutada', 'verificada')),
    verificada boolean DEFAULT false,
    timestamp_operador timestamp with time zone,
    timestamp_verificador timestamp with time zone
);

-- 6. Votos Alcalde
CREATE TABLE IF NOT EXISTS public.votos_alcalde (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    mesa_id text UNIQUE REFERENCES public.mesas(id),
    p01 integer DEFAULT 0,
    p02 integer DEFAULT 0,
    p03 integer DEFAULT 0,
    p04 integer DEFAULT 0,
    p05 integer DEFAULT 0,
    p06 integer DEFAULT 0,
    p07 integer DEFAULT 0,
    p08 integer DEFAULT 0,
    p09 integer DEFAULT 0,
    p10 integer DEFAULT 0,
    p11 integer DEFAULT 0,
    blancos integer DEFAULT 0,
    nulos integer DEFAULT 0,
    foto_url text,
    created_at timestamp with time zone DEFAULT now()
);

-- 7. Votos Concejo
CREATE TABLE IF NOT EXISTS public.votos_concejo (
    id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    mesa_id text UNIQUE REFERENCES public.mesas(id),
    p01 integer DEFAULT 0,
    p02 integer DEFAULT 0,
    p03 integer DEFAULT 0,
    p04 integer DEFAULT 0,
    p05 integer DEFAULT 0,
    p06 integer DEFAULT 0,
    p07 integer DEFAULT 0,
    p08 integer DEFAULT 0,
    p09 integer DEFAULT 0,
    p10 integer DEFAULT 0,
    p11 integer DEFAULT 0,
    blancos integer DEFAULT 0,
    nulos integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);

-- 8. Totales Alcalde
CREATE TABLE IF NOT EXISTS public.totales_alcalde (
    id integer PRIMARY KEY DEFAULT 1 CHECK (id = 1),
    p01 integer DEFAULT 0,
    p02 integer DEFAULT 0,
    p03 integer DEFAULT 0,
    p04 integer DEFAULT 0,
    p05 integer DEFAULT 0,
    p06 integer DEFAULT 0,
    p07 integer DEFAULT 0,
    p08 integer DEFAULT 0,
    p09 integer DEFAULT 0,
    p10 integer DEFAULT 0,
    p11 integer DEFAULT 0,
    blancos integer DEFAULT 0,
    nulos integer DEFAULT 0,
    mesas_escrutadas integer DEFAULT 0,
    updated_at timestamp with time zone DEFAULT now()
);

-- 9. Totales Concejo
CREATE TABLE IF NOT EXISTS public.totales_concejo (
    id integer PRIMARY KEY DEFAULT 1 CHECK (id = 1),
    p01 integer DEFAULT 0,
    p02 integer DEFAULT 0,
    p03 integer DEFAULT 0,
    p04 integer DEFAULT 0,
    p05 integer DEFAULT 0,
    p06 integer DEFAULT 0,
    p07 integer DEFAULT 0,
    p08 integer DEFAULT 0,
    p09 integer DEFAULT 0,
    p10 integer DEFAULT 0,
    p11 integer DEFAULT 0,
    blancos integer DEFAULT 0,
    nulos integer DEFAULT 0,
    updated_at timestamp with time zone DEFAULT now()
);

-- Insertar las filas unicas para los totales
INSERT INTO public.totales_alcalde (id) VALUES (1) ON CONFLICT DO NOTHING;
INSERT INTO public.totales_concejo (id) VALUES (1) ON CONFLICT DO NOTHING;

-- Configuracion de seguridad (Permitir acceso anonimo para que la app funcione)
ALTER TABLE public.partidos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.candidatos_alcalde ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.candidatos_concejo ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.recintos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.mesas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.votos_alcalde ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.votos_concejo ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.totales_alcalde ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.totales_concejo ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow anon all on partidos" ON public.partidos FOR ALL USING (true);
CREATE POLICY "Allow anon all on candidatos_alcalde" ON public.candidatos_alcalde FOR ALL USING (true);
CREATE POLICY "Allow anon all on candidatos_concejo" ON public.candidatos_concejo FOR ALL USING (true);
CREATE POLICY "Allow anon all on recintos" ON public.recintos FOR ALL USING (true);
CREATE POLICY "Allow anon all on mesas" ON public.mesas FOR ALL USING (true);
CREATE POLICY "Allow anon all on votos_alcalde" ON public.votos_alcalde FOR ALL USING (true);
CREATE POLICY "Allow anon all on votos_concejo" ON public.votos_concejo FOR ALL USING (true);
CREATE POLICY "Allow anon all on totales_alcalde" ON public.totales_alcalde FOR ALL USING (true);
CREATE POLICY "Allow anon all on totales_concejo" ON public.totales_concejo FOR ALL USING (true);

-- IMPORTANTE: Debes crear un Storage Bucket llamado "actas" y marcarlo como "Public"
-- para que la subida de fotos por los operadores funcione.
