% Signature: sub(Sublist, List)/2
% Purpose: All elements in Sublist appear in List in the same order. 
% Precondition: List is fully instantiated (queries do not include variables in their first argument). 
% Example:
% ?- sub(X, [1, 2, 3]).
% X = [1, 2, 3];
% X = [1, 2];
% X = [1, 3];
% X = [2, 3];
% X = [1];
% X = [2];
% X = [3];
% X = [];
% false

sub([], []).
sub([X | L1],[X | L2]) :- sub(L1, L2).
sub(Sublist, [_ | List]) :-  sub(Sublist, List). 


    