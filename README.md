# mj

Minijava parser with bison, syntax tree with graphviz. </br>

https://github.com/hiroto-takatoshi/mj 

## Dependencies

GNU bison, pydot(python package), graphviz.

## Basic commands

Run ``` make clean ``` before a new build. </br>

Simply run ```make``` to build. </br>

```bash
./mj < test/factorial.java > tree.txt
python3 tree.py
```
By default ```tree.py``` reads the ```tree.txt``` file, and outputs syntax tree diagram to ```exp.png```.

## Contributions

__GUI__ 许陆 </br>
__Everything else__ 王凯伦 </br>
