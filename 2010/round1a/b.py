T = input()

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

for i in range(1,T+1):

    (N, M) = raw_input().split();

    dirs = {}
    for j in range(0, int(N)):
        adddir(dirs, raw_input());

    ret = 0;
    for j in range(0, int(M)):
        ret = ret + adddir(dirs, raw_input());

    print "Case #" + str(i) + ": " + str(ret)

