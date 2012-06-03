--------------------------------------------------------------
-- G³ówny modu³ prêdkoœciomierza (automat skoñczony)
--------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use IEEE.NUMERIC_STD.ALL;
use work.all;

--------------------------------------------------------------

entity FSMD is
generic (width1: integer := 8; width2: integer := 2);
port(	
	clk: 	in std_logic;	-- sygna³ zegarowy
	rotSignal: in std_logic;	-- sygna³ zliczaj¹cy obroty ko³a
	rst:	in std_logic;	-- reset	
	LCDready: in std_logic;	-- czy wyœwietlacz jest gotowy
	modeSpeed: in std_logic;	-- czy jest uruchomiony tryb wyœwietlania prêdkoœci
	modeDist: in std_logic;	-- czy jest uruchomiony tryb wyœwietlania przejechanego dystansu
	NVRAMinput: in std_logic_vector(width1-1 downto 0); -- port do wczytywania obwodu ko³a z NVRAMu
	NVRAMready: in std_logic;	
	NVRAMenable: out std_logic;		
	mode:	out unsigned(width2-1 downto 0);	-- tryb dzia³ania wyœwietlacza
	value:	out unsigned(15 downto 0)	-- wartoœæ do wyœwietlenia na wyœwietlaczu
);
end FSMD;

--------------------------------------------------------------
--robiæ sampling i reagowaæ na ci¹gi jedynek
architecture Behavioral of FSMD is
begin	 
    process(rst, clk, rotSignal)
	 -- define states using variable     
	 type S_Type is (ST_INIT, ST_LOAD, ST_IDLE, ST_SPEED, ST_DIST);
    variable State: S_Type := ST_INIT ;
	 variable oldRotSignal: std_logic := '0';
	 variable Rotations: unsigned(7 downto 0):= to_unsigned(0,8);
	 variable Counter: unsigned(15 downto 0):= to_unsigned(0,16);
	 variable Distance: unsigned(31 downto 0):= to_unsigned(0,32);	 
	 variable WheelSize: unsigned(7 downto 0):=to_unsigned(0,8);
	 variable Speed: unsigned(31 downto 0):= to_unsigned(0,32);    
    begin
		if (rst='1') then		    -- initialization			
			value <= (others=>'0');
			oldRotSignal := '0';
			Rotations := to_unsigned(0,8);
			Counter := to_unsigned(0,16);
			Distance := to_unsigned(0,32);			
			Speed := to_unsigned(0,32);					
			State := ST_INIT;																						
		elsif (clk'event and clk='1') then
			case State is				
				when ST_INIT =>	-- starting
					mode <= "00";
					value <= to_unsigned(0,16);
					if(NVRAMready='1') then
						NVRAMenable <='1';										
						State:=ST_LOAD;
					else
						State:=ST_INIT;
					end if;
				when ST_LOAD =>	--wczytanie z NVRAMU
					if(Counter=3) then	--musimy zaczekaæ 3 cykle zanim dane przejd¹ przez proxy tam i z powrotem
						WheelSize:=unsigned(NVRAMinput);
						NVRAMenable <='0';
						State:=ST_IDLE;				
						Counter:=to_unsigned(0,16);
					else
						Counter:=Counter+1;
						State:=ST_LOAD;
					end if;
				when ST_IDLE =>	-- idle state 
					mode <= "01";											
					value <= to_unsigned(0,16);
					if(modeSpeed='1') then
						State:=ST_SPEED;
					elsif(modeDist='1') then
						State:=ST_DIST;
					else
						State := ST_IDLE;					
					end if;
				when ST_SPEED =>		    -- wyœwietlanie prêdkoœci
					-- sprawdŸ czy nie prze³¹czono na drugi tryb
					if modeDist='1' and modeSpeed='0' then
						mode <= "11";					
						State := ST_DIST;	
					elsif modeSpeed='0' and modeDist='0' then
						mode<="01";
						State := ST_IDLE;
					else 						
						-- wykrycie obrotu ko³a (ci¹g jedynek po ci¹gu zer)
						if rotSignal='1' and oldRotSignal='0' then
							Rotations:=Rotations+1;
							oldRotSignal:='1';
						elsif rotSignal='0' then
							oldRotSignal:='0';
						end if;
						-- co 4 sekundy oblicz prêdkoœæ i dystans i  i uaktualnij wyswietlacz
						if (Counter >= 4000) then																			 
							Speed := Rotations*WheelSize*9/1024; --obliczamy speed w km/h
							Distance := Distance+Rotations*WheelSize;							
							Counter :=to_unsigned(0,16);
							Rotations :=to_unsigned(0,8);
						else
							Counter := Counter + 1;
						end if;				
						mode <= "10";
						value <= resize(Speed,16);						
						State := ST_SPEED;					
					end if;		
				when ST_DIST =>	-- wyœwietlanie dystansu
					if modeSpeed='1' and modeDist='0' then
						mode <= "10";					
						State := ST_SPEED;
					elsif modeSpeed='0' and modeDist='0' then						
						State := ST_IDLE;
					else
						-- wykrycie obrotu ko³a 
						if rotSignal='1' and oldRotSignal='0' then
							Rotations:=Rotations+1;
							oldRotSignal:='1';
						elsif rotSignal='0' then
							oldRotSignal:='0';
						end if;
						-- co 4 sekundy oblicz dystans i uaktualnij wyswietlacz
						if (Counter >= 4000) then																			
							Distance := Distance+Rotations*WheelSize;							
							Counter :=to_unsigned(0,16);
							Rotations :=to_unsigned(0,8);
							value <= resize(((to_unsigned(1640,16)*Distance)/4096/4096),16);																					 
						else						
							Counter := Counter + 1;
						end if;						
						mode <= "11";												
						State := ST_DIST;
					end if;
				when others =>		    -- go back 					
					State := ST_INIT;
			end case;
		end if;		
	end process;
end Behavioral;
