import matplotlib.pyplot as plt
import numpy as np
import sys
import os
import argparse
import textwrap

def parse_reward(filename):
    rewards = []
    filepath = os.path.join("~", filename)
    with open(os.path.expanduser(filepath),"r") as file:
        for line in file:
            if not line.strip()[:1].isalpha():
                rewards.append(int(line.strip()))
    output = np.array(rewards)
    return output

def create_reward_graph(rewards):
    y = rewards
    x = np.arange(len(y))
    fit = np.poly1d(np.polyfit(x, y, 3))
    plt.plot(x, y, 'kx', x, fit(x), 'b--')
    plt.xlim(0, len(x))
    plt.ylim(min(y) - 0.1*abs(min(y)), max(y)+ 0.1*abs(max(y)))
    plt.show()


header = '''
#####################################################################################
#                                                                                   #
#   Create plot from overcooked game points received during training                #
#                                                                                   #
#####################################################################################
'''

parser = argparse.ArgumentParser(description=textwrap.dedent(header),
                                formatter_class=argparse.RawTextHelpFormatter)

parser.add_argument(
    '--filename',
    type=str,
    required=True,
    help='txt-file to read training points from')
args = parser.parse_args(args=None if sys.argv[1:] else ['--help'])
# validate inputs
if args==None:
    parser.exit(1)

filename = args.filename

rewards = parse_reward(filename)
create_reward_graph(rewards)