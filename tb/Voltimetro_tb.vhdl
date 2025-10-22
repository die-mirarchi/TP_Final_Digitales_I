library IEEE;
use ieee.std_logic_1164.all;

entity voltimetro_tb is
end entity;

architecture voltimetro_tb_arq of voltimetro_tb is
  signal clk_i           : bit := '0';
  signal rst_i           : bit := '1';
  signal data_volt_in_i  : bit := '0';
  signal data_volt_out_o : bit;
  signal hs_o            : bit;
  signal vs_o            : bit;
  signal red_o           : bit;
  signal grn_o           : bit;
  signal blu_o           : bit;
begin
  u_dut : entity work.Voltimetro
    port map
    (
      clk_i           => clk_i,
      rst_i           => rst_i,
      data_volt_in_i  => data_volt_in_i,
      data_volt_out_o => data_volt_out_o,
      hs_o            => hs_o,
      vs_o            => vs_o,
      red_o           => red_o,
      grn_o           => grn_o,
      blu_o           => blu_o
    );

  clk_gen : process
  begin
    wait for 40 ns;
    clk_i <= not clk_i;
  end process;

  stim_proc : process
  begin
    rst_i <= '1';
    wait for 100 ns;
    rst_i <= '0';

    while now < 70 ms loop
      data_volt_in_i <= '1';
      wait for 200 us;
      data_volt_in_i <= '0';
      wait for 200 us;
    end loop;

    wait;
  end process;
end architecture voltimetro_tb_arq;
