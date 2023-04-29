#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct element
{    char name[12];
     int type;
     int nature;
	 float val;
}element;
typedef struct ListElts * liste;
typedef struct ListElts
{     element data;
      liste suiv;
}ListElts;
int Search (liste l,char *c) 
{
    while (l != NULL)
    {
        if (strcmp(c,l->data.name)==0) return 1;
        l=l->suiv;
    }
    return 0;
}
int GetCst (liste l,char *c) 
{
    while (l != NULL)
    {
        if ((strcmp(c,l->data.name)==0) && (l->data.nature==1)) return 1;
        l=l->suiv;
    }
    return 0;
}

int Insert (liste *l, char *name,    int type,     int nature) 
{   
    liste L1,L2;
    if( Search(*l,name) == 0  ) 
        {
                L1=malloc(sizeof(ListElts));
                strcpy(L1->data.name,name);
                L1->data.type=type;
                L1->data.nature = nature;
				L1->data.val = 9999;
                L1->suiv= NULL;
                if (*l == NULL)
                    {
                          *l=L1;
                           return 1;
                    }
                else
                    {   L2=*l;
                        while(L2->suiv != NULL)
                            {
                                L2=L2->suiv;
                            }
                L2->suiv=L1;
                    }
            return 1;
        }
    else
            return 2;
  
}
int GetType (liste L,char *c) 
{   
   liste L1 = L;
   while (L1 != NULL)
    {
        if (strcmp(c,L1->data.name)==0) return L1->data.type;
		else L1=L1->suiv;
	}
	return -1;
}
int GetNature (liste L,char *c) 
{   
   liste L1 = L;
   while (L1 != NULL)
    {
        if (strcmp(c,L1->data.name)==0) return L1->data.nature;
		else L1=L1->suiv;
	}
	return -1;
}
int TypeVal (float f) 
{   
if (f-(int)f == 0) return 0;
else return 1;
}
void InsertType (liste L,int type,int posdeb)
{   
    liste L1 = L;
	int i=1;
	while(i<posdeb)
	{   
        L1=L1->suiv;
		i++;
    }
	while((L1!=NULL))
	{   
        L1->data.type = type;
        L1=L1->suiv;
    }
}
float GetVal (liste L,char* c)
{   
    
    liste L1 = L;
	while((L1!=NULL)&&(strcmp(c,L1->data.name)!=0))
	{   
        L1=L1->suiv;
    }
	return L1->data.val;
}
void InsertVal (liste L,char* c,float val)
{   
    
    liste L1 = L;
	while((L1!=NULL)&&(strcmp(c,L1->data.name)!=0))
	{   
        L1=L1->suiv;
    }
	L1->data.val=val;
}
void DisplayTable (liste L)
{   
			printf("\t\t     Symbol Table : \n\n");
			printf("Name\t\t Nature\t\t Type\t\t Value\n\n");
        while (L != NULL)
        {
		if(L->data.val==9999)
		{
		if(L->data.nature==0)
		{
			if(L->data.type==0) printf("%s\t\t Variable\t Integer\t Not Assigned\n", L->data.name);
			else printf("%s\t\t Variable\t Float\t\t Not Assigned\n", L->data.name);
		}
		else
		{
			if(L->data.type==0) printf("%s\t\t Constant\t Integer\t Not Assigned\n", L->data.name);
			else printf("%s\t\t Constant\t Float\t\t Not Assigned\n", L->data.name);
            
        }
		}
		else
		{
			if(L->data.nature==0)
		{
			if(L->data.type==0) printf("%s\t\t Variable\t Integer\t %d\n", L->data.name, (int)L->data.val);
			else printf("%s\t\t Variable\t Float\t\t %.2f\n", L->data.name, L->data.val);
		}
		else
		{
			if(L->data.type==0) printf("%s\t\t Constant\t Integer\t %d\n", L->data.name, (int)L->data.val);
			else printf("%s\t\t Constant\t Float\t\t %.2f\n", L->data.name, L->data.val);
            
        }
		}
		L=L->suiv;
}    
}