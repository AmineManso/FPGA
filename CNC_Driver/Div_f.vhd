library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Div_f is 
port( Tin, clk : in std_logic;
		Div : in std_logic_vector(1 downto 0);
		Qout : out std_logic 
);
end Div_f;

architecture Behavioral of Div_f is
	-----------------------------------
	component FF_T is
		port(T, clk: in std_logic;
					Q : out std_logic);
	end component;
	
	component Mux_41 is
	port( Din : in std_logic_vector(3 downto 0);
			sel : in std_logic_vector(1 downto 0);
		  Dout : out std_logic    );
	end component;
	-----------------------------------
	signal H2, H4, H8: std_logic :='0'; 
	signal Horloges : std_logic_vector(3 downto 0):= "0000";

begin
	
	D1: FF_T port map(Tin, clk, H2);
	D2: FF_T port map(Tin, H2, H4);
	D3: FF_T port map(Tin, H4, H8);
	
	Horloges <= H8&H4&H2&clk;
	M: Mux_41 port map(Horloges, Div, Qout);
	

end Behavioral;

