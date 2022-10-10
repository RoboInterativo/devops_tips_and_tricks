#!/usr/bin/env python3

import sys
import random
import  string
def gen_pass(template):
    token_list=
def main():
    # print ("Number of arguments:", len(sys.argv), "arguments")
    # print ("Argument List:", str(sys.argv))
    small_letters=[]
    capital_letters=[]
    numerics=[]
    for i in range (10):
        numerics.append(str (i))
    for i in range (97,123):
        small_letters.append(chr (i))
    for i in range (65,91):
        small_letters.append(chr (i))
    punctuations = list(string.punctuation)

    my_list=[]
    my_list.extend(numerics)
    my_list.extend(small_letters)
    my_list.extend(capital_letters)

    passwd=''
    count_p=1
    if len(sys.argv)>0:
        if '-l' in sys.argv:
            ind= sys.argv.index('-l')
            if ind<=len(sys.argv):
                pass_l=int(sys.argv[ind+1]  )
            else:
                pass_l=random.randint(6,12)
        if '-c' in sys.argv:
            ind= sys.argv.index('-l')
            if ind<=len(sys.argv):
                count_p=int(sys.argv[ind+1]  )
            else:
                count_p=1
    for i in range(count_p):
        passwd=''
        for j in range(pass_l):
             passwd=passwd+random.choice(my_list)
        print (f"Password #{ i+1 }: { passwd }" )

    print ("Number of arguments:", len(sys.argv), "arguments")
    print ("Argument List:", str(sys.argv))






if __name__ == '__main__':
    main()
