-- 4 bit counter

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity counter is
    port (
        reset: in std_logic;
        clk: in std_logic;
        en: in std_logic;
        load: in std_logic;
        d_in: in std_logic_vector (3 downto 0);
        q_out: out std_logic_vector (3 downto 0)
        );
end counter;

----realizacija preko signala
--architecture Behavioral of counter is
--    signal q_reg: std_logic_vector (3 downto 0);
--begin
--    process (clk, reset) is
--    begin
--        if (reset = '1') then
--            q_reg <= (others => '0');
--        elsif (rising_edge (clk)) then
--            if (en = '1') then
--                if (load = '1') then
--                    q_reg <= d_in ;
--                else
--                    q_reg <= std_logic_vector(unsigned(q_reg) + 1);
--                end if;
--            end if;
--        end if;
--    end process;
    
--    q_out <= q_reg ;
--end Behavioral;

--realizacija preko prirodnih brojeva; moguce imati 2 arhitekture preko konfiguracije
architecture Behavioral_natural of counter is

    constant MAX_CNT_VALUE : natural := 2**4-1;
    signal q_cnt: natural range 0 to MAX_CNT_VALUE;
    
begin
    process (clk, reset) is
    begin
        if (reset = '1') then
            q_cnt <= 0;
        elsif (rising_edge (clk)) then
            if (en = '1') then
                if(load ='1') then
                    q_cnt <= to_integer (unsigned(d_in));
                else 
                    if(q_cnt < MAX_CNT_VALUE ) then
                        q_cnt <= q_cnt + 1;
                    else
                        q_cnt <= 0;
                    end if;
                end if;
             end if;
        end if;
    end process;
    
    q_out <= std_logic_vector(to_unsigned(q_cnt, q_out'length));
end Behavioral_natural;
