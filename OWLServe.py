"""
Based on Aaron Swartz's web.py (http://www.aaronsw.com/)
"""


import web

urls = (
            '/'             , 'Index',
            '/get/(.*)'     , 'Get',
            '/put/(.*)'     , 'Save'
)

pagedir = './static/pages/'

def fName(pName) : return "%s%s.opml"%(pagedir,pName)

class Index ():
    
    def GET(self):        
        web.redirect(web.ctx.home+'/static/server.html') 
        #web.internalerror = web.debugerror

class Get :
    def GET(self,pName) :
        try :
            f = open(fName(pName))
            print f.read()            
        except Exception, e :
            print "%s" % e

class Save :

    def POST(self,pName):
        try :
            form = web.input()
            pageName = form.pageName
            body = form.body
            f = open(fName(pName),"w")
            f.write(body)
            f.close()
            if form.text :
                f = open("./exports/text/%s.txt"%pageName,"w")
                f.write(form.text)
                f.close()
            print "OK"
            
        except Exception, e :
            print "%s" % e        
        


if __name__ == '__main__':
    web.run(urls, web.reloader)

