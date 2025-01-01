 ----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2023 10:57:42 AM
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
    Port ( S_meter : in STD_LOGIC;
           S_feet : in STD_LOGIC;
           S_mili : in std_logic;
           clk : in std_logic; 
           rst : in std_logic; 
           load : out STD_LOGIC_VECTOR (1 downto 0));
end FSM;

architecture Behavioral of FSM is
TYPE STATE_TYPE IS (init, meter_state, feet_state,mili_state);
signal current_state : state_type;
signal next_state : state_type;
begin

futur : process(current_state, S_meter , S_feet,s_mili)
        begin
        case current_state is 
            
            when init => 
                if s_meter = '1' and s_feet ='0' and s_mili = '0' then
                    next_state <= meter_state;
                elsif  s_meter = '0' and s_feet ='1' and s_mili = '0' then
                    next_state <= feet_state;
                elsif s_meter = '0' and s_feet ='0' and s_mili = '1' then
                    next_state <= mili_state;
                else 
                    next_state <= init;
                end if;
                
            when meter_state => 
                if s_meter = '0' and s_feet ='0' and s_mili = '0' then
                    next_state <= init;
                else 
                    next_state <= meter_state;
                end if;
                
            when feet_state => 
                if s_meter = '0' and s_feet ='0' and s_mili = '0' then
                    next_state <= init;
                else 
                    next_state <= feet_state;
                end if;
                 when mili_state => 
                if s_meter = '0' and s_feet ='0' and s_mili = '0' then
                    next_state <= init;
                else 
                    next_state <= mili_state;
                end if;
                
                
            when others => 
                next_state <= init;
              
              
       end case;
    end process;
    
    
 present : process(clk)
            begin 
            
            if(clk'event and clk= '1') then
                if (rst = '1') then
                    current_state <= init;
                else 
                    current_state <= next_state;
                end if;
           end if;
           
           end process;
 
 calcul_sorties : process (current_state)
                begin
                
                case current_state is     
                
                    when init => load <= "00";
                    when meter_state => load <= "01";
                    when feet_state => load <= "10";
                    when mili_state => load <= "11";
                    
                end case;
                end process;

end Behavioral;
