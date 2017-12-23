#!/usr/bin/env python
# # -*- coding: utf-8 -*-

import pydot
graph = pydot.Dot(graph_type='graph')

f = open("tree.txt", 'r')
for s in f.readlines():
    nodeu = s.split(' ', 1)[0]
    noded = s.split(' ', 1)[1]
    e = pydot.Edge(nodeu, noded)
    graph.add_edge(e)

f.close()

graph.write_png('exp.png')