LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Div_f_TB IS
END Div_f_TB;
 
ARCHITECTURE behavior OF Div_f_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Div_f
    PORT(
         Tin : IN  std_logic;
         clk : IN  std_logic;
         Div : IN  std_logic_vector(1 downto 0);
         Qout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Tin : std_logic := '0';
   signal clk : std_logic := '0';
   signal Div : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Qout : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Div_f PORT MAP (
          Tin => Tin,
          clk => clk,
          Div => Div,
          Qout => Qout
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
		Tin <= '1';
		
		Div <= "00";
		wait for clk_period*10;
		Div <= "01";
		wait for clk_period*10;
		Div <= "10";
		wait for clk_period*10;
		Div <= "11";
		wait for clk_period*10;
		

      wait;
   end process;

END;
