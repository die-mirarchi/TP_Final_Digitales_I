library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Testbench para el multiplexor 2:1
entity mux_tb is
end mux_tb;

architecture tb_arch of mux_tb is
  -- Declaración del componente a probar
  component mux
    port (
      entrs_i : in BIT_VECTOR(1 downto 0);
      selec   : in bit;
      s_o     : out bit
    );
  end component;

  -- Señales de prueba
  signal entrs_i_tb : BIT_VECTOR(1 downto 0);
  signal selec_tb   : bit;
  signal s_o_tb     : bit;

begin
  -- Instancia del componente bajo prueba
  uut : mux
  port map
  (
    entrs_i => entrs_i_tb,
    selec   => selec_tb,
    s_o     => s_o_tb
  );

  -- Generación de estímulos sin process (asignaciones concurrentes)
  -- Secuencia de pruebas usando transport delay
  entrs_i_tb <= "00" after 0 ns,
    "01" after 20 ns,
    "10" after 40 ns,
    "11" after 60 ns;
  selec_tb <= '0' after 0 ns,
    '1' after 10 ns,
    '0' after 20 ns,
    '1' after 30 ns,
    '0' after 40 ns,
    '1' after 50 ns,
    '0' after 60 ns;
end tb_arch;