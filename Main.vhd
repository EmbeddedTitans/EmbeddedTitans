
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.ALL;


entity Main is
generic (width1: integer := 8; width2: integer := 2);
port(	
	clk: 	in std_logic;	
	rst:	in std_logic;	
	rotSignal: in std_logic;			
	modeSpeed: in std_logic;
	modeDist: in std_logic;	
	value: out unsigned(31 downto 0) -- to nie bêdzie jako sygna³ wyjœciowy, ale póki co bez tego siê nie zsyntetyzuje
	--tu bêd¹ wszystkie wyprowadzenia do wyœwietlacza
);
end Main;


architecture Structural of Main is
signal modeSignal: unsigned(1 downto 0);
signal valueSignal: unsigned(31 downto 0);
signal LCDreadySignal: std_logic;
--to jest miêdzy FSMD a nvsram
signal NVRAMdataSignal	: std_logic_vector(7 downto 0); 
signal NVRAMrdySignal: std_logic;
signal NVRAMenableSignal: std_logic;
--te s¹ miêdzy nvsram a nvsramSim
signal 	A : std_logic_vector(10 downto 0);	--do nvsram
signal	DQ : std_logic_vector(7 downto 0); 	--do nvsram
signal	CE : std_logic;								--do nvsram
signal	OE : std_logic;								--do nvsram
signal	WE : std_logic;								--do nvsram

begin
	nvsramSim: entity WORK.nvsramSim
									port map(A=>A,DQ=>DQ,CE=>CE,WE=>WE,OE=>OE,clk=>clk);
	nvsram: entity WORK.nvsram
									port map(clk=>clk,rst=>rst,A=>A,DQ=>DQ,CE=>CE,OE=>OE,WE=>WE,
											idata=>NVRAMdataSignal,ice=>NVRAMenableSignal,ordy=>NVRAMrdySignal);
	FSMD: entity WORK.FSMD	generic map(width1=>width1,width2=>width2)
									port map(clk=>clk,rst=>rst,rotSignal=>rotSignal,LCDReady=>LCDreadySignal,
												modeSpeed=>modeSpeed,modeDist=>modeDist,mode=>modeSignal,value=>value,
												NVRAMinput=>NVRAMdataSignal,NVRAMready=>NVRAMrdySignal,NVRAMenable=>NVRAMenableSignal);	
end Structural;
