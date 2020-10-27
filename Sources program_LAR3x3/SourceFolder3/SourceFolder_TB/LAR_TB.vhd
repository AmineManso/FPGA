LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

 
ENTITY LAR_TB IS
END LAR_TB;
 
ARCHITECTURE behavior OF LAR_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LAR
    PORT(
         Din : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         Ce : IN  std_logic;
         reset : IN  std_logic;
         P1 : OUT  std_logic_vector(7 downto 0);
         P2 : OUT  std_logic_vector(7 downto 0);
         P3 : OUT  std_logic_vector(7 downto 0);
         SortieLAR : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Din : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal Ce : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal P1 : std_logic_vector(7 downto 0);
   signal P2 : std_logic_vector(7 downto 0);
   signal P3 : std_logic_vector(7 downto 0);
   signal SortieLAR : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LAR PORT MAP (
          Din => Din,
          clk => clk,
          Ce => Ce,
          reset => reset,
          P1 => P1,
          P2 => P2,
          P3 => P3,
          SortieLAR => SortieLAR
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
	variable i : integer := 0;
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
			Ce <= '1';		   
			 wait for clk_period*3; 
			reset <= '1';		
			 wait for clk_period;
			 reset <= '0';
			 
			for i in 0 to 256 loop
				Din <= conv_std_logic_vector(i, 8);
				wait for clk_period;	
			end loop;
			 
      wait;
   end process;

END;
