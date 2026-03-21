-- SEED DATA para el Sistema de Control Electoral
-- Ejecuta este script en el SQL Editor de Supabase A

-- 1. Partidos
INSERT INTO public.partidos (id, nombre, color, hex) VALUES
('P01', 'UNIDOS', 'rojo', '#df0900'),
('P02', 'NGP', 'naranja mostaza', '#f18c28'),
('P03', 'PPS', 'amarillo', '#ffff00'),
('P04', 'UNE', 'celeste', '#00b8ff'),
('P05', 'PATRIA', 'naranja', '#FD4F00'),
('P06', 'MTS', 'verde', '#00a135'),
('P07', 'SUMATE', 'purpura', '#7D21B1'),
('P08', 'ALIANZA', 'burdeos', '#6f000e'),
('P09', 'FRI', 'azul marino', '#0d143b'),
('P10', 'LIBRE', 'azul', '#0000ff'),
('P11', 'SOLUCIONES', 'rosado', '#f992b7')
ON CONFLICT (id) DO UPDATE SET nombre = EXCLUDED.nombre, color = EXCLUDED.color, hex = EXCLUDED.hex;

-- 2. Candidatos Alcalde
INSERT INTO public.candidatos_alcalde (id, nombre, partido_id) VALUES
('P01-A', 'Edwin Lopez', 'P01'),
('P02-A', 'Omar Ledezma', 'P02'),
('P03-A', 'Felix Quispe', 'P03'),
('P04-A', 'Victor Carvajal', 'P04'),
('P05-A', 'Jesus Hinojosa', 'P05'),
('P06-A', 'Milton Paichucama', 'P06'),
('P07-A', 'Roxama Moscoso', 'P07'),
('P08-A', 'Patricia Arce', 'P08'),
('P09-A', 'Omar Amaya', 'P09'),
('P10-A', 'Gualberto Mercado', 'P10'),
('P11-A', 'Alfredo Lucana', 'P11')
ON CONFLICT (id) DO UPDATE SET nombre = EXCLUDED.nombre, partido_id = EXCLUDED.partido_id;

-- 3. Candidatos Concejo
INSERT INTO public.candidatos_concejo (id, partido_id, nombre, jerarquia) VALUES
('P01-C01', 'P01', 'JHANET CAMPERO SEJAS', 'C01'),
('P01-C02', 'P01', 'ABRAHAM MAMANI BEDOYA', 'C02'),
('P01-C03', 'P01', 'ROXANA MAMANI INCA', 'C03'),
('P01-C04', 'P01', 'JUAN JOSE PINTO REYES', 'C04'),
('P02-C01', 'P02', 'JIMMY HERBAS LAGUNA', 'C01'),
('P02-C02', 'P02', 'INGRID VANESSA ORTUÑO RAMIREZ', 'C02'),
('P02-C03', 'P02', 'ONZALO ROJAS RODRIGUEZ', 'C03'),
('P02-C04', 'P02', 'ROSA VILLANUEVA MORALES', 'C04'),
('P03-C01', 'P03', 'MARLENE TAPIA VARGAS', 'C01'),
('P03-C02', 'P03', 'MILTON ROBERT TORRICO FERRUFINO', 'C02'),
('P03-C03', 'P03', 'SUGRA ELIZABETH MARTINEZ YAPURA', 'C03'),
('P03-C04', 'P03', 'KARY LEDEZMA OVANDO', 'C04'),
('P04-C01', 'P04', 'WENDY DANITZA CONDORI QUISPE', 'C01'),
('P04-C02', 'P04', 'TEOFILO SANCHEZ CRUZ', 'C02'),
('P04-C03', 'P04', 'MONICA JHASMIN CANEDO', 'C03'),
('P04-C04', 'P04', 'ARMANDO ALFREDO VEIZAGA ADRIAZOLA', 'C04'),
('P05-C01', 'P05', 'JHESSICA COLQUE FORONDA', 'C01'),
('P05-C02', 'P05', 'WILBER ROCHA RIOS', 'C02'),
('P05-C03', 'P05', 'COPERTINA GABRIEL CESPEDES', 'C03'),
('P05-C04', 'P05', 'ROBERTO FERNANDEZ MALDONADO', 'C04'),
('P06-C01', 'P06', 'MARIA TERESA BARRIONUEVO CORRALES', 'C01'),
('P06-C02', 'P06', 'RICHARD CONDORI BAUTISTA', 'C02'),
('P06-C03', 'P06', 'EUGENIA CONDORI MAMANI', 'C03'),
('P06-C04', 'P06', 'ADRIAN JAVIER GALARZA CHOQUE', 'C04'),
('P07-C01', 'P07', 'VILMA JIMENEZ VEGAMONTE', 'C01'),
('P07-C02', 'P07', 'DIEGO DURAN AGUILAR', 'C02'),
('P07-C03', 'P07', 'MARIAT LITZI VELASCO CACERES', 'C03'),
('P07-C04', 'P07', 'ALBERTO MALDONADO RIOS', 'C04'),
('P08-C01', 'P08', 'PATRICIO PORTILLO VELIZ', 'C01'),
('P08-C02', 'P08', 'ELIZABETH ANCALLE PANIAGUA', 'C02'),
('P08-C03', 'P08', 'TEODORO QUISPE OTALORA', 'C03'),
('P08-C04', 'P08', 'ROCIO AGUILAR ALAVE', 'C04'),
('P09-C01', 'P09', 'ESTHER ESPERANZA ROCHA CARTAGENA', 'C01'),
('P09-C02', 'P09', 'ARIEL DANNY JIMENEZ FUENTES', 'C02'),
('P09-C03', 'P09', 'PAMELA VILLEGAS MONTAÑO', 'C03'),
('P09-C04', 'P09', 'ENOC BRAYAN WAYAR FUENTES', 'C04'),
('P10-C01', 'P10', 'CINTHIA VARGAS MARTINEZ', 'C01'),
('P10-C02', 'P10', 'AURELIO VICENTE BAEZ PEREZ', 'C02'),
('P10-C03', 'P10', 'MARIA VERONICA ZENTENO SARAVIA', 'C03'),
('P10-C04', 'P10', 'BEIMAR VIDAURRE FLORES', 'C04'),
('P11-C01', 'P11', 'GIASMANI IVAN MIRANDA ARGOTE', 'C01'),
('P11-C02', 'P11', 'MARIA ELENA ESPINOZA CHARRO', 'C02'),
('P11-C03', 'P11', 'BASILIO RAMOS CHOQUE', 'C03'),
('P11-C04', 'P11', 'JHENNY CRUZ TARIFA', 'C04')
ON CONFLICT (id) DO UPDATE SET partido_id = EXCLUDED.partido_id, nombre = EXCLUDED.nombre, jerarquia = EXCLUDED.jerarquia;

