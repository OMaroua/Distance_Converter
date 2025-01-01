----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2023 02:15:09 PM
-- Design Name: 
-- Module Name: controleur_7_seg - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
entity controleur_7_seg is
    Port ( 
           clk : in STD_LOGIC;
           uni : in STD_LOGIC_VECTOR (6 downto 0);
           diz : in STD_LOGIC_VECTOR (6 downto 0);
           cent : in STD_LOGIC_VECTOR (6 downto 0);
           mili : in STD_LOGIC_VECTOR (6 downto 0);
           rst : in STD_LOGIC;
           
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end controleur_7_seg;
architecture Behavioral of controleur_7_seg is


signal count: unsigned(3 downto 0):= (others => '0');


begin
counter : process (clk , rst)

 begin
 
    if (rising_edge(clk)) then 
     if (rst = '1' or count = 4) then

                count <= (others => '0');
                
            else
               count <= count + 1;
                
            end if;
        end if;
    end process;
    
 segment : process(count,rst,clk)
 begin
    if (count=1) then
            seg <= mili;
        elsif (count=2) then
            seg <= cent;
        elsif (count=3) then
            seg <= diz;
        elsif (count=4) then
            seg <= uni;
        end if;
  end process segment;
  active : process( count,rst,clk)
  begin      
        if (count=1) then
                AN <= "11110111";
            elsif (count=2) then
                AN <= "11111011";
            elsif (count=3) then
                AN <= "11111101";
            elsif (count=4) then
                AN <= "11111110";
            end if;
        
 end process active;
end Behavioral;