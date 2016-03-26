// http://www.hkepc.com/forum/redirect.php?goto=findpost&ptid=2277138&pid=34656894
// By vichui
public class ABCDEFGHPPP {
        static int count=0;
        static int[] EF={24,25,26,27,32,35,36,39,42,43,48,49,87, 86, 85, 84, 79, 76, 75, 72, 69, 68, 63, 62};
        static int[] GH={87, 86, 85, 84, 79, 76, 75, 72, 69, 68, 63, 62,24,25,26,27,32,35,36,39,42,43,48,49};
        static int[][] ABCD={
                        {3,5,6,9},
                        {3,4,7,9},
                        {3,4,7,9},
                        {3,5,6,9},
                        {4,5,6,8},
                        {2,4,8,9},
                        {2,4,8,9},
                        {4,5,6,8},
                        {3,5,7,8},
                        {2,5,7,9},
                        {2,5,7,9},
                        {3,5,7,8},
                        {3,5,6,9},
                        {3,4,7,9},
                        {3,4,7,9},
                        {3,5,6,9},
                        {4,5,6,8},
                        {2,4,8,9},
                        {2,4,8,9},
                        {4,5,6,8},
                        {3,5,7,8},
                        {2,5,7,9},
                        {2,5,7,9},
                        {3,5,7,8},
                };
        public static void main(String[] args) { 
                for (int i =0 ; i < EF.length ; i++){
                        testAC(EF[i],GH[i],ABCD[i]);
                }
        }
        private static void testAC(int ef,int gh, int[] abcd) {
                // test A-C=E where A > C
                int e = ef/10;
                int f = ef-e*10;
                for (int i =3 ; i >=0 ; i--){
                        for (int j=i-1;j >=0 ; j--){
                                if(abcd[i]-abcd[j]==e){
                                        int[] canidate = new int[4];
                                        System.arraycopy(abcd, 0, canidate , 0, abcd.length);
                                        swap(canidate,3,i);
                                        swap(canidate,2,j);                                        
                                        if (((canidate[3]*10 + canidate[0]) - (canidate[2]*10 + canidate[1])) == ef){
                                                System.out.printf("%d: %d - %d = %d + %d = 111 \n",count++,canidate[3]*10 + canidate[0],canidate[2]*10 + canidate[1],ef,gh);        
                                        }
                                        if (((canidate[3]*10 + canidate[1]) - (canidate[2]*10 + canidate[0])) == ef){
                                                System.out.printf("%d: %d - %d = %d + %d = 111 \n",count++,canidate[3]*10 + canidate[1],canidate[2]*10 + canidate[0],ef,gh);                                                        
                                        }
                                }                                
                        }
                }

                //test A-C=E+1
                for (int i =3 ; i >=0 ; i--){
                        for (int j=i-1;j >=0 ; j--){
                                if(abcd[i] - 1 -abcd[j]==e){
                                        int[] canidate = new int[4];
                                        System.arraycopy(abcd, 0, canidate , 0, abcd.length);
                                        swap(canidate,3,i);
                                        swap(canidate,2,j);
                                        if (((canidate[3]*10 + canidate[0]) - (canidate[2]*10 + canidate[1])) == ef){
                                                System.out.printf("%d: %d - %d = %d + %d = 111 \n",count++,canidate[3]*10 + canidate[0],canidate[2]*10 + canidate[1],ef,gh);                                                        
                                        }
                                        if (((canidate[3]*10 + canidate[1]) - (canidate[2]*10 + canidate[0])) == ef){
                                                System.out.printf("%d: %d - %d = %d + %d = 111 \n",count++,canidate[3]*10 + canidate[1],canidate[2]*10 + canidate[0],ef,gh);        
                                        }
        if (((canidate[3]*10 + 0) - (canidate[2]*10 + canidate[1])) == ef){
                                                System.out.printf("%d: %d - %d = %d + %d = 111 \n",count++,canidate[3]*10 ,canidate[2]*10 + canidate[1],ef,gh);                                                        
                                        }
                                        if (((canidate[3]*10 + 0) - (canidate[2]*10 + canidate[0])) == ef){
                                                System.out.printf("%d: %d - %d = %d + %d = 111 \n",count++,canidate[3]*10 ,canidate[2]*10 + canidate[0],ef,gh);        
                                        }
                                }
                        }
                }
        }
        
        public static void swap(int[] array,int i, int j ) {
        int temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
}
