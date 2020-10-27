LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Driver_TB IS
END Driver_TB;
 
ARCHITECTURE behavior OF Driver_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Driver
    PORT(
         TP_x : IN  std_logic;
         clk_x : IN  std_logic;
         S_x : IN  std_logic;
         D_x : IN  std_logic;
         G_x : IN  std_logic;
         Div_x : IN  std_logic_vector(1 downto 0);
         DriverOut : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal TP_x : std_logic := '0';
   signal clk_x : std_logic := '0';
   signal S_x : std_logic := '0';
   signal D_x : std_logic := '0';
   signal G_x : std_logic := '0';
   signal Div_x : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal DriverOut : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_x_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Driver PORT MAP (
          TP_x => TP_x,
          clk_x => clk_x,
          S_x => S_x,
          D_x => D_x,
          G_x => G_x,
          Div_x => Div_x,
          DriverOut => DriverOut
        );
   -- Clock process definitions
   clk_x_process :process
   begin
		clk_x <= '0';
		wait for clk_x_period/2;
		clk_x <= '1';
		wait for clk_x_period/2;
   end process;
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      wait for clk_x_period*10;
      -- insert stimulus here 
			TP_x <= '0'; -- on introduit l'entrée Din_1
			S_x <= '1';
			D_x <= '0';
			G_x <= '1';
			Div_x <= "00"; -- choisir la vitesse max (première horloge , et c'est la plus rapide)
			wait for clk_x_period*10;
			------------------------
			TP_x <= '1'; 
			wait for clk_x_period*10;
			TP_x <= '0'; 
			wait for clk_x_period*10;
			---------------------
			S_x <= '0';
			D_x <= '0';
			G_x <= '0';
			Div_x <= "11"; -- choisir la vitesse la plus lante => H8 => Freq/8.
			wait for clk_x_period*10;
			
			
			
			
      wait;
   end process;

END;
