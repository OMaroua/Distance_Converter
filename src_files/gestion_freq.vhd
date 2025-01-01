----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2023 11:01:44 AM
-- Design Name: 
-- Module Name: gestion_freq - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_freq is
    Port ( clk : in STD_LOGIC;
           rst : in std_logic;
           ce : out STD_LOGIC);
end gestion_freq;

architecture Behavioral of gestion_freq is

signal s_countce : unsigned (15 downto 0) ;
begin

counter : process(RST,clk)
begin 
    if (clk'event and clk='1' ) then
          s_countce <= s_countce +1;
          if ( rst = '1') then 
            s_countce <= (others => '0');
        elsif (s_countce ="1000001000110101") then
            ce <= '1';
            s_countce <= "0000000000000000";
        else 
            ce <= '0';
        end if;
    end if;
    end process;
    
 
    
end Behavioral;
