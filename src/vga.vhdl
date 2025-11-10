-- Controlador VGA (sin multiplexores) para 640x480@60
-- Horiz: 800 totales → visible 0..639, HS bajo 656..751 (cambia en 655/751), reset en 799
-- Vert : 525 totales → visible 0..479, VS bajo 490..491 (cambia en 489/491), reset en 524
-- Tipos y estilo alineados al proyecto (bit/bit_vector, cont_nbit, ffd_sinc)

entity vga_ctrl is
  port (
    clk     : in bit; -- Reloj de píxel (25.175 MHz típico; en sim podés usar 25 MHz)
    red_i   : in bit;
    grn_i   : in bit;
    blu_i   : in bit;
    hs      : out bit; -- HS activo en '0'
    vs      : out bit; -- VS activo en '0'
    red_o   : out bit;
    grn_o   : out bit;
    blu_o   : out bit;
    pixel_x : out bit_vector(9 downto 0); -- 0..799
    pixel_y : out bit_vector(9 downto 0) -- 0..524
  );
end vga_ctrl;

architecture vga_ctrl_arq of vga_ctrl is
  ---------------------------------------------------------------------------
  -- Componentes del proyecto
  ---------------------------------------------------------------------------
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

  component ffd_sinc is
    port (
      clk_i  : in bit;
      d_in   : in bit;
      srst_i : in bit; -- reset sincrónico en '1'
      en_i   : in bit;
      q_out  : out bit
    );
  end component;

  ---------------------------------------------------------------------------
  -- Señales de contadores (ripple con cont_nbit)
  ---------------------------------------------------------------------------
  signal h_d, h_q, h_next : bit_vector(9 downto 0);
  signal v_d, v_q, v_next : bit_vector(9 downto 0);
  signal h_rst, v_rst     : bit;
  signal line_pulse       : bit;

  ---------------------------------------------------------------------------
  -- Sincronismos
  ---------------------------------------------------------------------------
  signal hs_q, vs_q : bit := '1';

  ---------------------------------------------------------------------------
  -- Detectores de igualdad (compuertas) (MSB..LSB: bit 9..0)
  ---------------------------------------------------------------------------
  -- H
  signal h_eq_639, h_eq_655, h_eq_751, h_eq_799 : bit;
  -- V
  signal v_eq_479, v_eq_489, v_eq_491, v_eq_524 : bit;

  ---------------------------------------------------------------------------
  -- Ventanas visibles combinacionales
  ---------------------------------------------------------------------------
  signal h_vis_c, v_vis_c : bit;
  signal video_on         : bit;

  -- Próximos valores (solo lógica)
  signal hs_d_aux, vs_d_aux : bit;

