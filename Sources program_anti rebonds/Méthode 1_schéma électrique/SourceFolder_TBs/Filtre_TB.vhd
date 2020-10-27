LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY Filtre_TB IS
END Filtre_TB;
 
ARCHITECTURE behavior OF Filtre_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Filtre
    PORT(
         Din : IN  std_logic;
         clk : IN  std_logic;
         CE : IN  std_logic;
         Cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Din : std_logic := '0';
   signal clk : std_logic := '0';
   signal CE : std_logic := '0';

 	--Outputs
   signal Cout : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Filtre PORT MAP (
          Din => Din,
          clk => clk,
          CE => CE,
          Cout => Cout
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
	variable i : integer := 0; -- variable utilisée comme indice de Boucle.
   begin		
      ----------- hold reset state for 100 ns.
      wait for 100 ns;	
      wait for clk_period*10;
      ----------- insert stimulus here 
		CE <= '1';

			for i in 0 to 9 loop ------- génération des premiers rebonds 
				Din <= '1';
				wait for clk_period;
				Din <= '0';
				wait for clk_period;
			end loop;
			
		   Din <= '1';				-------  l'état haut de l'entrée
			wait for  clk_period*20;
			
			for i in 0 to 9 loop------- génération des seconds rebonds
				Din <= '1';
				wait for clk_period;
				Din <= '0';
				wait for clk_period;
			end loop;
			
      wait;
   end process;

END;
----------------------------
  