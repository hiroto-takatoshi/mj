#include <iostream>
#include <list>
#include <string>

using namespace std;

extern int cnt;

class node {
    public:
        int num;
        string name;
        node(int _n, string _s):num(_n), name(_s){}
};

typedef list<node *> nodes;

void add_nn(node *n1, node *n2);

void add_nl(node *n1, list<node *> *l1);

void add_ns(node *n1, string s1);

string cntstr();

void add_nt(node *n1, string s1);