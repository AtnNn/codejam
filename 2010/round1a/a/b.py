T = input()

for i in range(1,T):

    N = read();
    M = read();

    dirs = {}
    for j in range(1, N):
        adddir(dirs, raw_input());

    ret = 0;
    for j in range(1, N):
        ret = ret + adddir(dirs, raw_input());

    print "Case #" + i + ": " + ret

def adddir(dirs, dir):
    path = dir[1:].split('/')
    return addpath(dirs, path)

def addpath(d, p):
    if len(p) == 0:
        return 0

    ret = 0
    if not d.has_key(p[0]):
        ret = 1
        d[p[0]] = {}

    return ret + addpath(d[p[0]], p[1:])
