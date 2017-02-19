#!/usr/bin/env python2

import zmq,sys,random                                                          # importing modules

Max = 10**7                                                                    # Setting max number (for random generation)

def server():

    # ZeroMQ Context
    context = zmq.Context()

    # Define the socket using the "Context"
    sock = context.socket(zmq.REP)
    sock.bind("tcp://127.0.0.1:9002")

    # Receive a request of number from next point
    while True:
        num = int(sock.recv())
        print ("Received : " + str(num))
        return num

def client(num,flag2):

    # ZeroMQ Context
    context = zmq.Context()

    # Define the socket using the "Context"
    sock = context.socket(zmq.REQ)
    sock.connect("tcp://127.0.0.1:9003")

    # Sends the request for processed num to previous point
    if flag2:                                                                  # Keeps check on not sending to a closed server
        sock.send(str(num))
        print ("Sent     : " + str(num))                                       # Printing the sent numbers
    
    if num==1:
        return 0                                                               # Keeping check on terminating on num = 1
    else:
        return 1

def main():
    if (sys.argv[len(sys.argv)-1] == 'start'):
        num = random.choice(range(1001,Max+1))                                     # Generating a random number
        if (num % 2 == 0):
            num = num//2
        else:
            num = (num*3)+1
        flag = 1
    
    else:
        num = server()
        flag = 1

    flag2 = 1

    while flag:
        if (num % 2 == 0):
            num = num//2                                                           # Running operations on num
        
        elif (num != 1):
            num = (num*3)+1
        flag = client(num,flag2)                                                   # Calls function for sending to client
        
        if(num==2):
            flag2 = 0                                                              # Setting flag2 to keep check on last sent request
        if flag:
            num = server()                                                         # Asking for number from previous point
    
if __name__ == '__main__':
    main()

#END_OF_SOURCE_CODE    
