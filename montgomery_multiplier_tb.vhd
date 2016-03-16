-- Entity name: montgomery_multiplier_tb
-- Author: Stephen Carter
-- Contact: stephen.carter@mail.mcgill.ca
-- Date: March 8th, 2015
-- Description:

library ieee;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
--use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity montgomery_multiplier_tb is
end entity;

architecture test of montgomery_multiplier_tb is
-- define the ALU compontent to be tested
Component montgomery_multiplier is
 	Generic(
		WIDTH_IN : integer := 8
	);
	Port(	A :	in unsigned(WIDTH_IN-1 downto 0);
		B :	in unsigned(WIDTH_IN-1 downto 0);
		N :	in unsigned(WIDTH_IN-1 downto 0);
		latch : in std_logic;
		clk :	in std_logic;
		reset :	in std_logic;
		M : 	out unsigned(WIDTH_IN-1 downto 0)
	);
end component;

CONSTANT WIDTH_IN : integer := 8;

CONSTANT clk_period : time := 1 ns;

Signal N_in : unsigned(WIDTH_IN-1 downto 0) := (others => '0');
Signal A_in : unsigned(WIDTH_IN-1 downto 0) := (others => '0');
Signal B_in : unsigned(WIDTH_IN-1 downto 0) := (others => '0');

Signal clk : std_logic := '0';
Signal reset_t : std_logic := '0';
Signal latch_in : std_logic := '0';

Signal M_out : unsigned(WIDTH_IN-1 downto 0) := (others => '0');

CONSTANT NUM_12 : unsigned(WIDTH_IN-1 downto 0) := "00001100";
CONSTANT NUM_2	: unsigned(WIDTH_IN-1 downto 0) :=  "00000010";
CONSTANT N_5	: unsigned(WIDTH_IN-1 downto 0) :=  "00000101";


Begin
-- device under test
dut: montgomery_multiplier PORT MAP(	A	=> 	A_in,
					B 	=> 	B_in,
					N 	=> 	N_in,
					latch	=>	latch_in,
					clk	=> 	clk,
					reset 	=>	reset_t,
					M	=>	M_out);
  
-- process for clock
clk_process : Process
Begin
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
end process;

stim_process: process
Begin


	reset_t <= '1';
	wait for 1 * clk_period;
	reset_t <= '0';
	wait for 1 * clk_period;

	
	REPORT "begin test case for A=2, B=4, N=7";
	REPORT "expected output is 1 00000001";
	A_in <= NUM_2;
	B_in <= "00000100";
	N_in <= "00000111";
	latch_in <= '1';
	wait for 2 * clk_period;
	latch_in <= '0';
	wait for 8 * clk_period;
	ASSERT(M_out = "00000001") REPORT "test failed" SEVERITY ERROR;

	REPORT "begin test case for A=12, B=2, N=5";
	REPORT "expected output is 4 00000100";
	A_in <= NUM_12;
	B_in <= NUM_2;
	N_in <= N_5;
	latch_in <= '1';
	wait for 2 * clk_period;
	latch_in <= '0';
	wait for 8 * clk_period;
	ASSERT(M_out = "0000100") REPORT "test failed" SEVERITY ERROR;

	REPORT "begin test case for A=12, B=19, N=31";
	REPORT "expected output is 11 00001011";
	A_in <= NUM_12;
	B_in <= "00010011";
	N_in <= "00011111";
	latch_in <= '1';
	wait for 2 * clk_period;
	latch_in <= '0';
	wait for 8 * clk_period;
	ASSERT(M_out = "00001011") REPORT "test failed" SEVERITY ERROR;

	REPORT "begin test case for A=18, B=10, N=7";
	REPORT "expected output is 5 00000101";
	A_in <= "00010010";
	B_in <= "00001010";
	N_in <= "00000111";
	latch_in <= '1';
	wait for 2 * clk_period;
	latch_in <= '0';
	wait for 8 * clk_period;
	ASSERT(M_out = "0000101") REPORT "test failed" SEVERITY ERROR;

	REPORT "begin test case for A=246, B=231, N=213";
	REPORT "expected output is 168 10101000";
	A_in <= "11110110";
	B_in <= "11100111";
	N_in <= "11010101";
	latch_in <= '1';
	wait for 2 * clk_period;
	latch_in <= '0';
	wait for 8 * clk_period;
	ASSERT(M_out = "10101000") REPORT "test failed" SEVERITY ERROR;

	REPORT "begin test case for A=126, B=94, N=33";
	REPORT "expected output is 30 00001110";
	A_in <= "01111110";
	B_in <= "01011110";
	N_in <= "00100001";
	latch_in <= '1';
	wait for 2 * clk_period;
	latch_in <= '0';
	wait for 8 * clk_period;
	ASSERT(M_out = "00011110") REPORT "test failed" SEVERITY ERROR;

	REPORT "begin test case for A=74, B=73, N=75";
	REPORT "expected output is 2 00000010";
	A_in <= "01001010";
	B_in <= "01001001";
	--N_in <= "01001011";
	N_in <= "00000111";
	latch_in <= '1';
	wait for 2 * clk_period;
	latch_in <= '0';
	wait for 8 * clk_period;
	ASSERT(M_out = "00000010") REPORT "test failed" SEVERITY ERROR;

	wait;

end process;
end architecture;