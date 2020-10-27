LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Mux_41_TB IS
END Mux_41_TB;
 
ARCHITECTURE behavior OF Mux_41_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux_41
    PORT(
         Din : IN  std_logic_vector(3 downto 0);
         sel : IN  std_logic_vector(1 downto 0);
         Dout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Din : std_logic_vector(3 downto 0) := (others => '0');
   signal sel : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Dout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
	signal clk : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux_41 PORT MAP (
          Din => Din,
          sel => sel,
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
		Din <= "0001";
		sel <= "00";
		wait for clk_period*3;
		Din <= "0000";
		wait for clk_period*2;
		Din <= "0010";
		
		wait for clk_period*3;
		Din <= "0010";
		sel <= "01";
		wait for clk_period*3;
		Din <= "0100";
		sel <= "10";
		wait for clk_period*3;
		
		Din <= "1000";
		sel <= "11";
		wait for clk_period*3;
		
		

      wait;
   end process;

END;
