library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_41 is
port( Din : in std_logic_vector(3 downto 0);
		sel : in std_logic_vector(1 downto 0);
	  Dout : out std_logic
			);
end Mux_41;

architecture Behavioral of Mux_41 is

begin
	
	process(sel, Din)
	begin 
		case sel is
			when "00" => Dout <= Din(0);
			when "01" => Dout <= Din(1);
			when "10" => Dout <= Din(2);
			when "11" => Dout <= Din(3);
			when others => Dout <= '-';
		end case;
	end process;

end Behavioral;

