LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY FF_T_TB IS
END FF_T_TB;
 
ARCHITECTURE behavior OF FF_T_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FF_T
    PORT(
         T : IN  std_logic;
         clk : IN  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal T : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal Q : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FF_T PORT MAP (
          T => T,
          clk => clk,
          Q => Q
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		T  <= '0';
		wait for clk_period*3;
		 T <= '1';
		wait for clk_period*10;
		T <= '0';
      wait;
   end process;

END;
