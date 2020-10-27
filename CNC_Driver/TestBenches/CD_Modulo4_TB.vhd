LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY CD_Modulo4_TB IS
END CD_Modulo4_TB;
 
ARCHITECTURE behavior OF CD_Modulo4_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CD_Modulo4
    PORT(
         S : IN  std_logic;
         D : IN  std_logic;
         G : IN  std_logic;
         clk : IN  std_logic;
         Dout : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal S : std_logic := '0';
   signal D : std_logic := '0';
   signal G : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal Dout : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CD_Modulo4 PORT MAP (
          S => S,
          D => D,
          G => G,
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
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		S <= '0';
		D <= '1';
		G <= '1';
		 wait for clk_period*3;
		 D <= '0';
		 wait for clk_period*3;
		 D <= '1';
		 wait for clk_period*3;
		--------------------
		S <= '1';
		D <= '0';
		wait for clk_period*5;
		G <= '0';
		wait for clk_period*3;
		S <= '0';
		G <= '0';
		wait for clk_period*3;
		G <= '1';
		
      wait;
   end process;

END;
