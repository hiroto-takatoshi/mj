import sys,os
from PyQt4.QtGui import *
from PyQt4.QtCore import *

class Example(QMainWindow):
    
    def __init__(self):
        super(Example, self).__init__()
        
        self.initUI()
        
    def initUI(self):               
        
        exitAction =QAction('&Exit', self)        
        exitAction.setShortcut('Ctrl+Q')
        exitAction.setStatusTip('Exit application')
        exitAction.triggered.connect(qApp.quit)
        
        loadAction = QAction('&Load', self)        
        loadAction.setShortcut('Ctrl+L')
        loadAction.setStatusTip('Load a file')
        loadAction.triggered.connect(self.openfile)

        self.statusBar()

        menubar = self.menuBar()
        fileMenu = menubar.addMenu('&File')
        fileMenu.addAction(loadAction)
        fileMenu.addAction(exitAction)

        
        self.setGeometry(300, 300, 300, 200)
        self.setWindowTitle('Menubar')    
        self.show()
        
    def openfile (self):
        filename = QFileDialog.getOpenFileName(self, 'Open File', '.')
        fname = open(filename)
        instuc1 = "./mj < "+str(filename)+" > tree.txt"
        instuc2 = "python3 tree.py"
        #s = fname.read()
        #print(s)
        print(os.system(instuc1))
        print(os.system(instuc2))
        pic = QLabel(self)
        #pic.setGeometry(10, 10, 400, 100)

        pic.setPixmap(QPixmap("exp.png"))
                
        self.realmScroll = QScrollArea(self)
        self.setCentralWidget(self.realmScroll)
        self.realmScroll.setWidgetResizable(True)
        labelsContainer = QWidget()
        self.realmScroll.setWidget(labelsContainer)
        labelsLayout = QVBoxLayout(labelsContainer)
        labelsLayout.addWidget(pic)
        
        
        fname.close()
        
        
def main():
    
    app = QApplication(sys.argv)
    ex = Example()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()    