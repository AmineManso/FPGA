LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY Register_D_TB IS
END Register_D_TB;
 
ARCHITECTURE behavior OF Register_D_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Register_D
    PORT(
         E : IN  std_logic;
         clk : IN  std_logic;
         CE : IN  std_logic;
         Sortie_D : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal E : std_logic := '0';
   signal clk : std_logic := '0';
   signal CE : std_logic := '0';

 	--Outputs
   signal Sortie_D : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Register_D PORT MAP (
          E => E,
          clk => clk,
          CE => CE,
          Sortie_D => Sortie_D
        );

   -- Clock process definitions
   clk_process :process
	variable i : integer := 0;
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      ---------------- hold reset state for 100 ns.
      wait for 100 ns;	
      wait for clk_period*10;
      ---------------- insert stimulus here 
		CE <= '0' after 0 ns, '1' after 100 ns, '0' after 300 ns, '1' after 700 ns;
		E  <= '0' after 0 ns, '1' after 50 ns, '0' after 400 ns , '1' after 500 ns,
			   '0' after 550 ns, '1' after 750 ns ;
      wait;
   end process;

END;
