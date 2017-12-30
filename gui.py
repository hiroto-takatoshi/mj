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

        self.setWindowTitle('MiniJava')    

        self.show()

        

    def openfile (self):

        filename = QFileDialog.getOpenFileName(self, 'Open File', '.')

        fname = open(filename)

	instuc1 = "./mj < "+str(filename)+" > tree.txt 2>error.txt"

        instuc2 = "python3 tree.py"

        os.system(instuc1)

        os.system(instuc2)

	code = ""

	code = fname.read()

	errfile = open("error.txt")

	err = ""

	err = errfile.read()

	errnumli = []

	errsenli = err.split('\n')

	for sen in errsenli:

		wordli = sen.split(' ')

		for i in range(0,len(wordli)):

			if wordli[i] == "line":

				errnumli.append(eval(wordli[i+1]))

		



        pic = QLabel(self)

        pic.setPixmap(QPixmap("exp.png"))	

                

        self.realmScroll = QScrollArea(self)

        self.setCentralWidget(self.realmScroll)

        self.realmScroll.setWidgetResizable(True)

        labelsContainer = QWidget()

        self.realmScroll.setWidget(labelsContainer)

        labelsLayout = QHBoxLayout(labelsContainer)

        

	textedit = QTextEdit()

	textedit.setReadOnly(True)

	#textedit.append(code)

	displaycode = ""

	codesenli = code.split('\n')

	redColor = QColor(255, 0, 0)

	blackColor = QColor(0, 0, 0)

	for n in range(1,len(codesenli)+1):

		if n in errnumli:

			#displaycode += '<p>'+(str(n) + '\t<span style=\" font-size:12pt; font-weight:300; color:#ff0000;\" >'+ html_decode(codesenli[n -1]) +' &lt;------ error'+ '</span>' +'\n'+'</p>')



			textedit.setTextColor(redColor)

			textedit.append(str(n) +' '+codesenli[n -1][:-1]+'    <-----error'+'\n')

			

		else:

			textedit.setTextColor(blackColor)

			textedit.append(str(n) +' '+codesenli[n -1])

			#displaycode += '<p>'+(str(n) + '\t<span style=\" font-size:12pt; font-weight:300; color:#000000;\" >'+ html_decode(codesenli[n -1]) +'</span>'+ '\n'+'</p>')

		



	#textedit.append(displaycode)

	textedit.setFixedSize(800, 800)

	labelsLayout.addWidget(textedit)

	print(errnumli)

	print(code)    

	print(err)

        if (len(errnumli) == 0):

		labelsLayout.addWidget(pic)



	with open("error.txt" ,"w") as wf:

		wf.write("")



        fname.close()

        

def html_decode(s):

    """

    Returns the ASCII decoded version of the given HTML string. This does

    NOT remove normal HTML tags like <p>.

    """

    htmlCodes = (

            ("'", '&#39;'),

            ('"', '&quot;'),

            ('>', '&gt;'),

            ('<', '&lt;'),

            ('&', '&amp;')

        )

    for code in htmlCodes:

        s = s.replace(code[0], code[1])

    return s



        

def main():

    

    app = QApplication(sys.argv)

    ex = Example()

    sys.exit(app.exec_())





if __name__ == '__main__':

    main()    
