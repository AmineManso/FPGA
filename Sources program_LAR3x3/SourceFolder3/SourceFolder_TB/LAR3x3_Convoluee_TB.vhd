LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY LAR3x3_Convoluee_TB IS
END LAR3x3_Convoluee_TB;
 
ARCHITECTURE behavior OF LAR3x3_Convoluee_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LAR3x3_Convoluee
    PORT(
         DataIn : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         Ce : IN  std_logic;
         reset : IN  std_logic;
         Coef1 : IN  std_logic_vector(7 downto 0);
         Coef2 : IN  std_logic_vector(7 downto 0);
         Coef3 : IN  std_logic_vector(7 downto 0);
         Coef4 : IN  std_logic_vector(7 downto 0);
         Coef5 : IN  std_logic_vector(7 downto 0);
         Coef6 : IN  std_logic_vector(7 downto 0);
         Coef7 : IN  std_logic_vector(7 downto 0);
         Coef8 : IN  std_logic_vector(7 downto 0);
         Coef9 : IN  std_logic_vector(7 downto 0);
         DataOut : OUT  std_logic_vector(15 downto 0) --(7 downto 0)  --(15 downto 0)
        ); 
    END COMPONENT;
    

   --Inputs
   signal DataIn : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal Ce : std_logic := '0';
   signal reset : std_logic := '0';
   signal Coef1 : std_logic_vector(7 downto 0) := (others => '0');
   signal Coef2 : std_logic_vector(7 downto 0) := (others => '0');
   signal Coef3 : std_logic_vector(7 downto 0) := (others => '0');
   signal Coef4 : std_logic_vector(7 downto 0) := (others => '0');
   signal Coef5 : std_logic_vector(7 downto 0) := (others => '0');
   signal Coef6 : std_logic_vector(7 downto 0) := (others => '0');
   signal Coef7 : std_logic_vector(7 downto 0) := (others => '0');
   signal Coef8 : std_logic_vector(7 downto 0) := (others => '0');
   signal Coef9 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal DataOut : std_logic_vector(15 downto 0); --(7 downto 0);  --(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LAR3x3_Convoluee PORT MAP (
          DataIn => DataIn,
          clk => clk,
          Ce => Ce,
          reset => reset,
          Coef1 => Coef1,
          Coef2 => Coef2,
          Coef3 => Coef3,
          Coef4 => Coef4,
          Coef5 => Coef5,
          Coef6 => Coef6,
          Coef7 => Coef7,
          Coef8 => Coef8,
          Coef9 => Coef9,
          DataOut => DataOut
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period*3/4;
		clk <= '1';
		wait for clk_period/4;
   end process;
 

   -- Stimulus process
   stim_proc: process
		variable i: integer :=0;
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Ce <= '1';	 
      wait for clk_period*10;
      -- insert stimulus here    
			 wait for clk_period*50;
			 
         Coef1 <= x"01";
         Coef2 <= x"01";
         Coef3 <= x"01";
         Coef4 <= x"01";
         Coef5 <= x"01";
         Coef6 <= x"01";
         Coef7 <= x"01";
         Coef8 <= x"01";
         Coef9 <= x"01";
			

			for i in 0 to 255 loop
				DataIn <= conv_std_logic_vector(i, 8);
				if(i> 50 and i< 100)then DataIn <= x"00";
				end if;
				wait for clk_period;	
			end loop;	
         
      wait;
   end process;

END;
