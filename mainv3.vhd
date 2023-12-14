----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:29:52 11/14/2023 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( entradas : in  STD_LOGIC_VECTOR (3 DOWNTO 0);
			  clock : in STD_LOGIC;
			  clk_sys : in STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (2 DOWNTO 0);
			  reset : in STD_LOGIC;
			  --resultado : out STD_LOGIC
           lcd : out  STD_LOGIC_VECTOR (4 DOWNTO 0));
end main;

architecture Behavioral of main is
	signal vida : integer := 3;
	signal jogando : STD_LOGIC := '1';
	signal lcd_temp : STD_LOGIC_VECTOR (4 DOWNTO 0) := "00000";
	signal pontos : integer := 0;
	signal mostrarResult : STD_LOGIC := '0';
	


	COMPONENT Contador IS
		PORT (
		clk_sys : in  STD_LOGIC;
      mostrarResult : out  STD_LOGIC);
	END COMPONENT;
	
	

begin
		contadorM: Contador port map (
        clk_sys => clk_sys,
		  mostrarResult => mostrarResult
    );

	process(entradas, clock, jogando, pontos)
	begin
		if rising_edge(mostrarResult) then
			if vida = 3 then
				leds <= "111";
			elsif vida = 2 then
				leds <= "011";
			elsif vida = 1 then
				leds <= "001";
			elsif vida = 0 then
				leds <= "000";
			end if;
			if clock = '1' then
				if entradas = "0111" and lcd_temp(0) = '0' then
					lcd_temp(0) <= '1';
					pontos <= pontos + 1;
				elsif entradas = "0001" and lcd_temp(1) = '0'then
					lcd_temp(1) <= '1';
					pontos <= pontos + 1;
				elsif entradas = "0110" and lcd_temp(2) = '0' then
					pontos <= pontos + 1;
					lcd_temp(2) <= '1';
				elsif entradas = "0101" and lcd_temp(3) = '0' then
					pontos <= pontos + 1;
					lcd_temp(3) <= '1';
				elsif entradas = "0000" and lcd_temp(4) = '0' then
					pontos <= pontos + 1;
					lcd_temp(4) <= '1';
				else
					vida <= vida - 1;
					if vida = 0 then
						--resultado <= '0';
						jogando <= '0';
					end if;
				end if;
				if pontos = 5 then
					--resultado <= '1';
					jogando <= '0';
				end if;
			end if;
		end if;
		
		if reset = '1' then
				vida <= 3;
				jogando <= '1';
				lcd_temp <= "00000";
		end if;
	end process;
			
	
	lcd <= lcd_temp;


end Behavioral;

