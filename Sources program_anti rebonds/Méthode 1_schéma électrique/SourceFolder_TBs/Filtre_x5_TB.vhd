LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Filtre_x5_TB IS
END Filtre_x5_TB;
 
ARCHITECTURE behavior OF Filtre_x5_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Filtre_5_Boutons
    PORT(
         Din_x5 : IN  std_logic_vector(4 downto 0);
         clk : IN  std_logic;
         CE : IN  std_logic;
         Dout_x5 : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Din_x5 : std_logic_vector(4 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal CE : std_logic := '0';

 	--Outputs
   signal Dout_x5 : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Filtre_5_Boutons PORT MAP (
          Din_x5 => Din_x5,
          clk => clk,
          CE => CE,
          Dout_x5 => Dout_x5
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
      ------------- hold reset state for 100 ns.
      wait for 100 ns;	
      wait for clk_period*10;
      ------------- insert stimulus here 

		CE <= '1';

			for i in 0 to 9 loop ------- génération des premiers rebonds 
				Din_x5 <= (others=>'1');
				wait for clk_period;
				Din_x5 <=  (others=>'0');
				wait for clk_period;
			end loop;
			
		   Din_x5 <= (others=>'1');				-------  l'état haut de l'entrée
			wait for  clk_period*20;
			
			for i in 0 to 9 loop------- génération des seconds rebonds
				Din_x5 <= (others=>'1');
				wait for clk_period;
				Din_x5 <= (others=>'0');
				wait for clk_period;
			end loop;




      wait;
   end process;

END;
