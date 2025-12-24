# Advent_of_Code-2025

This repository consists of my code solutions for **DAY 3 (p1) & DAY 5 (p1 & p2)** in **verilog** along with the respective testbenches, input memh files, memh generator code in **python**
It also contains screenshots of the tested outputs on EDA Playground.

---
## My reasoning 

### DAY 3 (P1) :
The requirement was to find the maximum "joltage" i.e. from a set of lines of batteries with ratings 0-9, we have to pick the maximum 2 values that appear in order and join them. eg: 8756419 would give 8 and 9 so max rating for that line is 89 and similarly for 200 such lines with 100 such batteries. Sum of all the ratings will give max "joltage"
*Logic* : Keep a track of the two max values while going through the line **once** and note their indexes as well. Arrange according to indexes and join. Repeat for the other lines and keep adding the value to the current joltage.


### DAY 5 (P1) :
The requirement was to find out whether a list of 1000 given ingredients (each with independent ingredient IDs) are fresh or stale based on whether they lie in a given set of 186 ingredient ID ranges. 
*Logic* : I used separate memh files for the items, start values of each range and end values of each range to avoid creating registers for such large data. The temporary registers store the current range based on range index and current item, compare and if it lies in the range, a count register is incremented and the range index is set to 0. If not, range index is incremented till the input is exhausted. If none of the ranges are met, then item is incremented and range is reset, till all items are checked.

### DAY 5 (P2) :
The requirement was to find out the number of ingredients that lie in all the ranges combined i.e. in the union of all the given ranges.
*Logic* : Used a sorted version of the input ranges to find the union comfortably. The sorting was done in **python**. The **verilog** code compared the values of the start and end of a range with the next one to see if they overlapped. If say the next end value is larger than the previous and the next start value is smaller than the previous, then current start and end value registers are updated with the next values, else not. The number of ingredients are (current end - current start + 1). For non overlapping ranges, the number of ingredients are added as is.

---

### Screenshots of tested outputs and output waveforms can be seen in the folder 'Output'

### Note:
Verilog and testbenches are written by me, however the memh generator code is done with some help of AI tools, since I'm not very fluent in **python**.

Thank you for reading!