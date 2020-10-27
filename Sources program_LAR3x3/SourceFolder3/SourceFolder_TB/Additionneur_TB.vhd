library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.numeric_STD.ALL;
 
ENTITY Additionneur_TB IS
END Additionneur_TB;
 
ARCHITECTURE behavior OF Additionneur_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Additionneur_IPCore
    PORT(
         a : IN  std_logic_vector(15 downto 0);
         b : IN  std_logic_vector(15 downto 0);
         clk : IN  std_logic;
         add : IN  std_logic;
         c_in : IN  std_logic;
         ce : IN  std_logic;
         sclr : IN  std_logic;
         s : OUT  std_logic_vector(16 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(15 downto 0) := (others => '0');
   signal b : std_logic_vector(15 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal add : std_logic := '0';
   signal c_in : std_logic := '0';
   signal ce : std_logic := '0';
   signal sclr : std_logic := '0';

 	--Outputs
   signal s : std_logic_vector(16 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Additionneur_IPCore PORT MAP (
          a => a,
          b => b,
          clk => clk,
          add => add,
          c_in => c_in,
          ce => ce,
          sclr => sclr,
          s => s
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
		
--		a <= conv_std_logic_vector(  600, 17);
--		b <= conv_std_logic_vector(10, 17);
		a <= "00000000001111111";
		b <= "00000000010000000";
		ce <= '1';
		add <= '0';
		c_in <= '0';
		sclr <= '1';
		wait for 100 ns;
--		a <= conv_std_logic_vector(  30, 17);
--		b <= conv_std_logic_vector(1000, 17);

	   a <= "00001000000000000";
		b <= "00000000010000000";
	
		wait for 100 ns;
		sclr <= '1';

      wait;
   end process;

END;
