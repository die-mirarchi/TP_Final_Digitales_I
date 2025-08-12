-- Entidad para un contador BCD (Decimal Codificado en Binario) de 0 a 9
entity cont_bcd is
  port (
    enab_i : in bit; -- Entrada de habilitación para el contador
    rest_i : in bit; -- Entrada de reset externo
    clck_i : in bit; -- Entrada de reloj
    q_o    : out bit_vector(3 downto 0); -- Salida de 4 bits con el valor BCD
    next_o : out bit -- Salida de carry para poder conectar en cascada
  );
end;

architecture cont_bcd_arq of cont_bcd is
  -- Componente de contador de 1 bit que se usa como bloque básico
  component cont_nbit is
    port (
      enable_i : in bit; -- Habilitación del contador
      reset_i  : in bit; -- Reset del contador
      clock_i  : in bit; -- Reloj
      en_d_i   : in bit; -- Habilitación de datos
      q0_out   : out bit; -- Salida del bit
      next_out : out bit -- Señal de carry
    );
  end component;
  -- Señales internas para conectar los contadores
  signal q0_aux   : bit; -- Bit menos significativo (LSB)
  signal q1_aux   : bit; -- Segundo bit
  signal q2_aux   : bit; -- Tercer bit
  signal q3_aux   : bit; -- Bit más significativo (MSB)
  signal en0_aux  : bit; -- Señal de carry del primer flip-flop
  signal en1_aux  : bit; -- Señal de carry del segundo flip-flop
  signal en2_aux  : bit; -- Señal de carry del tercer flip-flop
  signal reset    : bit; -- Reset interno combinado (externo + detección del valor 10)
  signal next_aux : bit; -- Señal auxiliar para el carry de salida
begin
  -- Primer contador para el bit 0 (LSB)
  cont0 : cont_nbit
  port map
  (
    enable_i => enab_i,
    reset_i  => reset,
    clock_i  => clck_i,
    en_d_i   => '1',
    q0_out   => q0_aux,
    next_out => en0_aux
  );
  -- Segundo contador para el bit 1
  cont1 : cont_nbit
  port map
  (
    enable_i => enab_i, -- Se habilita solo cuando el bit anterior genera carry
    reset_i  => reset,
    clock_i  => clck_i,
    en_d_i   => en0_aux,
    q0_out   => q1_aux,
    next_out => en1_aux
  );
  -- Tercer contador para el bit 2
  cont2 : cont_nbit
  port map
  (
    enable_i => enab_i, -- Se habilita solo cuando el bit anterior genera carry
    reset_i  => reset,
    clock_i  => clck_i,
    en_d_i   => en1_aux,
    q0_out   => q2_aux,
    next_out => en2_aux
  );
  -- Cuarto contador para el bit 3 (MSB)
  cont3 : cont_nbit
  port map
  (
    enable_i => enab_i, -- Se habilita solo cuando el bit anterior genera carry
    reset_i  => reset,
    clock_i  => clck_i,
    en_d_i   => en2_aux,
    q0_out   => q3_aux,
    next_out => next_aux
  );
  -- Lógica de reset: se activa con reset externo O cuando el contador llega a 9 (1001 en binario)
  reset  <= (rest_i) or ((q0_aux and not q1_aux and not q2_aux and q3_aux) and enab_i);
  next_o <= (q0_aux and not q1_aux and not q2_aux and q3_aux) and enab_i; -- Conecta la señal de carry del último bit a la salida
  -- Conexiones de las salidas del contador BCD
  q_o(0) <= q0_aux;
  q_o(1) <= q1_aux;
  q_o(2) <= q2_aux;
  q_o(3) <= q3_aux;
end;