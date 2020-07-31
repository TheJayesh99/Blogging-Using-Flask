from flask import Flask, render_template, request, session,redirect,flash
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from flask_mail import Mail
import json
import os
from werkzeug.utils import secure_filename
import math

with open('config.json','r') as c:
    params = json.load(c)["params"]

local_server = True

app = Flask(__name__)
app.secret_key = "super-secret-key"

app.config['UPLOAD_FOLDER'] = params['upload_location']

app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD=  params['gmail-password']
)
mail = Mail(app)

if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db = SQLAlchemy(app)

class Contacts(db.Model):
    '''
    sno name email number msg date
    '''
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50),  nullable=False)
    email = db.Column(db.String(50),  nullable=False)
    number = db.Column(db.Integer,  nullable=False)
    msg = db.Column(db.String(200),  nullable=False)
    date = db.Column(db.String(50),  nullable=True)

class Posts(db.Model):
    '''
    sno title slug content date img_file
    '''
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(1000), nullable=False)
    tagline = db.Column(db.String(500), nullable=False)
    img_file = db.Column(db.String(12), nullable=True)
    date = db.Column(db.String(12), nullable=True)

@app.route('/')
def home():
    posts = Posts.query.filter_by().all()
    # [0:params['no_of_posts']]
    last = math.ceil(len(posts)/int(params['no_of_posts']))
    page = request.args.get('page')
    if (not str(page).isnumeric()):
        page = 1
    page = int(page)
    posts = posts[(page-1)*int(params['no_of_posts']): (page-1)*int(params['no_of_posts'])+int(params['no_of_posts'])]
    if (page == 1):
        prev = "#"
        nxt = "/?page="+ str(page+1)
    elif(page == last):
        prev = "/?page="+ str(page-1)
        nxt = "#"
    else :
        prev =  "/?page="+ str(page-1)
        nxt =  "/?page="+ str(page+1)
    return render_template('index.html', params=params, posts=posts,prev=prev,nxt = nxt)

@app.route('/edit/<string:sno>', methods = ['GET','POST'])
def edit(sno):
    if ('user' in session and session['user']== params['admin_user']):
        if(request.method=='POST'):
            
            title=request.form.get('title')
            tagline=request.form.get('tagline')
            slug=request.form.get('slug')
            content=request.form.get('content')
            img_file=request.form.get('img_file')
 
            
           
            if sno == '0':
                entry = Posts(title= title, tagline = tagline, slug=slug, content=content,img_file =img_file, date = datetime.now())
                db.session.add(entry)
                db.session.commit()

            else:
                post = Posts.query.filter_by(sno=sno).first()
                
                post.title = title
                post.tagline = tagline
                post.slug = slug
                post.content = content
                post.img_file = img_file
                post.date= datetime.now()
                db.session.commit()
                return redirect('/edit/'+sno)

        post = Posts.query.filter_by(sno = sno).first()

        return render_template("edit.html", params=params, post = post ,sno=sno)

@app.route('/about')
def about():
 return render_template("about.html", params=params )

@app.route('/uploader', methods = ['GET','POST'])
def uploader():
    if ('user' in session and session['user']== params['admin_user']):
        if(request.method=='POST'):
            f= request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            # return "uploaded"
    posts = Posts.query.filter_by().all()
    return render_template("dashboard.html", params=params ,posts = posts )

@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')

@app.route('/delete/<string:sno>', methods = ['GET','POST'])
def delete(sno):
    if ('user' in session and session['user']== params['admin_user']):
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')

@app.route('/dashboard', methods = ['GET','POST'])
def dashboard():
    if ('user' in session and session['user']== params['admin_user']):
        posts = Posts.query.filter_by().all()
        return render_template("dashboard.html", params=params ,posts = posts )

    
    if(request.method=='POST'):
        username = request.form.get('uname')
        userpass = request.form.get('pass')

        if (username == params['admin_user'] and userpass == params['admin_password']):
            session['user'] = username
            posts = Posts.query.filter_by().all()

            return render_template("dashboard.html", params=params, posts =posts)

      

    return render_template("login.html", params=params )

@app.route('/contact', methods = ['GET','POST'] )
def contact():
    if(request.method=='POST'):

        '''add entry to db '''

       
        name=request.form.get('name')
        email=request.form.get('email')
        phone=request.form.get('phone')
        message=request.form.get('message')
 
        entry = Contacts(name= name, email = email, number=phone, msg=message, date = datetime.now())
        db.session.add(entry)
        db.session.commit()
    
        # mail.send_message('New message from ' + name,
        #                   sender=email,
        #                   recipients = [params['gmail-user']],
        #                   body = message + "\n" + phone
        #                   )
                        
        flash("Thanks for submiting your details ,we will get back to you soon","success")
       
    

    return render_template('contact.html', params=params)

@app.route('/post/<string:post_slug>',methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params,post = post)

if __name__ == '__main__':
    app.run(debug=True)




