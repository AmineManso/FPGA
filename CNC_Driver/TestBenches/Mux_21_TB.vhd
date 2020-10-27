LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Mux_21_TB IS
END Mux_21_TB;
 
ARCHITECTURE behavior OF Mux_21_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux_21
    PORT(
         Din_1 : IN  std_logic_vector(3 downto 0);
         Din_2 : IN  std_logic_vector(3 downto 0);
         TypePas : IN  std_logic;
         Dout : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Din_1 : std_logic_vector(3 downto 0) := (others => '0');
   signal Din_2 : std_logic_vector(3 downto 0) := (others => '0');
   signal TypePas : std_logic := '0';

 	--Outputs
   signal Dout : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
	signal clk : std_logic:= '0';
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux_21 PORT MAP (
          Din_1 => Din_1,
          Din_2 => Din_2,
          TypePas => TypePas,
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
		Din_1 <= x"A";
Din_2  <= x"B";		
		TypePas <= '0';
		wait for 100 ns;
		TypePas <= '1';

      wait;
   end process;

END;
