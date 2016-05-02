//
//  main.c
//  c-only-program
//
//  Copyright see the github page https://github.com/mingchuno/ABCDEFGHPPP
//

#include <stdio.h>
#include <string.h>

#include "main_w2.h"
#include "main_w4.h"
#include "main_wx.h"

// int main(int argc, const char * argv[]) {
int main() {
// insert code here...
    printf("Hello, ABCDEFGHPPP!\n\n================================================\n\n");
 
    int result;
    /*
    result = main_wx(10,2);
    printf("\nmain_w2 10, 2 return code is %d\n\n================================================\n\n\n",result);
    
    result = main_wx(17,4);
    printf("\nmain_wx 17, 4 return code is %d\n\n================================================\n\n\n",result);
    */
    
    
    result = main_w2(10);
    printf("main_w2 return code is %d\n\n================================================\n\n\n",result);
    
    result = main_w2(16);
    printf("main_w2 return code is %d\n\n================================================\n\n\n",result);
    result = main_w2(22);
    printf("main_w2 return code is %d\n\n================================================\n\n\n",result);
    result = main_w2(28);
    printf("main_w2 return code is %d\n\n================================================\n\n\n",result);
    result = main_w2(34);
    printf("main_w2 return code is %d\n\n================================================\n\n\n",result);
    
    
    result = main_w4(17);
    printf("main_w4(17) return code is %d\n\n================================================\n\n\n",result);
    result = main_w4(21);
    printf("main_w4(21) return code is %d\n\n================================================\n\n\n",result);
    result = main_w4(25);
    printf("main_w4(25) return code is %d\n\n================================================\n\n\n",result);
    result = main_w4(29);
    printf("main_w4(29) return code is %d\n\n================================================\n\n\n",result);
    
    return 0;
}
