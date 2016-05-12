function [probability] = acceptance(rank_array,temperature)
  probability = exp(-rank_array(end)/temperature);
return;
