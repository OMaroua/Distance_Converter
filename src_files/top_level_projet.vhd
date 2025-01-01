----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2023 09:37:35 AM
-- Design Name: 
-- Module Name: top_level_projet - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level_projet is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           sw1 : in std_logic; 
           sw2 : in std_logic;
           sw3 : in std_logic;
           pw : in std_logic;
           rx : out std_logic;
           septseg : out STD_LOGIC_VECTOR (6 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0));
          
end top_level_projet;

architecture Behavioral of top_level_projet is

signal s_feet, s_meter , distance_mux: STD_LOGIC_VECTOR (14 downto 0);
signal s_mili: STD_LOGIC_VECTOR (14 downto 0);
signal load : STD_LOGIC_VECTOR (1 downto 0);
signal s_ce : std_logic;
signal s_rx :std_logic;
signal signal_capteur :STD_LOGIC_VECTOR (7 downto 0);
signal ones, tens, cents, mili : std_logic_vector(3 downto 0);
signal seg_ones, seg_tens, seg_cents,seg_milli : std_logic_vector(6 downto 0);

component bcd is
	port(clk	: in std_logic;
    	 reset	: in std_logic;
         data_in: in std_logic_vector(14 downto 0);
         bin_1  : out std_logic_vector(3 downto 0);
         bin_10 : out std_logic_vector(3 downto 0);
         bin_100: out std_logic_vector(3 downto 0);
         bin_1000 : out std_logic_vector(3 downto 0));
end component;

component Conver_rapido is
--component Convertisseur is
 Port ( clk : in STD_LOGIC;
         rst : in STD_LOGIC ; 
         distance_in : in STD_LOGIC_VECTOR (7 downto 0); 
         dist_feet : out STD_LOGIC_VECTOR (14 downto 0); 
         dist_centi : out STD_LOGIC_VECTOR (14 downto 0);
         dist_mili: out STD_LOGIC_VECTOR (14 downto 0)); 
end component; 

component controleur_7_seg is
    Port ( 
           clk : in STD_LOGIC;
           uni : in STD_LOGIC_VECTOR (6 downto 0);
           diz : in STD_LOGIC_VECTOR (6 downto 0);
           cent : in STD_LOGIC_VECTOR (6 downto 0);
           mili : in STD_LOGIC_VECTOR (6 downto 0);
           rst : in STD_LOGIC;
           
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component pmod_SONAR_ctrl is
    Port ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           pw       : in  STD_LOGIC;
           rx       : out STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component transcodeur is
    Port ( digit : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component FSM is
    Port ( S_meter : in STD_LOGIC;
           S_feet : in STD_LOGIC;
           s_mili : in STD_LOGIC;
           clk : in std_logic; 
           rst : in std_logic; 
           load : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component Mux is
    Port ( clk : in std_logic;
            rst : in std_logic;
            meter : in STD_LOGIC_VECTOR (14 downto 0);
           inch : in STD_LOGIC_VECTOR (7 downto 0);
           feet : in STD_LOGIC_VECTOR (14 downto 0);
           mili : in STD_LOGIC_VECTOR (14 downto 0);
           load : in std_logic_vector (1 downto 0);
           distance : out STD_LOGIC_VECTOR (14 downto 0));
end component;

component gestion_freq is
    Port ( clk : in STD_LOGIC;
           rst : in std_logic;
           ce : out STD_LOGIC);
end component;

begin


           
sonar : pmod_SONAR_ctrl Port map(
    clk => clk,
    reset => rst,
    pw => pw,
    rx => s_rx,
    data_out => signal_capteur);

FSM_pp : FSM Port map(
    s_meter => sw1,
    s_feet => sw2,
    s_mili => sw3,
    clk => clk,
    rst => rst,
    load => load);
    
--convert : Convertisseur port map(
convert : Conver_rapido port map(
    clk => clk,
    rst => rst,
    distance_in => signal_capteur,
    dist_feet => s_feet,
    dist_mili => s_mili,
    dist_centi => s_meter);
    

multiplex: Mux Port map ( 
           clk	=> clk,
    	 rst	=> rst, 
           meter => s_meter,
           inch => signal_capteur,
           feet =>  s_feet ,
           mili => s_mili,
           load => load ,
           distance => distance_mux );

bcdd: bcd 
	port map (clk	=> clk,
    	 reset	=> rst,
         data_in => distance_mux,
         bin_1  => ones,
         bin_10 => tens ,
         bin_100 => cents,
         bin_1000 => mili );

transcodeur_ones : transcodeur
    Port map ( digit => ones,
                seg => seg_ones);
        
transcodeur_tens : transcodeur
    Port map ( digit => tens,
                seg => seg_tens);
 
transcodeur_cents : transcodeur
    Port map ( digit => cents,
                seg => seg_cents);
transcodeur_mili : transcodeur
    Port map ( digit => mili,
                seg => seg_milli);      
gest :gestion_freq 
    Port map ( clk => clk,
           rst => rst,
           ce => s_ce);             
 
                
display : controleur_7_seg 
    Port map ( 
           clk => s_ce,
           uni => seg_ones,
           diz => seg_tens,
           cent => seg_cents,
           mili => seg_milli,
           rst => rst,
           
           seg => septseg,
           AN  => AN );



end Behavioral;
