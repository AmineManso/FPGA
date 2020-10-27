--------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Counter_TB IS
END Counter_TB;
 
ARCHITECTURE behavior OF Counter_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Counter
    PORT(
         E : IN  std_logic;
         clk : IN  std_logic;
         CE : IN  std_logic;
         ras : IN  std_logic;
         Sortie_C : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal E : std_logic := '0';
   signal clk : std_logic := '0';
   signal CE : std_logic := '0';
   signal ras : std_logic := '0';

 	--Outputs
   signal Sortie_C : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Counter PORT MAP (
          E => E,
          clk => clk,
          CE => CE,
          ras => ras,
          Sortie_C => Sortie_C
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
	variable i : integer := 0; -- variable utilisée comme indice de la Boucle
   begin		
      ---------- hold reset state for 100 ns.
      wait for 100 ns;	
      wait for clk_period*10;
      ---------- insert stimulus here 
		CE <= '1';
		ras <= '0';
		E <= '1' after 100 ns, '0' after 150 ns , '1' after 200 ns;
		
		for i in 0 to 50 loop
			E <= '1';
			wait for clk_period;		
			E <= '0';
			wait for clk_period;
				if(i = 25)then ras <= '1';
				else ras <= '0';
				end if;
		end loop;
		
		E <= '1';
		wait for 221 ns;
		E <= '0' ; 
		wait for 215 ns;
		E <= '1';
		wait for 230 ns;
		
      ras <= '1';
		wait for 100 ns;
		wait;
   end process;

END;
