----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2023 10:46:56 AM
-- Design Name: 
-- Module Name: Mux - Behavioral
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

entity Mux is
    Port ( 
            clk : in std_logic;
            rst : in std_logic;
            meter : in STD_LOGIC_VECTOR (14 downto 0);
           inch : in STD_LOGIC_VECTOR (7 downto 0);
           feet : in STD_LOGIC_VECTOR (14 downto 0);
           mili : in STD_LOGIC_VECTOR (14 downto 0);
           load : in std_logic_vector (1 downto 0);
           distance : out STD_LOGIC_VECTOR (14 downto 0));
end Mux;

architecture Behavioral of Mux is

begin
process(load,clk)
    begin
        case load is
            when "00" =>
                distance <= "0000000" & inch;
            when "01" =>
                distance <= meter;
            when "10" =>
                distance <= feet;
            when "11" =>
                distance <= mili;
            when others =>
                distance <= inch;
        end case;
    end process;

end Behavioral;
