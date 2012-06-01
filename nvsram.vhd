library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity nvsram is
	-- We have an external memory module (nvsram) that can store up to 2^11 bytes...
	-- ... but we only want something that can store or load (say) 16 bits.
	-- We'll build a circuit doing just that on top of existing nvsram
	-- NOTE: this module must be clocked at 100MHz or less (because of nvsram read/write cycle timing)
	-- (set timing constraints in "User Constraints"->"Create Timing Constraints")
	port(
		A		: OUT    std_logic_vector(10 downto 0);	--nvsram module port, address
		DQ 	: IN  std_logic_vector(7 downto 0); 	--nvsram module port, data
		CE 	: OUT    std_logic;								--nvsram module port, chip enable
		OE 	: OUT    std_logic;								--nvsram module port, output enable
		WE 	: OUT    std_logic;								--nvsram module port, write enable
		clk 	: IN     std_logic;
		rst 	: IN     std_logic;
		idata	: OUT  std_logic_vector(7 downto 0);	-- data - user key we want to store/load
		ice	: IN		std_logic;								-- chip enable	
		ordy	: OUT		std_logic								-- ready for next op?
	  );
end nvsram;

architecture Behavioral of nvsram is
	type state_type IS (IDLE,LOAD0,LOAD1);
	signal current_state: state_type;
begin
	A(10 downto 2)<=(others=>'0');
	X: process(clk) is
	begin
		if (clk'event and clk='1') then
			if (rst='1') then
				current_state <= IDLE;
			else
				case current_state is
					when IDLE=>
						if(ice='1') then
							ordy<='0';
							CE<='1';						
							A(1 downto 0)<="00";
							CE<='1';
							OE<='1';
							WE<='0';
							current_state <= LOAD0;							
						else
							ordy<='1';
							CE<='0';
							OE<='0';
							WE<='0';
							current_state <= IDLE;
						end if;
					when LOAD0=>						
						current_state <= LOAD1;
					when LOAD1=>
						idata(7 downto 0)<=DQ;						
						current_state <= IDLE;
					when others=>
						current_state <= IDLE;
				end case;
			end if;
		end if;
	end process X;
end Behavioral;