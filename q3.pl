/*
 * **********************************************
 * aux predicates (see ex5-aux.pl documentation)
 * **********************************************
 */
:- use_module('ex5-aux').

/*
 * **********************************************
 * Question 3:
 * 
 * A relational database for Wikipedia management.
 * 
 * The database contains the tables: page, namespaces,
 * category and categorylinks.
 * **********************************************
 */

% Signature: page_in_category(PageName, CategoryId)/2
% Purpose: Relation between a page name and a category id,
%          so that the page is included in the category.
%          and the category is not hidden.


% Examples:
% ?- page_in_category(cnn, X).
% X = 786983;
% X = 786983
%
% ?- page_in_category(X, 564677).
% X = ocpc;
% X = nbc.
%
% ?- page_in_category(metropolitan, X).
% false.
%


page_in_category(PName, CatId) :- page(X, _, PName, Z),
	categorylinks(X, Y), category(CatId, Y, false).

% Signature: splitter_category(CategoryId)/1
% Purpose: A category that has at least two pages.
%          Multiple right answers may be given.
%

% Examples:
% ?- splitter_category(689969).
% true.
%
% ?- splitter_category(564677).
% true.
%
% ?- splitter_category(858585).
% false.
%

splitter_category(CatId) :- page_in_category(X, CatId),
	page_in_category(Y, CatId), not_member(X, [Y]).

% Signature: namespace_list(NamespaceName, PageList)/2
% Purpose: PageList includes all the pages in namespace NamespaceName.
%          The order of list elements is irrelevant.

% Examples:
% ?- namespace_list(article, X).
% X = [558585, 689695, 858585].
%

searching_for_more(Q1, Q2, Q3) :- Q1, Q2, Q3.

done_searching(Q1, Q2, Q3) :- \+searching_for_more(Q1, Q2, Q3).

namespace_list(Name, L) :- inner_namespace_list(Name, L, []).

inner_namespace_list(Name, [], L3) :- done_searching(namespaces(Y, Name), page(X, Y, _, E), not_member(X, L3)).
inner_namespace_list(Name, [X | L2], L1) :- in_namespace_list(Name, X), not_member(X, L1), inner_namespace_list(Name, L2, [X | L1]).

in_namespace_list(Name, X) :- namespaces(Y, Name), page(X, Y, _, E).
	

