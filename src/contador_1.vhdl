library IEEE;
use ieee.std_logic_1164.all;
package types_pkg is
  type matriz is array (0 to 5) of bit_vector(3 downto 0);
end package;
use work.types_pkg.all;
entity cont_1 is
  port (
    clk_i    : in bit;
    rst_i    : in bit;
    reg_en_i : in bit;
    adc      : in bit;
    num_out  : out matriz;
    q0_out   : out bit_vector(3 downto 0);
    q1_out   : out bit_vector(3 downto 0);
    q2_out   : out bit_vector(3 downto 0)
  );
end;

architecture cont_1_arq of cont_1 is
  component cont_bcd is
    port (
      enab_i : in bit; -- Entrada de habilitación para el contador
      rest_i : in bit; -- Entrada de reset externo
      clck_i : in bit; -- Entrada de reloj
      q_o    : out bit_vector(3 downto 0); -- Salida de 4 bits con el valor BCD
      next_o : out bit -- Salida de carry para poder conectar en cascada
    );
  end component;
  component ffd_sinc is
    port (
      clk_i  : in bit; -- Entrada de reloj
      d_in   : in bit; -- Entrada de datos
      srst_i : in bit; -- Reset sincrónico
      en_i   : in bit; -- Habilitación del flip-flop
      q_out  : out bit -- Salida del flip-flop
    );
  end component;
  signal ena_i, next_vec : bit_vector(5 downto 0);
  signal matriz_aux      : matriz;
begin
  cont_bcd_gen : for i in 0 to 5 generate
    cont_bcd_gen_i : cont_bcd
    port map
    (
      enab_i => ena_i(i),
      rest_i => rst_i,
      clck_i => clk_i,
      q_o    => matriz_aux(i), -- Salida de 4 bits con el valor BCD
      next_o => next_vec(i)
    );
    num_out(i) <= matriz_aux(i);
  end generate cont_bcd_gen;
  cont_out_gen : for i in 1 to 5 generate -- Changed from 11 to 18
    ena_i(i) <= next_vec(i - 1);
  end generate cont_out_gen;
  ena_i(0) <= adc;

  registro_q0 : for i in 0 to 3 generate
    reg_4 : ffd_sinc
    port map
    (
      clk_i  => clk_i, -- Conectamos el reloj del sistema
      d_in   => matriz_aux(3)(i), -- La entrada D es el resultado del XOR
      srst_i => '0', -- Reset sincrónico conectado a reset_i
      en_i   => reg_en_i, -- Habilitación conectada a en_d_i
      q_out  => q0_out(i) -- Salida conectada a nuestra señal auxiliar
    );
  end generate registro_q0;
  registro_q1 : for i in 0 to 3 generate
    reg_4 : ffd_sinc
    port map
    (
      clk_i  => clk_i, -- Conectamos el reloj del sistema
      d_in   => matriz_aux(4)(i), -- La entrada D es el resultado del XOR
      srst_i => '0', -- Reset sincrónico conectado a reset_i
      en_i   => reg_en_i, -- Habilitación conectada a en_d_i
      q_out  => q1_out(i) -- Salida conectada a nuestra señal auxiliar
    );
  end generate registro_q1;
  registro_q2 : for i in 0 to 3 generate
    reg_4 : ffd_sinc
    port map
    (
      clk_i  => clk_i, -- Conectamos el reloj del sistema
      d_in   => matriz_aux(5)(i), -- La entrada D es el resultado del XOR
      srst_i => '0', -- Reset sincrónico conectado a reset_i
      en_i   => reg_en_i, -- Habilitación conectada a en_d_i
      q_out  => q2_out(i) -- Salida conectada a nuestra señal auxiliar
    );
  end generate registro_q2;
end;