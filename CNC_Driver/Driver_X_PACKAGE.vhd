library IEEE;
use IEEE.STD_LOGIC_1164.all;

package Driver_X_PACKAGE is


-----------------------------------------------------Package:
	component CD_Modulo4 is
	port(S, D, G, clk: in std_logic;
			Dout :out std_logic_vector(1 downto 0)		);
	end component;
	----------------------
	component Decodeur_24 is
	port(  Din : in std_logic_vector(1 downto 0);
			Dout : out std_logic_vector(3 downto 0) 	);
	end component;
	----------------------
	component Div_f is 
	port( Tin, clk : in std_logic;
			Div : in std_logic_vector(1 downto 0);
			Qout : out std_logic 
	);
	end component;
	----------------------
	component Mux_21 is
	port( Din_1, Din_2 : in std_logic_vector(3 downto 0);
			TypePas : in std_logic;
		  Dout : out std_logic_vector(3 downto 0)
				);
	end component;
	------------------------
	component CD_Modulo8 is
	port(S, D, G, clk: in std_logic;
			Dout :out std_logic_vector(2 downto 0)		);
	end component;
	------------------------
	component Decodeur_34 is
	port(  Din : in std_logic_vector(2 downto 0);
			Dout : out std_logic_vector(3 downto 0) 	);
	end component;
-----------------------------------------------------



end Driver_X_PACKAGE;


