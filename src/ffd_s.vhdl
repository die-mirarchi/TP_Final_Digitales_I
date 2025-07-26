entity ffd_sinc is
  port (
    clk_i  : in bit;
    d_in   : in bit;
    srst_i : in bit;
    en_i   : in bit;
    q_out  : out bit
  );
end;

architecture ffd_sinc_arq of ffd_sinc is
  component mult is
    port (
      entrs_i : in BIT_VECTOR(1 downto 0);
      selec   : in bit;
      s_o     : out bit
    );
  end component;
  component ffd is
    port (
      clk_i  : in bit;
      d_i    : in bit;
      arst_i : in bit;
      q_o    : out bit
    );
  end component;
  signal q0_aux    : bit;
  signal mult1_aux : bit;
  signal mult2_aux : bit;
  signal entrs_0   : BIT_VECTOR(1 downto 0);
  signal entrs_1   : BIT_VECTOR(1 downto 0);

begin
  entrs_0 <= q0_aux & d_in;
  entrs_1 <= mult1_aux & '0';

  ffd_0 : ffd
  port map
  (
    clk_i  => clk_i,
    d_i    => mult2_aux,
    arst_i => '0',
    q_o    => q0_aux
  );
  mult_0 : mult
  port map
  (
    entrs_i => entrs_0,
    selec   => en_i,
    s_o     => mult1_aux
  );
  mult_1 : mult
  port map
  (
    entrs_i => entrs_1,
    selec   => srst_i,
    s_o     => mult2_aux
  );
  q_out <= q0_aux;
end;