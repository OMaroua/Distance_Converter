library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity conver_rapido is
    Port ( clk         : in  STD_LOGIC;
           rst         : in  STD_LOGIC ; 
           distance_in : in  STD_LOGIC_VECTOR (7 downto 0); 
           dist_feet   : out STD_LOGIC_VECTOR (14 downto 0); 
           dist_centi  : out STD_LOGIC_VECTOR (14 downto 0); 
           dist_mili   : out STD_LOGIC_VECTOR (14 downto 0));
end conver_rapido; 

architecture Behavioral of conver_rapido is
    signal s_distance_in : integer range 0 to 255; -- 8-bit input max value is 255
    signal s_dist_feet   : integer range 0 to 255; -- Assuming the input range is enough
    signal s_dist_centi  : integer range 0 to 2550; -- For 254 * input
    signal s_dist_mili   : integer range 0 to 25500; -- For 2540 * input
    
    signal tmp1 : integer range 0 to 2550;
    signal tmp2 : integer range 0 to 2550;
    signal tmp3 : integer range 0 to 2550;
    signal tmp4 : integer range 0 to 2550;
    
    constant period : time := 10 ns;

begin

 process (clk)
    begin
        if rising_edge(clk) then
         
            s_distance_in <= TO_INTEGER(unsigned(distance_in));
        
            -- Division by 12 can be approximated by a combination of shifts (division by powers of 2) and subtracts
            s_dist_feet <= (s_distance_in / 2) - (s_distance_in / 8) - (s_distance_in / 32);
        
            -- Multiplication by 254 can be broken down into shifts and adds
            -- s_distance_in * 254 is equivalent to s_distance_in * (256 - 2) = (s_distance_in << 8) - (s_distance_in << 1)
            --s_dist_centi <= (s_distance_in * 256 / 100) - (s_distance_in * 2 / 100);
            tmp1 <= s_distance_in * 256 / 10;
            tmp2 <= tmp1/10;
            tmp3 <= s_distance_in * 2 / 10;
            tmp4 <= tmp3/10;
            
            s_dist_centi <= tmp2 - tmp4;
            
            
            s_dist_mili <= (s_distance_in * 256 / 10) - (s_distance_in * 2 / 10);        
             
             
            end if;

    end process;
    
            

  
    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                dist_feet <= (others => '0');
                dist_centi <= (others => '0');
                dist_mili <= (others => '0');
            else
                                
             
                dist_feet <= std_logic_vector(to_unsigned(s_dist_feet, 15));
                dist_centi <= std_logic_vector(to_unsigned(s_dist_centi, 15));
                dist_mili <= std_logic_vector(to_unsigned(s_dist_mili, 15));

            end if;
        end if;
    end process;

end Behavioral;
