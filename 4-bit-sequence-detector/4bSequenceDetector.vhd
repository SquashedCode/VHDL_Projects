LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
ENTITY dct0093_LB5 IS
   PORT (Clock, Reset, w   : IN STD_LOGIC;
                       v   : IN STD_LOGIC_VECTOR(3 downto 0);
						     z   : OUT STD_LOGIC);
END dct0093_LB5;

ARCHITECTURE BEHAVIORAL OF dct0093_LB5 IS
   TYPE State_type IS (A, B, C, D, E); -- Declare different states
   SIGNAL y: State_type; -- Declare state variable y
BEGIN
   PROCESS(Clock, Reset) -- async reset included in sensitivity list
   VARIABLE new_z : STD_LOGIC; -- Variable to update z in correct cycle
   BEGIN
      IF Reset = '0' THEN y <= A; z <= '0'; -- asynchronous active low reset
      ELSIF rising_edge(Clock) THEN -- Rising edge of clock
         new_z := '0'; -- Set new_z to 0 each iteration
         CASE y IS -- Evaluate y's current state
            WHEN A=>
               IF v(3) = w THEN y <= B; -- If w is MSB of sequence, proceed to state B
               END IF;
            WHEN B=>
               IF v(2) = w THEN y <= C; -- If w is bit #2 of sequence, proceed to state C
               ELSIF v(3) = w THEN y <= B; --  If w is MSB of sequence, jump to state B
               ELSE y <=A; END IF; -- If neither are true, go back to state A
            WHEN C=>
               IF v(1) = w THEN y <= D; -- If w is bit #3 of sequence, proceed to state D
               ELSIF v(3) = w THEN y <= B; -- If w is MSB of sequence, jump to state B
               ELSE y <= A; END IF; -- If neither are true, go back to state A
            WHEN D=>
               IF v(0) = w THEN y <= E; -- If w is LSB of sequence, proceed to state E
                  new_z := '1'; -- set output to 1 on transition from D->E
               ELSIF v(3) = w THEN y <= B; -- If w is MSB of sequence, jump to state B
               ELSE y<= A; END IF; -- If neither are true, go back to state A
            WHEN E=>
               IF v(3) = w THEN y <= B; -- if w is first bit of sequence, proceed to B
               ELSE y <= A; END IF; -- else, go back to start and wait for new sequence
           WHEN OTHERS => y <= A; new_z := '0'; -- if y enters unknown state
         END CASE;
         z <= new_z; -- update output with predicted state change to keep 1 clock cycle
      END IF;
   END PROCESS;
END BEHAVIORAL;