-- 4. Recintos
INSERT INTO public.recintos (id, nombre, total_mesas, codigo_acceso) VALUES
('R01', 'Escuela Melchor Cuadros', 30, 'EMC01'),
('R02', 'U.E Vargas Linde', 26, 'UVL02'),
('R03', 'Escuela Martín Cárdenas', 21, 'EMC03'),
('R04', 'Unidad Educativa David Arzabe', 16, 'UDA04'),
('R05', 'Escuela Ismael Montes', 16, 'EIM05'),
('R06', 'Unidad Educativa Sagrada Familia', 15, 'USF06'),
('R07', 'Unidad Educativa Anocaraire', 14, 'UAN07'),
('R08', 'Núcleo Escolar Simón Bolívar (Thiomoko)', 9, 'NSB08'),
('R09', 'U.E. Avelino Mérida Zubieta', 8, 'AMZ09'),
('R10', 'U.E. María Ayma', 6, 'UMA10'),
('R11', 'U.E. 5 de Septiembre', 5, 'SEP11'),
('R12', 'U.E. Soledad Rivas', 5, 'USR12'),
('R13', 'U.E. Álvaro García Linera', 5, 'AGL13'),
('R14', 'U.E. Simón I. Patiño', 4, 'SIP14'),
('R15', 'U.E. Carmen Rosa Salguero', 3, 'CRS15'),
('R16', 'U.E. Nuestra Señora del Rosario', 3, 'NSR16'),
('R17', 'U.E. Combuyo', 3, 'COM17'),
('R18', 'U.E. Vilomilla', 3, 'VIL18'),
('R19', 'U.E. Bartolina Sisa', 3, 'BSI19'),
('R20', 'Unidad Educativa Keraya', 2, 'KER20'),
('R21', 'U.E. La Llave', 2, 'LLA21')
ON CONFLICT (id) DO UPDATE SET nombre = EXCLUDED.nombre, total_mesas = EXCLUDED.total_mesas, codigo_acceso = EXCLUDED.codigo_acceso;

-- 5. Mesas (199 mesas)
DO $$
DECLARE
    r RECORD;
    i INTEGER;
BEGIN
    FOR r IN SELECT id, total_mesas FROM public.recintos LOOP
        FOR i IN 1..r.total_mesas LOOP
            INSERT INTO public.mesas (id, recinto_id, numero, estado, verificada)
            VALUES (
                r.id || '-M' || LPAD(i::text, 2, '0'),
                r.id,
                i,
                'pendiente',
                false
            )
            ON CONFLICT (id) DO NOTHING;
        END LOOP;
    END LOOP;
END $$;
