with Ada.Text_IO;
with Ada.Strings.Unbounded;
procedure abcdefghppp is
    procedure output_string(A,B,C,D,E,F,G,H,P: Integer) is 
    begin
        Ada.Text_IO.Put_Line(
            Integer'image(A*10+B) & "-" &
            Integer'image(C*10+D) & "=" &
            Integer'image(E*10+F) & ", " &
            Integer'image(E*10+F) & "-" &
            Integer'image(G*10+H) & "=" &
            Integer'image(P*111)); 
    end output_string;
begin
    for A in Integer range 1..9 loop
        for B in Integer range 0..9 loop
            for C in Integer range 1..9 loop
                for D in Integer range 0..9 loop
                    for E in Integer range 1..9 loop
                        for F in Integer range 0..9 loop
                            for G in Integer range 1..9 loop
                                for H in Integer range 0..9 loop
                                    for P in Integer range 1..9 loop
                                        if (A/=B) and (A/=C) and (A/=D)  and (A/=E) and (A/=F) and (A/=G)  and (A/=H) and (A/=P) 
                                            and (B/=C) and (B/=D) and (B/=E) and (B/=F) and (B/=G) and (B/=H) and (B/=P)
                                            and (C/=D) and (C/=E) and (C/=F) and (C/=G) and (C/=H) and (C/=P) 
                                            and (D/=E) and (D/=F) and (D/=G) and (D/=H) and (D/=P) 
                                            and (E/=F) and (E/=G) and (E/=H) and (E/=P)
                                            and (F/=G) and (F/=H) and (F/=P)
                                            and (G/=H) and (G/=P)
                                            and (H/=P) 
                                            and ((A*10+B) - (C*10+D) = (E*10+F)) and ((E*10+F) + (G*10+H) = P*111) then
                                            output_string(A,B,C,D,E,F,G,H,P);
                                        end if;
                                    end loop;
                                end loop;
                            end loop;
                        end loop;
                    end loop;
                end loop ;
            end loop ;
        end loop ;
    end loop ;

end abcdefghppp; 

