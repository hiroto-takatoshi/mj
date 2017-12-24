#include <stdio.h>
#include <iostream>
#include <string>
#include <list>
#include "my.h"

using namespace std;

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
