-- to jest komponent który udaje ¿e jest nvsramem na potrzeby symulacji

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity nvsramSim is
port (
		A		: IN    std_logic_vector(10 downto 0);	--address
		DQ 	: OUT  std_logic_vector(7 downto 0); 	--data
		CE 	: IN    std_logic;								--chip enable
		OE 	: IN    std_logic;								--output enable
		WE 	: IN    std_logic;								--write enable
		clk 	: IN 	  std_logic
		);
end nvsramSim;

architecture Behavioral of nvsramSim is	
begin
	X: process(clk) is
	begin 
		if(clk'event and clk='1') then
			if(CE='1' and OE='1' and WE='0' and A="00000000000") then
				DQ<="11001000"; --200
			else
				DQ<="00000000"; --unknown
			end if;			
		end if;
	end process X;
end Behavioral;

