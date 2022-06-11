-- Output html to file

main :: IO ()
main = putStrLn (render myHtml)

newtype Html = Html String
newtype Structure = Structure String
type Title = String

myHtml :: Html
myHtml = 
     html_ 
        "Title" 
        ( append_   
            (h1_ "heading" )
            (append_ 
                ( p_ "Here's some text")
                ( p_ "Here's some more text")
            )
        )

html_ :: Title -> Structure -> Html
html_ title content = 
    Html 
        ( el "html" 
            ( el "head" (el "title" title)
                <> el "body" (getStructureString content)
            )
        )

el :: String -> String -> String
el tag content = 
    "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

p_ :: String -> Structure
p_ = Structure . el "p"

h1_ :: String -> Structure 
h1_ = Structure . el "h1"

append_ :: Structure -> Structure -> Structure 
append_ c1 c2 =
    Structure (getStructureString c1 <> getStructureString c2)

getStructureString :: Structure -> String 
getStructureString content = 
    case content of 
        Structure str -> str

render :: Html -> String
render html = 
    case html of
        Html str -> str
