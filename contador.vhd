library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Contador is
    Port ( clk_sys : in STD_LOGIC;  -- Clock do sistema
			  mostrarResult : out STD_LOGIC);
			  
end Contador;

architecture Behavioral of Contador is
    signal tmp_mostrarResult : STD_LOGIC := '0';
	 -- Clock de sistema de 50MHz, 2s = 100,000,000 ciclos
	 signal cnt_s : integer := 0;
    -- constant MAX_COUNT_2S : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000000000011"; -- Para teste	 
    -- constant MAX_COUNT_1S : STD_LOGIC_VECTOR(26 downto 0) := "000000000000000000000000001"; -- Para teste	
begin

	 process(clk_sys)
	 begin
		  if rising_edge(clk_sys) then
				if cnt_s = 49999999 then
					tmp_mostrarResult <= '1';
					cnt_s <= 0;
				else
					cnt_s <= cnt_s + 1;
					tmp_mostrarResult <= '0';
				end if;
		end if;
    end process;

    mostrarResult <= tmp_mostrarResult;
	 	 
end Behavioral;