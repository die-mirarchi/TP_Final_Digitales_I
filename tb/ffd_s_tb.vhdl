library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ffd_s_tb is
  -- Testbench no tiene puertos
end ffd_s_tb;

architecture ffd_s_tb_arq of ffd_s_tb is
  -- Declaración del componente a probar
  component ffd_sinc is
    port (
      clk_i  : in bit;
      d_in   : in bit;
      srst_i : in bit;
      en_i   : in bit;
      q_out  : out bit
    );
  end component;

  -- Señales de prueba
  signal clk_tb  : bit := '0';
  signal d_tb    : bit := '0';
  signal srst_tb : bit := '0';
  signal en_tb   : bit := '1';
  signal q_tb    : bit;

  -- Constantes para el período del reloj
  constant CLK_PERIOD : time := 10 ns;

begin
  clk_tb  <= not clk_tb after 10 ns;
  d_tb    <= '1' after 44 ns;
  srst_tb <= '1' after 57 ns;

  -- Instancia del componente bajo prueba (UUT - Unit Under Test)
  UUT : ffd_sinc
  port map
  (
    clk_i  => clk_tb,
    d_in   => d_tb,
    srst_i => srst_tb,
    en_i   => en_tb,
    q_out  => q_tb
  );

end ffd_s_tb_arq;
