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
        if(!con_count){
            //switch between rax and rdx for constants
            printf("\tmovq\t$%d, %rax\n", p->con.value);   
            con_count++;

        }else{
            printf("\tmovq\t$%d, %rdx\n", p->con.value);
            con_count = 0;

        }
        break;
    case typeId:
        //switch between rax and rdx for id
        if(!id_count){
            printf("\tmovq\t%c, %rax\n", p->id.i + 'a');   
            id_count++;

        }else if(id_count){
            printf("\tmovq\t%c, %rdx\n", p->id.i + 'a');   
            id_count =0;

        }
        break;
    case typeOpr:
        switch(p->opr.oper) {
        case WHILE:
            printf("L%03d:\n", lbl1 = lbl++);
            ex(p->opr.op[0]);
            printf("\tje\tL%03d\n", lbl2 = lbl++);
            ex(p->opr.op[1]);
            printf("\tjmp\tL%03d\n", lbl1);
            printf("L%03d:\n", lbl2);
            break;
        case IF:
            ex(p->opr.op[0]);
            if (p->opr.nops > 2) {
                /* if else */
                printf("\tjg\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                printf("\tjmp\tL%03d\n", lbl2 = lbl++);
                printf("L%03d:\n", lbl1);
                ex(p->opr.op[2]);
                printf("L%03d:\n", lbl2);
            } else {
                /* if */
                printf("\tjz\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                printf("L%03d:\n", lbl1);
            }
            break;
        case PRINT:     
            ex(p->opr.op[0]);
            printf("\tmovq\t%rax, %rdx\n");
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
            if(!eq_count){
                //if sub or add was used for instance
                if(flag){
                    //print arg =sub,add etc. 
                    printf("\t%s\t%rdx, %rax\n", arg);
                    flag=0;
                }
                //move back value to id
                printf("\tmovq\t%rax, %c\n", p->opr.op[0]->id.i + 'a');
                eq_count++;
            }else{
                if(flag){
                    printf("\t%s\t%rdx, %rax\n", arg);
                    printf("\tmovq\t%rax, %c\n", p->opr.op[0]->id.i + 'a');
                    flag=0;
                }else{
                    printf("\tmovq\t%rdx, %c\n", p->opr.op[0]->id.i + 'a');

                }
                eq_count=0;
            }
            break;
    case UMINUS:    
        ex(p->opr.op[0]);
        printf("\tneg\n");
        break;
    case FACT:
        ex(p->opr.op[0]);
        //move value to another register
        printf("\tmovq\t%rax, %rdi\n");
        //sub 1 to get next of fact
        printf("\tsubq\t$1, %rdi\n");
        //check if 0! = 1
        printf("\tcmpq\t$0, %rdi\n");
        //if 0!
        printf("\tjle\tzero%03d\n", lbl1 = lbl++);
        //else
        printf("\tjmp\tfact%03d\n", lbl1);

        //fact loop, mult n1*n2 til n1=0
        printf("fact%03d:\n", lbl1);
        printf("\tcmpq\t$0, %rdi\n");
        printf("\tje\tprint%03d\n", lbl1);
        printf("\timulq\t%rdi, %rax\n");
        printf("\tsubq\t$1, %rdi\n");
        printf("\tjmp\tfact%03d\n", lbl1);
        //0!
        printf("zero%03d:\n", lbl1); 
        printf("\tmovq\t$1, %rax\n");
        //print
        printf("print%03d:\n", lbl1);
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
        case GCD:   break;
        case '+':   strcpy(arg,"addq");flag=1; break;
        case '-':   strcpy(arg,"subq");flag=1; break; 
        case '*':   strcpy(arg,"mulq");flag=1; break;
        case '/':   strcpy(arg,"divq");flag=1; break;
        case '<':   printf("\tcompLT\n"); break;
        case '>':   printf("\tcmpq\t%rax, %rdx\n"); break;
        case GE:    printf("\tcmpq\t%rax, %rdx\n"); break;
        case LE:    printf("\tcompLE\n"); break;
        case NE:    printf("\tcmpq\t%rdx, %rax\n"); break;
        case EQ:    printf("\tcompEQ\n"); break;
            }
        }
    }
    return 0;
}
