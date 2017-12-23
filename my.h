#include <iostream>
#include <list>
#include <string>

using namespace std;

class node {
    public:
        int num;
        string name;
        node(int _n, string _s):num(_n), name(_s){}
};
typedef list<node *> nodes;