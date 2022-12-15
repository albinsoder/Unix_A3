#include <stdio.h>
#include <stdlib.h>
#include "calc3.h"
#include "y.tab.h"

static int lbl;
static int con_count;
static int id_count;
static int eq_count;
static int flag;
static char arg[5];

int ex(nodeType *p) {
    int lbl1, lbl2;
    if (!p) return 0;
    switch(p->type) {
    case typeCon:
        printf("\tpushq\t$%d\n", p->con.value);

        break;
    case typeId:
        printf("\tpushq\t%c\n", p->id.i + 'a');

        break;
    case typeOpr:
        switch(p->opr.oper) {
        case WHILE:
            printf("L%03d:\n", lbl1 = lbl++);
            lbl2 = lbl;
            ex(p->opr.op[0]);
            // printf("tjmp\\tL%03d\n", lbl2 = lbl++);
            ex(p->opr.op[1]);
            printf("\tjmp\tL%03d\n", lbl1);
            printf("L%03d:\n", lbl2);
            break;
        case IF:
            lbl1 = lbl;
            // printf("L%03d:\n", lbl1 = lbl++);
            ex(p->opr.op[0]);
            if (p->opr.nops > 2) {
                /* if else */
                // printf("\tjmp\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                printf("\tjmp\tL%03d\n", lbl2 = lbl++);
                printf("L%03d:\n", lbl1);
                ex(p->opr.op[2]);
                printf("L%03d:\n", lbl2);
            } else {
                /* if */
                // printf("\tjmp\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                printf("L%03d:\n", lbl1);
            }
            break;
        case PRINT:     
            ex(p->opr.op[0]);
            printf("\tpopq\t%rdx\n");
            printf("\tpushq\t%rbp\n");
            //load pointer of string to rdi
            printf("\tleaq\tresult(%rip), %rdi\n");
            //move value to print to rsi
            printf("\tmovq\t%rdx, %rsi\n");
            //zero rax
            printf("\txorq\t%rax,  %rax\n");
            //print
            printf("\tcall\tprintf\n");
            printf("\tpopq\t%rbp\n");
            
            break;
        case '=':       
            ex(p->opr.op[1]);
            printf("\tpopq\t%c\n", p->opr.op[0]->id.i + 'a');
            break;
        case UMINUS:    
            ex(p->opr.op[0]);
            printf("\tpopq\t%rdi\n");
            printf("\tnegq\t%rdi\n");
            printf("\tpushq\t%rdi\n");

            break;
        case FACT:
            ex(p->opr.op[0]);
            printf("\tpopq\t%c\n", p->opr.op[0]->id.i + 'a');
            printf("\tpushq\t%c\n", p->opr.op[0]->id.i + 'a');
            ex(p->opr.op[0]);
            // printf("\tpushq\t%c\n", p->opr.op[0]->id.i + 'a');

            // printf("\tpopq\t%c\n", p->opr.op[0]->id.i + 'a');

            // move value to another register
            printf("\tpopq\t%r10\n");   
            printf("\tpopq\t%r11\n");   
            //sub 1 to get next of fact
            printf("\tsubq\t$1, %r10\n");
            //check if 0! = 1
            printf("\tcmpq\t$0, %r10\n");
            //if 0!
            printf("\tjle\tzero%03d\n", lbl1 = lbl++);
            //else
            printf("\tjmp\tfact%03d\n", lbl1);
            ex(p->opr.op[0]);

            //fact loop, mult n1*n2 til n1=0
            printf("fact%03d:\n", lbl1);

            printf("\tcmpq\t$0, %r10\n");
            printf("\tje\tprint%03d\n", lbl1);
            printf("\timulq\t%r10, %r11\n");
            printf("\tsubq\t$1, %r10\n");
            printf("\tjmp\tfact%03d\n", lbl1);
            //0!
            printf("zero%03d:\n", lbl1); 
            printf("\tmovq\t$1, %r11\n");
            //print
            printf("print%03d:\n", lbl1);
            printf("\tpushq\t%r11\n");
            break;

        case LNTWO:
            ex(p->opr.op[0]);
            printf("\lntwo\n");
            printf("\tntwo\n");
            break;
            default:
        ex(p->opr.op[0]);
        ex(p->opr.op[1]);
        switch(p->opr.oper) {
            case GCD:   
                printf("\tpopq\t%rax\n");
                // printf("\tpopq\t%r11\n");
                break;
            case '+':
                printf("\tpopq\t%r10\n");   
                printf("\tpopq\t%r11\n");   
                printf("\taddq\t%r10,%r11\n");
                printf("\tpushq\t%r11\n");
                break;
            case '-':   
                printf("\tpopq\t%r10\n");   
                printf("\tpopq\t%r11\n");   
                printf("\tsubq\t%r10,%r11\n");
                printf("\tpushq\t%r11\n");
                break; 
            case '*':
                printf("\tpopq\t%r10\n");   
                printf("\tpopq\t%r11\n");     
                printf("\timulq\t%r10, %r11\n"); 
                printf("\tpushq\t%r11\n");

                break;
            case '/':   
                printf("\tpopq\t%rbx\n");
                printf("\tpopq\t%rax\n");
                printf("\txorq\t%rdx, %rdx\n");
                printf("\tidivq\t%rbx\n");
                printf("\tpushq\t%rax\n"); 
                break;
            case '<':   
                printf("\tpopq\t%r10\n");   
                printf("\tpopq\t%r11\n");      
                printf("\tcmpq\t%r10, %r11\n"); 
                printf("\tjge\tL%03d\n", lbl2 = lbl++);
                break;
            case '>':
                printf("\tpopq\t%r10\n");   
                printf("\tpopq\t%r11\n");      
                printf("\tcmpq\t%r10, %r11\n"); 
                printf("\tjle\tL%03d\n", lbl2 = lbl++);
                break;             
            case GE:    
                printf("\tpopq\t%r10\n");   
                printf("\tpopq\t%r11\n");      
                printf("\tcmpq\t%r10, %r11\n"); 
                printf("\tjl\tL%03d\n", lbl2 = lbl++);
                break;
            case LE:    
                printf("\tpopq\t%r10\n");   
                printf("\tpopq\t%r11\n");      
                printf("\tcmpq\t%r10, %r11\n"); 
                printf("\tjg\tL%03d\n", lbl2 = lbl++);
                break;
            case NE:    
                printf("\tpopq\t%r10\n");   
                printf("\tpopq\t%r11\n");      
                printf("\tcmpq\t%r10, %r11\n"); 
                printf("\tje\tL%03d\n", lbl2 = lbl++);
                break;
            case EQ:    
                printf("\tpopq\t%r10\n");   
                printf("\tpopq\t%r11\n");      
                printf("\tcmpq\t%r10, %r11\n"); 
                printf("\tjne\tL%03d\n", lbl2 = lbl++); 
                break;
                }
            }
        }
    return 0;
}
// strcpy(arg,"idivq");flag=1