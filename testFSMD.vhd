--------------------------------------------------------------------------------
-- test prze³¹czania stanów
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testFSMD IS
END testFSMD;
 
ARCHITECTURE behavior OF testFSMD IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
--    COMPONENT FSMD
--    PORT(
--         clk : IN  std_logic;
--         rotSignal : IN  std_logic;
--         rst : IN  std_logic;
--         go_i : IN  std_logic;
--         LCDready : IN  std_logic;
--         modeSpeed : IN  std_logic;
--         modeDist : IN  std_logic;
--         NVRAMinput : IN  unsigned(7 downto 0);
--         mode : OUT  unsigned(1 downto 0);
--         value : OUT  unsigned(31 downto 0)
--        );
--    END COMPONENT;
	 
	 COMPONENT Main		
	 PORT(	
			clk: 	in std_logic;	
			rst:	in std_logic;	
			rotSignal: in std_logic;					
			modeSpeed: in std_logic;
			modeDist: in std_logic;			
			value : OUT unsigned(31 downto 0)
			--tu bêd¹ te¿ wszystkie wyprowadzenia do wyœwietlacza
		);
		END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rotSignal : std_logic := '0';
   signal rst : std_logic := '0';   
	signal modeSpeed : std_logic := '0';
   signal modeDist : std_logic := '0';
	signal value : unsigned(31 downto 0) := to_unsigned(0,32);
--   signal LCDready : std_logic := '0';   
--   signal NVRAMinput : unsigned(7 downto 0) := (others => '0');

 	--Outputs
   --signal mode : unsigned(1 downto 0);
   --signal value : unsigned(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ms;
	
	constant rotSignal_period : time := 500 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
--   uut: FSMD PORT MAP (
--          clk => clk,
--          rotSignal => rotSignal,
--          rst => rst,
--          go_i => go_i,
--          LCDready => LCDready,
--          modeSpeed => modeSpeed,
--          modeDist => modeDist,
--          NVRAMinput => NVRAMinput,
--          mode => mode,
--          value => value
--        );

	uut: Main PORT MAP (
			 clk => clk,
          rotSignal => rotSignal,
          rst => rst,          
          modeSpeed => modeSpeed,
          modeDist => modeDist,			
			 value => value
	);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	rotSignal_process :process
   begin
		rotSignal <= '0';
		wait for 127*rotSignal_period/128;
		rotSignal <= '1';
		wait for rotSignal_period/128;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 5 ms.
      wait for 5 ms;	
      		
      -- insert stimulus here		
		modeSpeed <= '1';			
		wait for clk_period*10000;
		modeSpeed <= '0';
		modeDist <= '1';
		wait for clk_period*60000;
		rst <= '1';
		wait for clk_period*5;
		rst <= '0';
		wait for clk_period*30000;
		modeSpeed <= '0';
		modeDist <= '0';
		wait for clk_period*10000;
		modeSpeed <= '1';		
      wait;
   end process;

END;
