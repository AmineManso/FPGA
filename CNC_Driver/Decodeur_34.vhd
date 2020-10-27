library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Decodeur_34 is
port(  Din : in std_logic_vector(2 downto 0);
		Dout : out std_logic_vector(3 downto 0) 	);
end Decodeur_34;

architecture Behavioral of Decodeur_34 is

begin
	
	process(Din)
	begin
		case Din is
		when "000" => Dout <= "1010";
		when "001" => Dout <= "0010";
		when "010" => Dout <= "0110";
		when "011" => Dout <= "0100";
		when "100" => Dout <= "0101";
		when "101" => Dout <= "0001";
		when "110" => Dout <= "1001";
		when "111" => Dout <= "1000";
		when others => Dout <= "----";
		end case;
	end process;

end Behavioral;
