LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;

ENTITY dct0093_LB5_tb is
END dct0093_LB5_tb;

ARCHITECTURE behavioral OF dct0093_LB5_tb IS

COMPONENT dct0093_LB5
PORT (Clock, Reset, w : IN STD_LOGIC;
                    v : IN STD_LOGIC_VECTOR(3 downto 0);
                    z : OUT STD_LOGIC
);
END COMPONENT;

SIGNAL clock_in, reset_in : STD_LOGIC;
SIGNAL w_in : STD_LOGIC;
SIGNAL v_in : STD_LOGIC_VECTOR(3 downto 0); 
SIGNAL z_out : STD_LOGIC := '0';

BEGIN
UUT: dct0093_LB5 PORT MAP(
        Clock => clock_in,
        Reset => reset_in,
        w => w_in,
        v => v_in,
        z => z_out
);

-- *** Test Bench - User Defined Section ***
clock_proc : PROCESS 
-- Process for generating clock signal to keep test cases code simpler
   variable cycle_count : integer := 0;
BEGIN
    WHILE cycle_count < 192 LOOP -- 32 test cases * 5 bits + 32 reset cycles = 192 clock cycles
        clock_in <= '1'; wait for 5 ms; clock_in <= '0'; wait for 5 ms;
        cycle_count := cycle_count + 1;
    END LOOP;
END PROCESS;

test_cases : PROCESS
BEGIN
reset_in <= '1'; -- set reset to 1 by default
-- Test Cases (32 total) 1 correct, 1 incorrect for each sequence of v
-- TESTCASE #1 v = 0000
    v_in <= "0000";
    -- correct sequence (testing w = 00000)
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
    
    -- incorrect sequence (testing w = 00100)
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- TESTCASE #2 v = 0001
    v_in <= "0001";
    
    -- correct sequence (testing w = 00010)
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
    -- incorrect sequence (testing w = 00110)
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #3 v = 0010
    v_in <= "0010";
    -- correct sequence (testing w = 00100)
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
        reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
    -- incorrect sequence (testing w = 00110)
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
        reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #4 v = 0011
    v_in <= "0011";
    -- correct sequence (testing w = 00100)
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
    -- incorrect sequence (testing w = 00100)
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #5 v = 0100
    v_in <= "0100";
-- correct sequence (testing w = 01000)
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- incorrect sequence (testing w = 01100)
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #6 v = 0101
    v_in <= "0101";
-- correct sequence (testing w = 01010)
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- incorrect sequence (testing w = 01110)
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- TESTCASE #7 v = 0110
    v_in <= "0110";
-- correct sequence (testing w = 01100)
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- incorrect sequence (testing w = 01000)
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #8 v = 0111
    v_in <= "0111";
-- correct sequence (testing w = 01110)
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- incorrect sequence (testing w = 01010)
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #9 v = 1000
    v_in <= "1000";
-- correct sequence (testing w = 10000)
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- incorrect sequence (testing w = 10100)
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #10 v = 1001
    v_in <= "1001";
-- correct sequence (testing w = 10010)
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- incorrect sequence (testing w = 10110)
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #11 v = 1010
    v_in <= "1010";
-- correct sequence (testing w = 10100)
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- incorrect sequence (testing w = 10000)
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #12 v = 1011
    v_in <= "1011";
-- correct sequence (testing w = 10110)
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- incorrect sequence (testing w = 10010)
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #13 v = 1100
    v_in <= "1100";
-- correct sequence (testing w = 11000)
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- incorrect sequence (testing w = 11100)
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #14 v = 1101
    v_in <= "1101";
-- correct sequence (testing w = 11010)
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- incorrect sequence (testing w = 11110)
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #15 v = 1110
    v_in <= "1110";
-- correct sequence (testing w = 11100)
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- incorrect sequence (testing w = 11000)
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '0'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;

-- TESTCASE #16 v = 1111
    v_in <= "1111";
-- correct sequence (testing w = 11110)
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
-- incorrect sequence (testing w = 11010)
    w_in <= '1'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms; w_in <= '1'; wait for 10 ms;
    w_in <= '0'; wait for 10 ms;
    reset_in <= '0'; wait for 5 ms; reset_in <='1'; wait for 5 ms;
WAIT; -- will wait forever

END PROCESS;
-- *** End Test Bench - User Defined Section ***
END behavioral;
