----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2023 10:38:36 AM
-- Design Name: 
-- Module Name: bcd - Behavioral
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;

entity bcd is
	port(clk	: in std_logic;
    	 reset	: in std_logic;
         data_in: in std_logic_vector(14 downto 0);
         bin_1  : out std_logic_vector(3 downto 0);
         bin_10 : out std_logic_vector(3 downto 0);
         bin_100: out std_logic_vector(3 downto 0);
         bin_1000: out std_logic_vector(3 downto 0));
end bcd;

architecture Behavioral of bcd is


signal dec_1 : integer ;
signal dec_10 : integer ;
signal dec_100 : integer ;
signal dec_1000 : integer ;
signal quotient : integer := 0;
signal reste : integer ;
signal count : integer := 0;



begin




process(clk)

    begin



if(clk'event and clk='1') then
	if(reset='1') then
    	dec_1 <= 0;
    	dec_10 <= 0;
    	dec_100 <= 0;
    	dec_1000 <= 0;
    	
        
    else
        if (count = 0) then
            reste <= to_integer(unsigned(data_in)) ;
            count <= count +1;
    
    	elsif(count = 1 or count = 3 or count = 2 or count = 4) then
    		if(reste>=10) then
        		reste <= reste - 10;
            	quotient <= quotient + 1;
        	else
        		if(count=1) then
        			dec_1 <= reste;
            	elsif(count=2) then
            		dec_10 <= reste;
            	elsif (count=3) then
            		dec_100 <= reste;
            	else 
            	   dec_1000 <= reste;
            	end if;
            	count <= count+1;
            	reste <= quotient;
            	quotient <= 0;
            end if;
        elsif (count = 5 ) then 
            count <= 0;
        end if;
    end if;
end if;
end process;

bin_1 <= std_logic_vector(to_unsigned(dec_1,4));
bin_10 <= std_logic_vector(to_unsigned(dec_10,4));
bin_100 <= std_logic_vector(to_unsigned(dec_100,4));
bin_1000 <= std_logic_vector(to_unsigned(dec_1000,4));

end Behavioral;


    	