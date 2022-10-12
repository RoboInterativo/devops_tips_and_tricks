from flask import render_template
from flask import Flask, redirect
import jinja2
import yaml
import jinja2
from flask import request
import validators

import sys
import random
import  string
import sqlite3
from flask import g

DATABASE = './database.db'
app = Flask(__name__)
def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DATABASE)
    return db

def init_db():
    db=get_db()

@app.route('/<slug>/')
def index(slug):
    r=get_slug(slug)
    if len(r)>0:
        url=get_slug(slug)[0][1]
        return redirect(url, code=302 )
    else:
        return "NOT FOUND"
    
    
    


@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()
        
# @app.route('/')
# def hello():
#     return redirect("http://www.example.com", code=302
                    
def get_url (url):
    db=get_db()
    cur=db.cursor()
    r=cur.execute (f"select * from shorts where url='{url}'")
    return r.fetchall()

def get_slug (slug):
    db=get_db()
    cur=db.cursor()
    r=cur.execute (f"select * from shorts where slug='{slug}'")
    return r.fetchall()

def write_slug (url,slug):
    db=get_db()
    cur=db.cursor()
    cur.execute("INSERT INTO shorts (url,slug) VALUES (?, ?)",
            (url, slug)
            )
    db.commit()
    
    
def get_new_slug(pass_l):
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
    #count_p=1

    passwd=''
    #pass_l=random.randint(3,6)
    for j in range(pass_l):
            passwd=passwd+random.choice(my_list)
    # print ( passwd  )
    return passwd


@app.route("/")
def hello_world2():
    return render_template("./index.html")





@app.route("/--")
def hello_world():
    url = request.args.get('url', 'none')
    if not validators.url(url):
        return render_template("./send2.html",url=url)  
    if url !='none':
        r=get_url(url)
        print(r)
        if len(r)==0 :
            
            
            while True :
                pass_l=random.randint(3,6)
                slug=get_new_slug(pass_l)
                r2=get_slug(slug)
                if len(r2)==0:
                    write_slug(url,slug)
                    url2= f'http://nexus.robointerativo.ru:7777/{slug}'
                    
                    return render_template("./send.html",url=url,slug=url2)


        else:
            slug=r[0][2]
            url2= f'http://nexus.robointerativo.ru:7777/{slug}'
            return render_template("./send.html",url=url,slug=url2)	
	




app.run(host="0.0.0.0",port=7777,debug=True)
