library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;
------ Appel du Package:
use work.Driver_X_PACKAGE.ALL;
-----------------------------------------------------------------

entity Driver is
port( TP_x, clk_x : in std_logic;	
		Div_x : in std_logic_vector(1 downto 0);
		S_x, D_x, G_x : in std_logic;
		
		DriverOut : out std_logic_vector(3 downto 0)		);
end Driver;
----------------------------------------------------------------------

architecture Behavioral of Driver is
--------------------------------------------------- Declaration des Signaux:
	signal clk_inter: std_logic:= '0';
	signal S1 : std_logic_vector(1 downto 0):= "00";	
	signal S2 , S3, S5: std_logic_vector(3 downto 0):= "0000";
	signal S4 : std_logic_vector(2 downto 0):= "000";
----------------------------------------------------
begin
	
	u10: CD_Modulo4 port map(S_x, D_x, G_x, clk_inter, S1);
	u20: Decodeur_24 port map(S1, S2);
	
	u11: CD_Modulo8 port map(S_x, D_x, G_x, clk_inter, S4);
	u21: Decodeur_34 port map(S4, S5);
	
	u3: Mux_21 port map(S2, S5, TP_x, S3 );
	u4: Div_f port map('1', clk_x, Div_x, clk_inter);
	
	DriverOut <= S3;
-----------------------
end Behavioral;
-------------------------
