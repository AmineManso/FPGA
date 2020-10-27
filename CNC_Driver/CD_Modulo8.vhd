library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;


entity CD_Modulo8 is
port(S, D, G, clk: in std_logic;
		Dout :out std_logic_vector(2 downto 0)		);
end CD_Modulo8;

architecture Behavioral of CD_Modulo8 is
	SIGNAL  cmp : std_logic_vector(2 downto 0):="000";
begin
-------------------------
	process(clk, S, D, G, cmp)
	begin
		if(rising_edge(clk)) then 
			if(S = '1' and D = '0')then cmp <= cmp + 1;
			elsif(S = '0' and G = '0') then cmp <= cmp - 1;
			end if;
		end if;
		Dout <= cmp;
	end process;

--------------------------
end Behavioral;

