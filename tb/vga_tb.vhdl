entity vga_ctrl_tb_wave is
end;

architecture vga_ctrl_tb_wave_arq of vga_ctrl_tb_wave is
  component vga_ctrl is
    port (
      clk     : in bit;
      red_i   : in bit;
      grn_i   : in bit;
      blu_i   : in bit;
      hs      : out bit;
      vs      : out bit;
      red_o   : out bit;
      grn_o   : out bit;
      blu_o   : out bit;
      pixel_x : out bit_vector(9 downto 0);
      pixel_y : out bit_vector(9 downto 0)
    );
  end component;

  signal clk_tb     : bit := '0';
  signal red_i_tb   : bit := '0';
  signal grn_i_tb   : bit := '0';
  signal blu_i_tb   : bit := '0';
  signal hs_tb      : bit;
  signal vs_tb      : bit;
  signal red_o_tb   : bit;
  signal grn_o_tb   : bit;
  signal blu_o_tb   : bit;
  signal pixel_x_tb : bit_vector(9 downto 0);
  signal pixel_y_tb : bit_vector(9 downto 0);

  constant Tclk : time := 40 ns;

begin
  reloj : process
  begin
    clk_tb <= '0';
    wait for Tclk/2;
    clk_tb <= '1';
    wait for Tclk/2;
  end process;

  DUT : vga_ctrl
  port map
  (
    clk     => clk_tb,
    red_i   => red_i_tb,
    grn_i   => grn_i_tb,
    blu_i   => blu_i_tb,
    hs      => hs_tb,
    vs      => vs_tb,
    red_o   => red_o_tb,
    grn_o   => grn_o_tb,
    blu_o   => blu_o_tb,
    pixel_x => pixel_x_tb,
    pixel_y => pixel_y_tb
  );

  stim : process
  begin
    loop
      red_i_tb <= '1';
      grn_i_tb <= '0';
      blu_i_tb <= '0';
      wait for 2 ms;
      red_i_tb <= '0';
      grn_i_tb <= '1';
      blu_i_tb <= '0';
      wait for 2 ms;
      red_i_tb <= '0';
      grn_i_tb <= '0';
      blu_i_tb <= '1';
      wait for 2 ms;
      red_i_tb <= '1';
      grn_i_tb <= '1';
      blu_i_tb <= '0';
      wait for 2 ms;
      red_i_tb <= '0';
      grn_i_tb <= '1';
      blu_i_tb <= '1';
      wait for 2 ms;
      red_i_tb <= '1';
      grn_i_tb <= '0';
      blu_i_tb <= '1';
      wait for 2 ms;
      red_i_tb <= '1';
      grn_i_tb <= '1';
      blu_i_tb <= '1';
      wait for 2 ms;
      red_i_tb <= '0';
      grn_i_tb <= '0';
      blu_i_tb <= '0';
      wait for 2 ms;
    end loop;
  end process;

end architecture;
