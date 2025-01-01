----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2023 03:10:06 PM
-- Design Name: 
-- Module Name: transcodeur - Behavioral
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

entity transcodeur is
    Port ( digit : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
end transcodeur;

architecture Behavioral of transcodeur is
signal s_seg : std_logic_vector(6 downto 0);

begin
trans : process(digit, s_seg)
begin 
if (digit = "0000") then
    s_seg <= "1000000";
elsif (digit = "0001") then
    s_seg <= "1111001";
elsif (digit = "0010") then
    s_seg <= "0100100";
elsif (digit = "0011") then
    s_seg <= "0110000";
elsif (digit = "0100") then
    s_seg <= "0011001";
elsif (digit = "0101") then
    s_seg <= "0010010";
elsif (digit = "0110") then
    s_seg <= "0000010";
elsif (digit = "0111") then
    s_seg <= "1111000";
elsif( digit = "1000") then
    s_seg <= "0000000";
elsif( digit = "1001") then
    s_seg <= "0010000";
    end if;
 end process trans; 
seg <=STD_LOGIC_VECTOR (s_seg);


end Behavioral;