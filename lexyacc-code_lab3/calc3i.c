#include <stdio.h>
#include <stdlib.h>
#include "calc3.h"
#include "y.tab.h"

static int lbl;
static int con_count;
static int id_count;
static int eq_count;
static int flag;
int ex(nodeType *p) {
    int lbl1, lbl2;
    if (!p) return 0;
    switch(p->type) {
    case typeCon:
        if(con_count ==0){
            // push    %rbp
            // mov    %rsp, %rbp
            // sub    $16, %rsp

            printf("\tpush\t%rbp\n");
            printf("\tmov\t%rsp, %rbp\n");
            printf("\tsub\t$16, %rsp\n");
            // printf("\tenter\t $16, $0\n");
            printf("\tmovq\t$%d, %rax\n", p->con.value);   

        }else{
            printf("\tmovq\t$%d, %rdx\n", p->con.value);
        }
        con_count++;
        break;
    case typeId:

        if(id_count ==0){
            printf("\tmovq\t%c, %rax\n", p->id.i + 'a');   
            id_count++;

        }else if(id_count == 1){
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
            printf("\tmovq\t%rax, %rdx\n", p->opr.op[0]->id.i + 'a');
            // printf("\tpushq\t%rbp\n");
            printf("\tleaq\tformat(%rip), %rdi\n");
            printf("\tmovq\t%rdx, %rsi\n");
            printf("\txorq\t%rax,  %rax\n");
            printf("\tcall\tprintf\n");
            // printf("\tpopq\t%rbp\n");
            // printf("\tmovq\t%c, %rax\n", p->opr.op[0]->id.i + 'a');
            
            break;
        case '=':       
            ex(p->opr.op[1]);
            if(eq_count == 0){
                if(flag){
                    printf("%rdx, %rax\n");
                    flag=0;
                }
                printf("\tmovq\t%rax, %c\n", p->opr.op[0]->id.i + 'a');
            }else{
                if(flag){
                    printf("%rdx, %rax\n");
                    printf("\tmovq\t%rax, %c\n", p->opr.op[0]->id.i + 'a');
                    flag=0;
                }else{
                    printf("\tmovq\t%rdx, %c\n", p->opr.op[0]->id.i + 'a');

                }
            }
            eq_count++;
            if(eq_count>=2){
                eq_count=0;
            }
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
            case '+':   printf("\taddq\t");flag=1; break;
            case '-':   printf("\tsubq\t");flag=1; break; 
            case '*':   printf("\tmulq\t");flag=1; break;
            case '/':   printf("\tdivq\t");flag=1; break;
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
