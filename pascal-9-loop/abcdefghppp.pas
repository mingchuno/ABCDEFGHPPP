program abcdefghppp;
uses crt;
var a,b,c,d,e,f,g,h,p: integer;

begin
    for a:=1 to 9 do
        for b:=0 to 9 do
            begin
            for c:= 1 to 9 do
                begin
                for d:= 0 to 9 do
                    begin
                    for e:= 1 to 9 do
                        begin
                        for f:= 0 to 9 do
                            begin
                            for g:= 1 to 9 do
                                begin
                                for h:= 0 to 9 do
                                    begin
                                    for p:= 1 to 9 do
                                        begin
                                        if ((a <> b) and (a <> c) and (a <> d) and (a <> e) and (a <> f) and (a <> g) and (a <> h) and (a<>p) and
                                             (b <> c) and (b <> d) and (b <> e) and (b <> f) and (b <> g) and (b <> h) and (b<>p) and 
                                              (c <> d) and (c <> e) and (c <> f) and (c <> g) and (c <> h) and (c<>p) and 
                                              (d <> e) and (d <> f) and (d <> g) and (d <> h) and (d<>p) and 
                                              (e <> f) and (e <> g) and (e <> h) and (e<>p) and 
                                              (f <> g) and (f <> h) and (f<>p) and
                                              (g <> h) and (g<>p) and
                                              (h <> p) and
                                              ((a*10+b) - (c*10+d) = (e*10+f)) and ((e+g)*10+f+h = p*111)
                                              )
                                              then 
                                              begin
                                              writeln ((a*10+b),'-',(c*10+d),'=',(e*10+f),', ',(e*10+f),'+',(g*10+h),'=',(p*111))
                                              end
                                                
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            
end.

