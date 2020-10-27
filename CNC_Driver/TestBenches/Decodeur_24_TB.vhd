library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;
 
ENTITY Decodeur_24_TB IS
END Decodeur_24_TB;
 
ARCHITECTURE behavior OF Decodeur_24_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decodeur_24
    PORT(
         Din : IN  std_logic_vector(1 downto 0);
         Dout : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Din : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Dout : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
	SIGNAL clk : std_logic := '0';
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decodeur_24 PORT MAP (
          Din => Din,
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
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

     -- insert stimulus here 
		for j in 0 to 4 loop
			for k in 0 to 3 loop
				Din <= std_logic_vector(to_unsigned(k, 2) );
				 wait for clk_period*5;
			end loop;
			wait for  clk_period*5;
		end loop;
      wait;
   end process;

END;
