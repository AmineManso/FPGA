library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------
entity registreX8 is
	port(	E : in std_logic_vector(7 downto 0);
			clk : in std_logic;
			clkEnable : in std_logic;
			set : in std_logic;
			reset: in std_logic;
			S : out std_logic_vector(7 downto 0)
			);
end registreX8;
-------------------------------------------------------
architecture Behavioral of registreX8 is
  signal RS: std_logic_vector(1 downto 0); 
begin
	RS <= reset & set ;
	
		process(clk,clkEnable)
		begin 
		
			if (clkEnable = '1') then 
					if (clk='1' and clk'event) then 
						case RS is 
							when "00" => S <= E;
							when "10" => S <= (others => '0');
							when "01" => S <= (others => '1');
							when "11" => S <= (others => '0');
							when others => S <= (others => 'Z');
						end case;	
					end if;	
			else 
				S <= (others => 'Z');	
			end if;
			
		end process;
end Behavioral;

