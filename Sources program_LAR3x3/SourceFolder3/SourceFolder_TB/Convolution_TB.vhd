LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Convolution_TB IS
END Convolution_TB;
 
ARCHITECTURE behavior OF Convolution_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT convolution_1
    PORT(
         P1 : IN  std_logic_vector(7 downto 0);
         P2 : IN  std_logic_vector(7 downto 0);
         P3 : IN  std_logic_vector(7 downto 0);
         P4 : IN  std_logic_vector(7 downto 0);
         P5 : IN  std_logic_vector(7 downto 0);
         P6 : IN  std_logic_vector(7 downto 0);
         P7 : IN  std_logic_vector(7 downto 0);
         P8 : IN  std_logic_vector(7 downto 0);
         P9 : IN  std_logic_vector(7 downto 0);
         C1 : IN  std_logic_vector(7 downto 0);
         C2 : IN  std_logic_vector(7 downto 0);
         C3 : IN  std_logic_vector(7 downto 0);
         C4 : IN  std_logic_vector(7 downto 0);
         C5 : IN  std_logic_vector(7 downto 0);
         C6 : IN  std_logic_vector(7 downto 0);
         C7 : IN  std_logic_vector(7 downto 0);
         C8 : IN  std_logic_vector(7 downto 0);
         C9 : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         Ce : IN  std_logic;
         Sortie_Convolution : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal P1 : std_logic_vector(7 downto 0) := (others => '0');
   signal P2 : std_logic_vector(7 downto 0) := (others => '0');
   signal P3 : std_logic_vector(7 downto 0) := (others => '0');
   signal P4 : std_logic_vector(7 downto 0) := (others => '0');
   signal P5 : std_logic_vector(7 downto 0) := (others => '0');
   signal P6 : std_logic_vector(7 downto 0) := (others => '0');
   signal P7 : std_logic_vector(7 downto 0) := (others => '0');
   signal P8 : std_logic_vector(7 downto 0) := (others => '0');
   signal P9 : std_logic_vector(7 downto 0) := (others => '0');
   signal C1 : std_logic_vector(7 downto 0) := (others => '0');
   signal C2 : std_logic_vector(7 downto 0) := (others => '0');
   signal C3 : std_logic_vector(7 downto 0) := (others => '0');
   signal C4 : std_logic_vector(7 downto 0) := (others => '0');
   signal C5 : std_logic_vector(7 downto 0) := (others => '0');
   signal C6 : std_logic_vector(7 downto 0) := (others => '0');
   signal C7 : std_logic_vector(7 downto 0) := (others => '0');
   signal C8 : std_logic_vector(7 downto 0) := (others => '0');
   signal C9 : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal Ce : std_logic := '0';

 	--Outputs
   signal Sortie_Convolution : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: convolution_1 PORT MAP (
          P1 => P1,
          P2 => P2,
          P3 => P3,
          P4 => P4,
          P5 => P5,
          P6 => P6,
          P7 => P7,
          P8 => P8,
          P9 => P9,
          C1 => C1,
          C2 => C2,
          C3 => C3,
          C4 => C4,
          C5 => C5,
          C6 => C6,
          C7 => C7,
          C8 => C8,
          C9 => C9,
          clk => clk,
          Ce => Ce,
          Sortie_Convolution => Sortie_Convolution
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
      wait for clk_period*10;
      -- insert stimulus here 
			Ce <= '1';
			         P1 <= x"00",x"00" after 200 ns ;
						P2 <= x"01",x"00" after 200 ns;
                  P3 <= x"02",x"00" after 200 ns;
						P4 <= x"03",x"00" after 200 ns;
                  P5 <= x"04",x"00" after 200 ns;
						P6 <= x"05",x"00" after 200 ns;
                  P7 <= x"06",x"00" after 200 ns;
						P8 <= x"07",x"00" after 200 ns;
						P9 <= x"08",x"00" after 200 ns;
						
						
						C1 <= x"02",x"00" after 200 ns;
						C2 <= x"FC",x"00" after 200 ns;
                  C3 <= x"02",x"00" after 200 ns;
						C4 <= x"02",x"00" after 200 ns;
                  C5 <= x"02",x"00" after 200 ns;
						C6 <= x"02",x"00" after 200 ns;
                  C7 <= x"02",x"00" after 200 ns;
						C8 <= x"03",x"00" after 200 ns;
						C9 <= x"03",x"00" after 200 ns;
--						
--						C1 <= x"FC";
--						C2 <= x"FF";
--                  C3 <= x"FE";
--						C4 <= x"fc";
--                  C5 <= x"09";
--						C6 <= x"10";
--                  C7 <= x"00";
--						C8 <= x"01";
--						C9 <= x"0A";		
--		
      wait;
   end process;

END;
