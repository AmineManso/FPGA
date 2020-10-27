library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux_21 is
port( Din_1, Din_2 : in std_logic_vector(3 downto 0);
		TypePas : in std_logic;
	  Dout : out std_logic_vector(3 downto 0)
			);
end Mux_21;

architecture Behavioral of Mux_21 is

begin
	Dout <= Din_1 when TypePas = '0' else Din_2;
	
------------------------	------- methode 2:
--	process(TypePas, Din_1, Din_2)
--	begin 
--		case TypePas is
--			when '0' => Dout <= Din_1;
--			when '1' => Dout <= Din_2;
--			
--			when others => Dout <= "----";
--		end case;
--	end process;


end Behavioral;

