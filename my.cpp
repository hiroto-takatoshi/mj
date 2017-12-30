#include <stdio.h>
#include <iostream>
#include <string>
#include <list>
#include "my.h"

using namespace std;

extern int yylineno;

void semantic(list<node *> *l1,  list<node *> *l2) {
    /* Performs semantic check for each, every l2 element in l1  */
    for (list<node *> :: iterator it = l2->begin(); it != l2->end(); ++it) {
        if ((*it) -> _id == "")
            continue ;
        bool found = false;
        for (list<node *> :: iterator jt = l1->begin(); jt != l1->end(); ++jt) {
            
            if ((*it) -> _id == (*jt) -> _id) {
                found = true;
                break;
            }
        }
        if (!found) {
            char holder[20];
            sprintf(holder, " at line %d", yylineno);
            throw logic_error("Semantic error : undefined " + (*it) -> _id + string(holder));
        }
    }
}

void add_nn(node *n1, node *n2) {
    printf("[%d]", n1->num);
    cout << n1->name << " ";
    printf("[%d]", n2->num);
    cout << n2->name << endl;
}

void add_nl(node *n1, list<node *> *l1) {
    //printf("shit:!!!%d\n", l1->size());
    //if(l1 == NULL) return;
    for (list<node *> :: iterator it = l1->begin(); it != l1->end(); ++it) {
        add_nn(n1, *it);
    }

}

void add_ns(node *n1, string s1) {
    printf("[%d]", n1->num);
    cout << n1->name << " " << s1 << endl;

}

string cntstr() {
    char ts[100];
    sprintf(ts,"[%d]",++cnt);
    return string(ts);
}

// T for Token.
void add_nt(node *n1, string s1) {
    add_ns(n1, cntstr() + s1);
}