begin
  ----------------------------------------------------------------------------
  -- CONTADOR HORIZONTAL 0..799
  ----------------------------------------------------------------------------
  h_d(0) <= '1';
  gen_h : for i in 0 to 9 generate
    u_ch : cont_nbit
    port map
    (
      enable_i => '1', reset_i => h_rst, clock_i => clk,
      en_d_i => h_d(i), q0_out => h_q(i), next_out => h_next(i)
    );
  end generate gen_h;

  chain_h : for i in 1 to 9 generate
    h_d(i) <= h_next(i - 1);
  end generate chain_h;

  pixel_x <= h_q;

  -- Igualdades (binario 10 bits: b9..b0)
  -- 639 = 1001111111
  --h_eq_639 <= h_q(9) and (not h_q(8)) and (not h_q(7)) and h_q(6) and h_q(5) and
  --  h_q(4) and h_q(3) and h_q(2) and h_q(1) and h_q(0);
  -- 655 = 1010001111 (baja HS en este ciclo → HS=0 desde x=656)
  h_eq_655 <= h_q(9) and (not h_q(8)) and h_q(7) and (not h_q(6)) and (not h_q(5)) and
    (not h_q(4)) and h_q(3) and h_q(2) and h_q(1) and h_q(0);
  -- 751 = 1011101111 (sube HS en este ciclo → HS=1 desde x=752)
  h_eq_751 <= h_q(9) and (not h_q(8)) and h_q(7) and h_q(6) and h_q(5) and
    (not h_q(4)) and h_q(3) and h_q(2) and h_q(1) and h_q(0);
  -- 799 = 1100011111 (reset horizontal)
  h_eq_799 <= h_q(9) and h_q(8) and (not h_q(7)) and (not h_q(6)) and (not h_q(5)) and
    h_q(4) and h_q(3) and h_q(2) and h_q(1) and h_q(0);

  h_rst      <= h_eq_799; -- reset horizontal al alcanzar 799
  line_pulse <= h_eq_799; -- pulso de fin de línea (avanza vertical)

  ----------------------------------------------------------------------------
  -- CONTADOR VERTICAL 0..524 (clock: fin de línea)
  ----------------------------------------------------------------------------
  v_d(0) <= '1';
  gen_v : for i in 0 to 9 generate
    u_cv : cont_nbit
    port map
    (
      enable_i => line_pulse, reset_i => v_rst, clock_i => clk,
      en_d_i => v_d(i), q0_out => v_q(i), next_out => v_next(i)
    );
  end generate gen_v;

  chain_v : for i in 1 to 9 generate
    v_d(i) <= v_next(i - 1);
  end generate chain_v;

  pixel_y <= v_q;

  -- Igualdades V
  -- 479 = 0111011111
  -- <= (not v_q(9)) and v_q(8) and v_q(7) and v_q(6) and (not v_q(5)) and
  --  v_q(4) and v_q(3) and v_q(2) and v_q(1) and v_q(0);
  -- 489 = 0111101001 (baja VS al fin de línea → VS=0 desde y=490)
  v_eq_489 <= (not v_q(9)) and v_q(8) and v_q(7) and v_q(6) and v_q(5) and
    (not v_q(4)) and v_q(3) and (not v_q(2)) and (not v_q(1)) and v_q(0);
  -- 491 = 0111101011 (sube VS al fin de línea → VS=1 desde y=492)
  v_eq_491 <= (not v_q(9)) and v_q(8) and v_q(7) and v_q(6) and v_q(5) and
    (not v_q(4)) and v_q(3) and (not v_q(2)) and v_q(1) and v_q(0);
  -- 524 = 1000001100 (reset vertical)
  v_eq_524 <= v_q(9) and (not v_q(8)) and (not v_q(7)) and (not v_q(6)) and (not v_q(5)) and
    (not v_q(4)) and v_q(3) and v_q(2) and (not v_q(1)) and v_q(0);

  v_rst <= v_eq_524;

  ----------------------------------------------------------------------------
  -- HSYNC 
  -- hs_d = 0 cuando x=655  (HS=0 desde 656..751)
  -- hs_d = 1 cuando x=751  (HS=1 desde 752..)
  -- hs_d = hs_q en el resto
  ----------------------------------------------------------------------------
  hs_d_aux <= (h_eq_751) or ((not h_eq_751) and (not h_eq_655) and hs_q);
  u_hs : ffd_sinc
  port map
    (clk_i => clk, d_in => hs_d_aux, srst_i => '0', en_i => '1', q_out => hs_q);
  hs <= hs_q;

  ----------------------------------------------------------------------------
  -- VSYNC 
  -- vs_d = 0 cuando y=489 & line_pulse  (VS=0 desde 490..491)
  -- vs_d = 1 cuando y=491 & line_pulse  (VS=1 desde 492..)
  -- vs_d = vs_q en el resto
  ----------------------------------------------------------------------------
  vs_d_aux <= ((v_eq_491 and line_pulse)) or
    ((not ((v_eq_491 or v_eq_489) and line_pulse)) and vs_q);
  u_vs : ffd_sinc
  port map
    (clk_i => clk, d_in => vs_d_aux, srst_i => '0', en_i => '1', q_out => vs_q);
  vs <= vs_q;

  ----------------------------------------------------------------------------
  -- Ventana visible combinacional 
  -- H visible: x < 640  ->  (b9=0) OR (b9=1 AND b8=0 AND b7=0)
  -- V visible: y < 480  ->  (b9=0) AND ( (b8=0) OR (b8=1 AND NOT(b7 AND b6 AND b5)) )
  ----------------------------------------------------------------------------
  h_vis_c <= (not h_q(9)) or (h_q(9) and (not h_q(8)) and (not h_q(7)));
  v_vis_c <= (not v_q(9)) and ((not v_q(8)) or (v_q(8) and (not (v_q(7) and v_q(6) and v_q(5)))));

  ----------------------------------------------------------------------------
  -- Salida de video (enmascarada por ventana visible combinacional)
  ----------------------------------------------------------------------------
  video_on <= h_vis_c and v_vis_c;
  red_o    <= video_on and red_i;
  grn_o    <= video_on and grn_i;
  blu_o    <= video_on and blu_i;

end architecture;
