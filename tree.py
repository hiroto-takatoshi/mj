#!/usr/bin/env python
# # -*- coding: utf-8 -*-

# Uses pydot, graphviz's python port to generate the syntax tree.
# Here, we perform a trick to manage the node orders correctly.

import pydot
graph = pydot.Dot(graph_type='graph')
S = pydot.Subgraph(rank='same')

f = open("tree.txt", 'r')

n = {}

l = f.read().splitlines()
l = reversed(l)

lastu = ""

ll = []

for _ in l:

    nodeu = _.split(' ', 1)[0]
    
    noded = _.split(' ', 1)[1]

    if nodeu != lastu:
        while len(ll):
            e = pydot.Edge(lastu, ll[-1])
            graph.add_edge(e)
            del ll[-1]
        lastu = nodeu
    
    ll.append(noded)
    



f.close()



print(graph.to_string())

graph.write_png('exp.png')