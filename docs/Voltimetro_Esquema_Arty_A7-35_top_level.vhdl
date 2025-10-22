----------------------------------------------------------------------------------
-- Modulo: 		Voltimetro_toplevel
-- Descripcion: Voltimetro implementado con un modulador sigma-delta
-- Autor: 		Electronica Digital I
--        		Universidad de San Martin - Escuela de Ciencia y Tecnologia
--
-- Fecha: 		01/09/2020
--              Actualizado: 26/05/2025
----------------------------------------------------------------------------------

entity Voltimetro_toplevel is
	port(
		clk_i			: in bit;
		rst_i			: in bit;
		data_volt_in_i	: in bit;
		data_volt_out_o	: out bit;
		hs_o 			: out bit;
		vs_o 			: out bit;
		red_o 			: out bit;
		grn_o 			: out bit;
        blu_o 			: out bit
	);
	
end Voltimetro_toplevel;

architecture Voltimetro_toplevel_arq of Voltimetro_toplevel is

	-------------------------------------------------------------------------------------
	-- Declaracion del componente voltimetro
	--   Este componente incluye el bloque de procesamiento de datos y control y el
	--   flip-flop de entrada
	-------------------------------------------------------------------------------------
	component Voltimetro is
		port(
			clk_i      		: in bit;
			rst_i      		: in bit;
			data_volt_in_i  : in bit;
			data_volt_out_o : out bit;
			hs_o    		: out bit;
			vs_o    		: out bit;
			red_o  			: out bit;
			grn_o  			: out bit;
			blu_o  			: out bit
		);
	end component Voltimetro;
	
	-------------------------------------------------------------------------------------
	-- Declaracion del componente generador de reloj
	--   Se implementa con un contador de 2 bits, tomando el bit mas alto de su salida
	-------------------------------------------------------------------------------------
	component cont_bin is
		generic(
			N: natural := 4	-- Cantidad de bits de la cuenta
		)
		port(
			clk_i : in bit;
			rst_i : in bit;
			ena_i : in bit;
	  		q_o   : out bit
		);
    end component;
    
	signal cuenta   : bit_vector(1 downto 0);
	signal clk25MHz	: bit;
	
begin

	-- Generador del reloj lento
	clk25MHz_gen : cont_bin
		generic map(
			N => 2 
		)
   		port map ( 
   			clk_i => clk_i,		-- reloj del sistema (100 MHz)
   			rst_i => rst_i, 
			ena_i => '1',
			q_o   => cuenta
 		);
		
	clk25MHz <= cuenta(1);		-- reloj generado (25 MHz)

	-- Instancia del bloque voltimetro
	inst_voltimetro: Voltimetro
		port map(
            clk_i			=> clk25MHz,
            rst_i			=> rst_i,
            data_volt_in_i	=> data_volt_in_i,
            data_volt_out_o	=> data_volt_out_o,
            hs_o			=> hs_o,
            vs_o			=> vs_o,
            red_o			=> red_o,
            grn_o			=> grn_o,
            blu_o			=> blu_o
        );

end Voltimetro_toplevel_arq;