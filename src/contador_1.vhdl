library IEEE;
use ieee.std_logic_1164.all;

-- Tipo matriz para 6 dígitos BCD
package types_pkg is
  type matriz is array (0 to 5) of bit_vector(3 downto 0);
end package;

use work.types_pkg.all;

-- Contador de unos (6 dígitos BCD) con registros para los 3 MSB
entity cont_1 is
  port (
    clk_i    : in bit; -- Reloj
    rst_i    : in bit; -- Reset
    reg_en_i : in bit; -- Enable de registros de salida
    adc      : in bit; -- Entrada de pulsos (ADC)
    num_out  : out matriz; -- Salida completa (6 dígitos)
    q0_out   : out bit_vector(3 downto 0); -- Registro MSB
    q1_out   : out bit_vector(3 downto 0); -- Registro MSB-1
    q2_out   : out bit_vector(3 downto 0) -- Registro MSB-2
  );
end;

architecture cont_1_arq of cont_1 is
  component cont_bcd is
    port (
      enab_i : in bit;
      rest_i : in bit;
      clck_i : in bit;
      q_o    : out bit_vector(3 downto 0);
      next_o : out bit
    );
  end component;
  component ffd_sinc is
    port (
      clk_i  : in bit;
      d_in   : in bit;
      srst_i : in bit;
      en_i   : in bit;
      q_out  : out bit
    );
  end component;

  signal ena_i, next_vec : bit_vector(5 downto 0);
  signal matriz_aux      : matriz;
begin
  -- Cadena de 6 contadores BCD (0=LSB, 5=MSB)
  cont_bcd_gen : for i in 0 to 5 generate
    cont_bcd_gen_i : cont_bcd
    port map
    (
      enab_i => ena_i(i),
      rest_i => rst_i,
      clck_i => clk_i,
      q_o    => matriz_aux(i),
      next_o => next_vec(i)
    );
    num_out(i) <= matriz_aux(i);
  end generate cont_bcd_gen;

  -- Conexión de carries (ripple)
  cont_out_gen : for i in 1 to 5 generate
    ena_i(i) <= next_vec(i - 1);
  end generate cont_out_gen;
  ena_i(0) <= adc;

  -- Registros para los 3 dígitos más significativos
  registro_q0 : for i in 0 to 3 generate
    reg_4 : ffd_sinc
    port map
    (
      clk_i  => clk_i,
      d_in   => matriz_aux(5)(i), -- MSB (digito 5)
      srst_i => '0',
      en_i   => reg_en_i,
      q_out  => q0_out(i)
    );
  end generate registro_q0;

  registro_q1 : for i in 0 to 3 generate
    reg_4 : ffd_sinc
    port map
    (
      clk_i  => clk_i,
      d_in   => matriz_aux(4)(i), -- MSB-1 (digito 4)
      srst_i => '0',
      en_i   => reg_en_i,
      q_out  => q1_out(i)
    );
  end generate registro_q1;

  registro_q2 : for i in 0 to 3 generate
    reg_4 : ffd_sinc
    port map
    (
      clk_i  => clk_i,
      d_in   => matriz_aux(3)(i), -- MSB-2 (digito 3)
      srst_i => '0',
      en_i   => reg_en_i,
      q_out  => q2_out(i)
    );
  end generate registro_q2;
end;