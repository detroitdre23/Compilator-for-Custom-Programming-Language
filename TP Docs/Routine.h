#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct node_t {
    char name[20];
    int type;
    int nature;
    struct node_t *next;
} Node;
/* Add a new node to linked list */
int add(Node *head,char name[20],int type,int nature) {
    Node *current_node = head;
    while ( current_node != NULL) {
    if(strcmp(current_node->name,name)==0)
    {
        
        return 0;
    }
    else current_node=current_node->next;
    }
    Node *new_node;
    new_node = (Node *) malloc(sizeof(Node));
    strcmp(new_node->name,name);
    new_node->nature = nature;
    new_node->type = type;
    new_node->next= head;
    head = new_node;
return 1;
}

/* Print all the elements in the linked list */
void print(Node *head) {
    Node *current_node = head;
   	while ( current_node != NULL) {
        printf("%s ", current_node->name);
        printf("%d ", current_node->type);
        printf("%d ", current_node->nature);
        current_node = current_node->next;
    }
}
void MsgDoubleDeclaration ()
{
    printf("Erreur semantique : Double declaration \n");
     _Exit(0);
}
void MsgDoubleDeclaration (int ligne, int col)
{
    printf("Erreur semantique : Double declaration . ligne : %d, colone %d\n",ligne,col);
     _Exit(0);
}