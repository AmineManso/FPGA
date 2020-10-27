library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Driver_XYZ is
port(	TP_1, TP_2, TP_3: in std_logic;	
		clk: in std_logic;	
		Div_1, Div_2, Div_3: in std_logic_vector(1 downto 0);
		S_1, S_2, S_3:in std_logic;
		D_1, D_2, D_3:in std_logic;
		G_1, G_2, G_3:in std_logic;
		
		Driver_XYZ_out:out std_logic_vector(11 downto 0)		
		);
end Driver_XYZ;

architecture Behavioral of Driver_XYZ is
--------------------------------------------------Package
	component Driver is
	port( TP_x, clk_x : in std_logic;	
			Div_x : in std_logic_vector(1 downto 0);
			S_x, D_x, G_x : in std_logic;
			
			DriverOut : out std_logic_vector(3 downto 0)		);
	end component;
--------------------------------------------------Fin Package

begin

   D1 : Driver port map(TP_1, clk, Div_1, S_1, D_1, G_1, Driver_XYZ_out(3 downto 0));
	D2 : Driver port map(TP_2, clk, Div_2, S_2, D_2, G_2, Driver_XYZ_out(7 downto 4));
	D3 : Driver port map(TP_3, clk, Div_3, S_3, D_3, G_3, Driver_XYZ_out(11 downto 8));

end Behavioral;

