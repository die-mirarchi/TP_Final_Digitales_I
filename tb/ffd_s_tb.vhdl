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
  signal en_tb   : bit := '0';
  signal q_tb    : bit;

  -- Constantes para el período del reloj
  constant CLK_PERIOD : time := 10 ns;

begin
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

  -- Generador de reloj
  clk_process : process
  begin
    clk_tb <= '0';
    wait for CLK_PERIOD/2;
    clk_tb <= '1';
    wait for CLK_PERIOD/2;
  end process;

  -- Proceso de estímulos
  stimulus_process : process
  begin
    -- Esperar un poco antes de comenzar
    wait for 5 ns;

    -- Test 1: Verificar estado inicial
    report "=== Test 1: Estado inicial ===" severity note;
    d_tb    <= '0';
    srst_tb <= '0';
    en_tb   <= '0';
    wait for CLK_PERIOD * 2;

    -- Test 2: Probar carga de datos con enable activo
    report "=== Test 2: Carga de '1' con enable activo ===" severity note;
    d_tb    <= '1';
    en_tb   <= '1';
    srst_tb <= '0';
    wait for CLK_PERIOD;
    assert q_tb = '1' report "Error: q_out debería ser '1'" severity error;

    -- Test 3: Mantener dato con enable inactivo
    report "=== Test 3: Mantener dato con enable inactivo ===" severity note;
    d_tb  <= '0'; -- Cambiar entrada pero enable desactivado
    en_tb <= '0';
    wait for CLK_PERIOD;
    assert q_tb = '1' report "Error: q_out debería mantener '1'" severity error;

    -- Test 4: Cargar nuevo dato con enable activo
    report "=== Test 4: Cargar '0' con enable activo ===" severity note;
    d_tb  <= '0';
    en_tb <= '1';
    wait for CLK_PERIOD;
    assert q_tb = '0' report "Error: q_out debería ser '0'" severity error;

    -- Test 5: Probar reset síncrono
    report "=== Test 5: Reset síncrono ===" severity note;
    d_tb  <= '1';
    en_tb <= '1';
    wait for CLK_PERIOD; -- Cargar '1' primero
    assert q_tb = '1' report "Error: q_out debería ser '1' antes del reset" severity error;

    srst_tb <= '1'; -- Activar reset síncrono
    wait for CLK_PERIOD;
    assert q_tb = '0' report "Error: q_out debería ser '0' después del reset síncrono" severity error;

    -- Test 6: Verificar que reset síncrono tiene prioridad sobre enable
    report "=== Test 6: Reset síncrono con enable activo ===" severity note;
    srst_tb <= '1';
    en_tb   <= '1';
    d_tb    <= '1';
    wait for CLK_PERIOD;
    assert q_tb = '0' report "Error: Reset síncrono debería tener prioridad" severity error;

    -- Test 7: Volver a operación normal
    report "=== Test 7: Operación normal después del reset ===" severity note;
    srst_tb <= '0';
    en_tb   <= '1';
    d_tb    <= '1';
    wait for CLK_PERIOD;
    assert q_tb = '1' report "Error: q_out debería ser '1' después de salir del reset" severity error;

    -- Test 8: Secuencia de datos
    report "=== Test 8: Secuencia de datos ===" severity note;
    srst_tb <= '0';
    en_tb   <= '1';

    -- Cargar secuencia: 0, 1, 0, 1
    d_tb <= '0';
    wait for CLK_PERIOD;
    assert q_tb = '0' report "Error en secuencia: esperado '0'" severity error;

    d_tb <= '1';
    wait for CLK_PERIOD;
    assert q_tb = '1' report "Error en secuencia: esperado '1'" severity error;

    d_tb <= '0';
    wait for CLK_PERIOD;
    assert q_tb = '0' report "Error en secuencia: esperado '0'" severity error;

    d_tb <= '1';
    wait for CLK_PERIOD;
    assert q_tb = '1' report "Error en secuencia: esperado '1'" severity error;

    -- Test 9: Enable intermitente
    report "=== Test 9: Enable intermitente ===" severity note;
    d_tb  <= '0';
    en_tb <= '1';
    wait for CLK_PERIOD; -- Cargar '0'

    d_tb  <= '1';
    en_tb <= '0'; -- Disable, no debería cambiar
    wait for CLK_PERIOD;
    assert q_tb = '0' report "Error: no debería cambiar con enable desactivado" severity error;

    en_tb <= '1'; -- Enable, ahora sí debería cambiar
    wait for CLK_PERIOD;
    assert q_tb = '1' report "Error: debería cambiar con enable activado" severity error;

    -- Test completado
    report "=== TODOS LOS TESTS COMPLETADOS ===" severity note;
    wait for CLK_PERIOD * 2;

    -- Finalizar simulación
    wait;
  end process;

end ffd_s_tb_arq;
