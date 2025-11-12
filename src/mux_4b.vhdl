-- Multiplexor de 4 bits 
entity mux_4b is
  port (
    q0_i    : in bit_vector(3 downto 0);
    q1_i    : in bit_vector(3 downto 0);
    q2_i    : in bit_vector(3 downto 0);
    selec   : in bit_vector(2 downto 0);
    mux_out : out bit_vector(3 downto 0)
  );
end;

architecture mux_4b_arq of mux_4b is
  constant dot    : bit_vector(3 downto 0) := "1010"; -- Simbolo punto 
  constant V      : bit_vector(3 downto 0) := "1011"; -- Simbolo 'V'
  signal position : bit_vector(4 downto 0); -- Posicion del caracter seleccionado
begin
  -- Decodifica selec en posición
  position(0) <= (not selec(0)) and (not selec(1)) and (not selec(2)); -- 000
  position(1) <= (selec(0)) and (not selec(1)) and (not selec(2)); -- 001
  position(2) <= (not selec(0)) and (selec(1)) and (not selec(2)); -- 010
  position(3) <= (selec(0)) and (selec(1)) and (not selec(2)); -- 011
  position(4) <= (not selec(0)) and (not selec(1)) and (selec(2)); -- 100

  -- Multiplexor: selecciona entre q0, punto, q1, q2 o V
  conec : for i in 0 to 3 generate
    mux_out(i) <= (q0_i(i) and position(0)) or (dot(i) and position(1)) or (q1_i(i) and position(2)) or(q2_i(i) and position(3)) or(V(i) and position(4));
  end generate conec;
end;