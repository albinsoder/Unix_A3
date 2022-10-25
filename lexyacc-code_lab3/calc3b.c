#include <stdio.h>
#include "calc3.h"
#include "y.tab.h"

static int lbl;
static char a[5];
static char b[5];

int ex(nodeType *p) {
    int lbl1, lbl2;

    // printf("HEJ %d", p->con.value);
    if (!p) return 0;
    switch(p->type) {
    case typeCon:
        printf("\tpushq\t$%d\n", p->con.value); 


        break;
    case typeId:
        // printf("\tpush\t%c\n", p->id.i+ 'a'); 
        if(p->id.i+'a' == 'a'){
            printf("\tmovq\t%c, %rax\n", p->id.i+ 'a');
            // strcpy(a, p->id.i+'a'); 
        }
        else {
            printf("\tmovq\t%c, %rdx\n", p->id.i+ 'a'); 
            // strcpy(b, p->id.i+'a'); 
        }


        // ex(p->id.i +'a');
        break;
    case typeOpr:
        switch(p->opr.oper) {
        case WHILE:
            // printf("\tmovq\t%s, %rax\n", a); 
            // printf("\tmovq\t%s, %rdx\n", b); 

            printf("L%03d:\n", lbl1 = lbl++);
            // printf("\tmovq\t%c, %rax\n", p->id.i); 
            // printf("\tmovq\t%c, %rdx\n", p->id.i); 
            ex(p->opr.op[0]);

            printf("\t%rdx, %rax\n");
            printf("\tje\tL%03d\n", lbl2 = lbl++);
            ex(p->opr.op[1]);
            printf("\tjmp\tL%03d\n", lbl1);
            printf("L%03d:\n", lbl2);
            break;
        case IF:
            ex(p->opr.op[0]);
            if (p->opr.nops > 2) {
                /* if else */
                printf("\t%rdx, %rax");
                printf("\n\tjg\tL%03d\n", lbl1 = lbl++);
                ex(p->opr.op[1]);
                // printf("\tmovq\t%rdx, b\n");
                // printf("\tmovq\t%rax, a\n");

                printf("\tjmp\tL%03d\n", lbl2 = lbl++);
                printf("L%03d:\n", lbl1);

                // printf("\tmovq\tb, %rax\n");
                // printf("\tmovq\ta, %rdx\n");
                ex(p->opr.op[2]);

                // printf("\tmovq\t%rax, b\n");
                // printf("\tmovq\t%rdx, a\n");
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
            printf("\tleaq\tformat(%rip), %rdi\n");
            printf("\tmovq\t%rdx, %rsi\n");
            printf("\txorq\t%rax,  %rax\n");
            printf("\tcall\tprintf\n");
            printf("\tpopq\t%rbp\n");
            break;
        case '=':
            ex(p->opr.op[1]);
            // printf("\tmovq\t");
            printf("\tpopq\t%c\n", p->opr.op[0]->id.i+'a');
            
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
	    break;
        default:
            ex(p->opr.op[0]);
            ex(p->opr.op[1]);
            switch(p->opr.oper) {
	    case GCD:   printf("\tgcd\n"); break;
            case '+':   printf("\taddq\n"); break;
            case '-':   printf("\tsubq\n"); break; 
            case '*':   printf("\tmulq\n"); break;
            case '/':   printf("\tdivq\n"); break;
            case '<':   printf("\tcmpq"); break;
            case '>':   printf("\tcmpq"); break;
            case GE:    printf("\tcmpq"); break;
            case LE:    printf("\tcmpq"); break;
            case NE:    printf("\tcmpq"); break;
            case EQ:    printf("\tcmpq"); break;
            }
        }
    }
    return 0;
}
