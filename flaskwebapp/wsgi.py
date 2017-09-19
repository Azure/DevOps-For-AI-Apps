import sys
sys.path.append('/code/') # FIXME: This is horrible
from app import app as application
from driver import *

def create():
    print("Initialising")
    init()
    application.run(host='127.0.0.1', port=5000)