-------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
---------- 
ENTITY Machine_TB IS
END Machine_TB;
---------
ARCHITECTURE behavior OF Machine_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Machine
    PORT(
         S1 : IN  std_logic;
         S2 : IN  std_logic;
         clock_100Mhz : IN  std_logic;
         raz : IN  std_logic;
         S_monnaie : OUT  std_logic;
         Film : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal S1 : std_logic := '0';
   signal S2 : std_logic := '0';
   signal clock_100Mhz : std_logic := '0';
   signal raz : std_logic := '0';

 	--Outputs
   signal S_monnaie : std_logic;
   signal Film : std_logic;

   -- Clock period definitions
   constant clock_100Mhz_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Machine PORT MAP (
          S1 => S1,
          S2 => S2,
          clock_100Mhz => clock_100Mhz,
			 raz => raz,
          S_monnaie => S_monnaie,
          Film => Film
        );

   -- Clock process definitions
   clock_100Mhz_process :process
   begin
		clock_100Mhz <= '0';
		wait for clock_100Mhz_period/2;
		clock_100Mhz <= '1';
		wait for clock_100Mhz_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
	variable i : integer := 0;
   begin		
      --------- hold reset state for 100 ns.
      wait for 100 ns;	
      wait for clock_100Mhz_period*10;
      --------- insert stimulus here 
		for i in 0 to 13 loop	--générer des entrées de 1$
			S1 <= '1'; 
			wait for clock_100Mhz_period;
			S1 <= '0';
			wait for clock_100Mhz_period;
		end loop;
		
		raz <= '1';
		wait for clock_100Mhz_period;
		raz <= '0';
		
		for i in 0 to 7 loop 	-- Générer des entrées de 2$
			S2 <= '1'; 
			wait for clock_100Mhz_period;
			S2 <= '0';
			wait for clock_100Mhz_period;
		end loop;
		
		wait for clock_100Mhz_period*3;-- Pour eviter un bug au milieur du pgm(sorties maintenue en 1)
		raz <= '1';							-- la remise à zéro doit étre rapide pour eviter le bug => (1 cycle de clk)
		wait for clock_100Mhz_period;
		raz <= '0';
		
		for i in 0 to 7 loop		-- Générer un mélange entre 2$ et 1$
			S2 <= '1'; 
			wait for clock_100Mhz_period;
			S2 <= '0';
			wait for clock_100Mhz_period;
			if(i = 3)then 
				S1 <= '1';
				wait for clock_100Mhz_period;
				S1 <= '0';
				wait for clock_100Mhz_period;
			end if;		
		end loop;
      wait;
   end process;

END;