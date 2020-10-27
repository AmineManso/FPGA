LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
--USE ieee.std_logic_arith.ALL;

 
ENTITY Filtre_ME_TB IS
END Filtre_ME_TB;
 
ARCHITECTURE behavior OF Filtre_ME_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Filtre_ME
    PORT(
         Din : IN  std_logic;
         clk : IN  std_logic;
         Dout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Din : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal Dout : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	constant max_sim: integer := 10;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Filtre_ME PORT MAP (
          Din => Din,
          clk => clk,
          Dout => Dout
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
		variable i : integer := 0;	------ variable utilisée dans les boucles.
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		Din <= '0';
		wait for clk_period*10;
-----------------------Boucle 1 pour créer les rebond qui précédent le niveau haut du signal d'entrée 'Din'
		for i in 0 to max_sim loop
			Din <= '1';
			wait for clk_period;
			Din <= '0';
			wait for clk_period;
		end loop;
		 
		 Din <= '1'; wait for clk_period*20;
----------------------- Boucle 2 pour créer les rebond qui suivent  le niveau haut du signal d'entrée 'Din'.
		for i in 0 to max_sim loop
			Din <= '1';
			wait for clk_period;
			Din <= '0';
			wait for clk_period;
		end loop;
		 
      wait;
   end process;
END;
