import sys,re
g,u=[],{}
r=r"[\w\+\._-]+@\w+[\w*\.]+\w+"
f=open(sys.argv[1],'r')
for l in f:
    g+=re.findall(r,l)
for i in g:
    u[i]=1
sys.stdout=open(sys.argv[2], 'w')
print ("\n".join(u.keys()))
sys.stdout.close()
