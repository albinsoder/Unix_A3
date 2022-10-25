#include <stdio.h>
#include <stdlib.h>
#include "calc3.h"
#include "y.tab.h"

static int lbl;

int ex(nodeType *p) {
    int lbl1, lbl2;

    if (!p) return 0;
    switch(p->type) {
    case typeCon:       
        printf("\tpushq\t$%d\n", p->con.value); 
        break;
    case typeId:        
        // printf("\tmovq\t%c, %rax\n", p->opr.op[0]->id.i + 'a');   
        // printf("\tmovq\t%c, %rdx\n", p->opr.op[1]->id.i + 'a');   
        break;
    case typeOpr:
        switch(p->opr.oper) {
        case WHILE:
            printf("\tpopq\tb\n");   
            printf("\tpopq\ta\n");   

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
            printf("\tmovq\t%c, %rdx\n", p->opr.op[0]->id.i+'a');
            printf("\tpushq\t%rbp\n");
            printf("\tleaq\tformat(%rip), %rdi\n");
            printf("\tmovq\t%rdx, %rsi\n");
            printf("\txorq\t%rax,  %rax\n");
            printf("\tcall\tprintf\n");
            printf("\tpopq\t%rbp\n");            
            break;
        case '=':       
            ex(p->opr.op[1]);
            // printf("\tpopq\t%c\n", p->opr.op[0]->id.i + 'a');
            break;
        case UMINUS:    
            ex(p->opr.op[0]);
            printf("\tneg\n");
            break;
	case FACT:
  	    ex(p->opr.op[0]);
	    printf("\tfact\n");
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
	    case GCD:   printf("\tgcd\n"); break;
            case '+':   printf("\tadd\n"); break;
            case '-':
            printf("\tmovq\t%c, %rax\n", p->opr.op[0]->id.i + 'a');   
            printf("\tmovq\t%c, %rdx\n", p->opr.op[1]->id.i + 'a');   
            printf("\tsubq\t%rdx, %rax\n"); 
            printf("\tmovq\t%rax, %c\n", p->opr.op[0]->id.i + 'a');   
            printf("\tmovq\t%rdx, %c\n", p->opr.op[1]->id.i + 'a');   
            break; 
            case '*':   printf("\tmul\n"); break;
            case '/':   printf("\tdiv\n"); break;
            case '<':   printf("\tcompLT\n"); break;
            case '>':
            printf("\tmovq\t%c, %rax\n", p->opr.op[0]->id.i + 'a');   
            printf("\tmovq\t%c, %rdx\n", p->opr.op[1]->id.i + 'a');   
            printf("\tcmpq\t%rax, %rdx\n"); 
            break;
            case GE:    printf("\tcompGE\n"); break;
            case LE:    printf("\tcompLE\n"); break;
            case NE:
            printf("\tmovq\t%c, %rax\n", p->opr.op[0]->id.i + 'a');   
            printf("\tmovq\t%c, %rdx\n", p->opr.op[1]->id.i + 'a');   
            printf("\tcmpq\t%rdx, %rax\n"); 
            break;
            case EQ:    printf("\tcompEQ\n"); break;
            }
        }
    }
    return 0;
}
