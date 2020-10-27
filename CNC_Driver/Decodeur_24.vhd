library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Decodeur_24 is
port(  Din : in std_logic_vector(1 downto 0);
		Dout : out std_logic_vector(3 downto 0) 	);
end Decodeur_24;

architecture Behavioral of Decodeur_24 is

begin
	
	process(Din)
	begin
		case Din is
		when "00" => Dout <= "1010";
		when "01" => Dout <= "0110";
		when "10" => Dout <= "0101";
		when "11" => Dout <= "1001";
		when others => Dout <= "----";
		end case;
	end process;


end Behavioral;

