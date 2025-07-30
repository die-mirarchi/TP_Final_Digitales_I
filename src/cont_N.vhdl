-- Módulo contador de N bits
-- Este módulo implementa un bit de un contador genérico de N bits
-- que puede ser concatenado para formar contadores de mayor tamaño
entity cont_nbit is
  port (
    en_d_i   : in bit; -- Señal de habilitación del contador
    reset_i  : in bit; -- Señal de reinicio sincrónico
    clock_i  : in bit; -- Señal de reloj del sistema
    enable_i : in bit; -- Habilitación para el flip-flop D
    q0_out   : out bit; -- Salida del estado actual del contador
    next_out : out bit -- Señal para habilitar el siguiente bit del contador
  );
end;

architecture cont_nbit_arq of cont_nbit is
  -- Declaración del componente flip-flop D sincrónico que se utiliza como elemento de memoria
  component ffd_sinc is
    port (
      clk_i  : in bit; -- Entrada de reloj
      d_in   : in bit; -- Entrada de datos
      srst_i : in bit; -- Reset sincrónico
      en_i   : in bit; -- Habilitación del flip-flop
      q_out  : out bit -- Salida del flip-flop
    );
  end component;
  signal q0_aux : bit; -- Señal auxiliar que almacena el estado actual del contador
  signal salXor : bit; -- Resultado de la operación XOR entre estado actual y habilitación
begin
  -- Instanciación del flip-flop D que funciona como elemento de memoria del contador
  ffd0 : ffd_sinc
  port map
  (
    clk_i  => clock_i, -- Conectamos el reloj del sistema
    d_in   => salXor, -- La entrada D es el resultado del XOR
    srst_i => reset_i, -- Reset sincrónico conectado a reset_i
    en_i   => enable_i, -- Habilitación conectada a en_d_i
    q_out  => q0_aux -- Salida conectada a nuestra señal auxiliar
  );
  salXor   <= q0_aux xor en_d_i; -- Cálculo del próximo estado mediante XOR
  q0_out   <= q0_aux; -- La salida refleja el estado actual del contador
  next_out <= en_d_i and q0_aux; -- Genera señal de habilitación para el siguiente bit
end;