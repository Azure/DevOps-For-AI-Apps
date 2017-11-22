import os
import sys
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../../..')))

print(sys.path)
from flaskwebapp.driver import init, run
from flaskwebapp import driver