

class @Page
    constructor:(@pageName,@body) ->    
        @created = new Date().toString()
        @saved = ""
        @text = ""
    
    toString:() ->
        return "#{@pageName} \n #{@body} \n #{@created} \n #{@saved} "
        
        
class @BrowserBasedPageStore
    k:(pName) -> "fpt.pageStore."+pName

    x:(pName) -> "fpt.ps.X."+pName
    
    isDirty:(pName) ->        
        s = localStorage.getItem(@x(pName))
        return (s == "true")
        
    setDirty:(pName) ->
        localStorage.setItem(@x(pName),"true")
    
    setClean:(pName) ->
        localStorage.setItem(@x(pName),"false")

    hasName:(pName) ->
        s = localStorage.getItem(@k(pName))        
        if s?
            return true
        return false
        
    get:(pName,callback) -> 
        s = localStorage.getItem(@k(pName))        
        if s?
            page = JSON.parse(s)
        else 
            page = new Page(pName,initialOpmltext)
        callback(page)
        
    set:(pName,page) -> 
        localStorage.setItem(@k(pName),JSON.stringify(page))
        # tell that we've changed this item in browser store
        @setDirty(pName)
    
    save:(page,errorCallback) -> 
        page.saved = new Date().toString()
        @set(page.pageName,page)
        

class @ServerBasedPageStore
    constructor:(@getUrl,@postUrl,@postSuccessHandler) ->
        
    get:(pName,callback) ->                            
        $.ajax({ 
            type: 'GET', 
            url: @getUrl+pName,
            success: (data) ->
                console.log(data)
                callback(new Page(pName,data))
            ,    
            error: (xmlHttpRequest) =>
                console.log("ERROR IN get " + pName)                
               
        });        
        
       
    save:(page,saveErrorHandler) ->
        $.ajax({
            type : 'POST',
            url : @postUrl+page.pageName,
            data : {"pageName":page.pageName, "body":page.body, "text":page.text},
            success : (data) =>
                @postSuccessHandler(page.pageName)
            ,
            error   : (xmlHttpRequest) =>
                    console.log("ERROR IN POST " + page.pageName)
                    console.log(xmlHttpRequest)
                    saveErrorHandler(xmlHttpRequest)
        })



