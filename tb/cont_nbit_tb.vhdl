entity cont_nbit_tb is
end;

architecture cont_nbit_tb_arq of cont_nbit_tb is
  component cont_nbit is
    port (
      enable_i : in bit;
      reset_i  : in bit;
      clock_i  : in bit;
      en_d_i   : in bit;
      q0_out   : out bit;
      next_out : out bit
    );
  end component;

  signal clk_tb    : bit := '0';
  signal rst_tb    : bit := '0';
  signal enable_tb : bit := '1';
  signal en_d_tb   : bit := '1';
  signal q0_tb     : bit;
  signal next_tb   : bit;

begin
  clk_tb <= not clk_tb after 25 ns;
  rst_tb <= '1' after 10 ns, '0' after 60 ns;

  DUT : cont_nbit
  port map
  (
    enable_i => enable_tb,
    reset_i  => rst_tb,
    clock_i  => clk_tb,
    en_d_i   => en_d_tb,
    q0_out   => q0_tb,
    next_out => next_tb
  );
end;