      program f_prog
          integer :: a,b,c,d,e,f,g,h,p 
          do a = 1, 9 
           do b = 0, 9
            if (a /=b) then 
                continue
            end if
            do c = 1, 9
             do d = 0, 9  
              do e = 1, 9
               do f = 0, 9
                do g = 1, 9
                 do h = 0, 9
                  do p = 1, 9
                    if ( ((a*10+b) - (c*10+d) == (e*10+f)) &
                        .AND. ((e*10+f) + (g*10+h) == p*111) &
                        .AND. (a /= b) & 
                        .AND. (a /= b) &
                        .AND. (a /= c) &
                        .AND. (a /= d) &
                        .AND. (a /= e) &
                        .AND. (a /= f) &
                        .AND. (a /= g) &
                        .AND. (a /= h) &
                        .AND. (a /= p) &
                        .AND. (b /= c) &
                        .AND. (b /= d) &
                        .AND. (b /= e) &
                        .AND. (b /= f) &
                        .AND. (b /= g) &
                        .AND. (b /= h) &
                        .AND. (b /= p) &
                        .AND. (c /= d) &
                        .AND. (c /= e) &
                        .AND. (c /= f) &
                        .AND. (c /= g) &
                        .AND. (c /= h) &
                        .AND. (c /= p) &
                        .AND. (d /= e) &
                        .AND. (d /= f) &
                        .AND. (d /= g) &
                        .AND. (d /= h) &
                        .AND. (d /= p) &
                        .AND. (e /= f) &
                        .AND. (e /= g) &
                        .AND. (e /= h) &
                        .AND. (e /= p) &
                        .AND. (f /= g) &
                        .AND. (f /= h) &
                        .AND. (f /= p) &
                        .AND. (g /= h) &
                        .AND. (g /= p) &
                        .AND. (h /= p) &

                    )&
                    then
                        write (*,*)&
                            char(48+a)//char(48+b)//&
                        '-'//char(48+c)//char(48+d)//&
                        '='//char(48+e)//char(48+f)//&
                        ','// &
                        ' '//char(48+e)//char(48+f)//&

                        '+'//char(48+g)//char(48+h)//&
                        '='//char(48+p)//char(48+p)//&
                        char(48+p)
                     end if    
                      end do       
                     end do          
                    end do
                   end do
                  end do
                 end do
                end do
               end do
              end do
              end
