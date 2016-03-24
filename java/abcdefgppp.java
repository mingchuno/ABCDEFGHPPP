// http://m2.hkgolden.com/view.aspx?message=6307521&type=SW&page=2
// 凍啡走甜走奶

public class Permutation {
    private int next = 0;
    private char[][] permutations;
    private char[] numberSet;

    public static void main(String [] args){
        char numerSet [] = new char []{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
        Permutation per = new Permutation(numerSet);

        for (char [] numChars : per.generatePermutations()){
            int [] nums = ctoi(numChars);
            test(nums);
        }
    }

    public static void test(int [] i){
        if (i[0] == 0 || i[2] == 0 || i[4] == 0 || i[6] == 0) return;

        int ab = i[0] * 10 + i[1];
        int cd = i[2] * 10 + i[3];
        int ef = i[4] * 10 + i[5];

        if ((ab - cd) != ef) return;

        int gh = i[6] * 10 + i[7];
        int ppp = i[8] * 100 + i[8] * 10 + i[8];

        if (ef + gh == ppp)
            System.out.printf("%d - %d = %d, %d + %d = %d\n", ab, cd, ef, ef, gh, ppp);
    }

    public static int[] ctoi(char [] array){
        int [] intArray = new int[array.length];
        for (int i = 0; i < array.length; i++) {
            intArray[i] = array[i] - '0';
        }

        return intArray;
    }

    public Permutation(char[] numberSet) {
        super();
        this.numberSet = numberSet;
        this.permutations = new char [totalPermutation(numberSet.length)][];
    }

    public char [][] generatePermutations(){
        if (next == 0)
            generatePermutations(numberSet, 0);

        return permutations;
    }

    private void generatePermutations(char [] ary, int start){
        if (start == ary.length){
            permutations[next++] = ary.clone();
        }
        else {
            for (int i=start; i<ary.length; i++){
                swapNumber(ary, i, start);
                generatePermutations(ary, start+1);
                swapNumber(ary, i, start);
            }      
        }
    }

    private void swapNumber(char [] ary, int a, int b){
        char temp = ary[a];
        ary[a] = ary[b];
        ary[b] = temp;
    }



    public int totalPermutation(){
        return totalPermutation(numberSet.length);
    }

    private int totalPermutation(int size){
        int total = 1;
        for (int i=1; i<=size; i++){
            total = total * i;
        }

        return total;
    }
}