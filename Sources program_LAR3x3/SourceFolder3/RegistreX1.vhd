library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--------------------------------------------
entity registreX1 is
port(	E 					: in std_logic;
		clk, clkEnable	: in std_logic;
		set, reset 		: in std_logic;
		S 					: out std_logic);
end registreX1;
--------------------------------------------
architecture Behavioral of registreX1 is
  signal RS: std_logic_vector(1 downto 0); 
begin
	RS <= reset & set ;	
		process(clk,clkEnable)
		begin 		
			if (clkEnable = '1') then 					
					if (clk='1' and clk'event) then 					
						case RS is 
							when "00" => S <= E;
							when "10" => S <=  '0';
							when "01" => S <=  '1';
							when "11" => S <= '0';
							when others => S <= 'Z';
						end case;						
					end if;	
			else 
				S <=  'Z';	
			end if;
		end process;
end Behavioral;

