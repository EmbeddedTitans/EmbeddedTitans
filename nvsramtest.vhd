LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY nvsramtest IS
END nvsramtest;
 
ARCHITECTURE behavior OF nvsramtest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nvsramSim
    PORT(
         A : IN  std_logic_vector(10 downto 0);
         DQ : INOUT  std_logic_vector(7 downto 0);
         CE : IN  std_logic;
         OE : IN  std_logic;
         WE : IN  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(10 downto 0) := (others => '0');
   signal CE : std_logic := '0';
   signal OE : std_logic := '0';
   signal WE : std_logic := '0';
   signal clk : std_logic := '0';

	--BiDirs
   signal DQ : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: nvsramSim PORT MAP (
          A => A,
          DQ => DQ,
          CE => CE,
          OE => OE,
          WE => WE,
          clk => clk
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		            

      wait for clk_period*10;

      A(10 downto 0) <= (others=>'0');
		CE <= '1';
		OE <= '1';
      wait;
   end process;

END;
