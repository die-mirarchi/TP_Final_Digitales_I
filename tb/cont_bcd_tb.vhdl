entity cont_bcd_tb is
end;

architecture cont_bcd_tb_arq of cont_bcd_tb is
  component cont_bcd is
    port (
      enab_i : in bit;
      rest_i : in bit;
      clck_i : in bit;
      q_o    : out bit_vector(3 downto 0);
      next_o : out bit
    );
  end component;

  signal clk_tb    : bit := '0';
  signal rst_tb    : bit := '0';
  signal enable_tb : bit := '1';
  signal q_tb      : bit_vector(3 downto 0);
  signal next_tb   : bit;

begin
  clk_tb    <= not clk_tb after 20 ns;
  rst_tb    <= '1' after 10 ns, '0' after 60 ns;
  enable_tb <= not enable_tb after 78 ns;

  DUT : cont_bcd
  port map
  (
    enab_i => enable_tb,
    rest_i => rst_tb,
    clck_i => clk_tb,
    q_o    => q_tb,
    next_o => next_tb
  );
end;