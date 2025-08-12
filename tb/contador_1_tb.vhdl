-- Testbench para contador_1
-- Clock de 20ns (50 MHz)

library ieee;
use ieee.std_logic_1164.all;
use work.types_pkg.all;

entity contador_1_tb is
end entity;

architecture testbench of contador_1_tb is
  -- Declaración del tipo matriz (debe coincidir con el del DUT)
  -- Componente bajo prueba (DUT - Device Under Test)
  component cont_1 is
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
  end component;

  -- Señales del testbench
  signal clk_tb     : bit := '1';
  signal rst_tb     : bit := '0';
  signal reg_en_tb  : bit := '0';
  signal adc_tb     : bit := '1';
  signal num_out_tb : matriz;
  signal q0_out_tb  : bit_vector(3 downto 0);
  signal q1_out_tb  : bit_vector(3 downto 0);
  signal q2_out_tb  : bit_vector(3 downto 0);

begin

  -- Instancia del componente bajo prueba
  DUT : cont_1
  port map
  (
    clk_i    => clk_tb,
    rst_i    => rst_tb,
    reg_en_i => reg_en_tb,
    adc      => adc_tb,
    num_out  => num_out_tb,
    q0_out   => q0_out_tb,
    q1_out   => q1_out_tb,
    q2_out   => q2_out_tb
  );
  clk_tb <= not clk_tb after 20 ns;
  rst_tb <= '0'; -- Reset siempre desactivado

  -- Generate repeating adc_tb waveform
  --process
  --begin
  --  while true loop
  --    adc_tb <= '0';
  --    wait for 0.98 us;
  --    adc_tb <= '1';
  --    wait for 20 ns;
  --  end loop;
  --end process;
  -- Generate repeating adc_tb waveform
  process
  begin
    while true loop
      reg_en_tb <= '0';
      wait for 13.2001 ms;
      reg_en_tb <= '1';
      wait for 40 ns;
    end loop;
  end process;
  adc_tb <= '1';
end architecture;
