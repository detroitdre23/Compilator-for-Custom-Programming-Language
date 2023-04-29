#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct Element Element;
struct Element
{
    int Type,Nature;
    char Nom[100];
    Element *suivant;
};

typedef struct ListElts ListElts;
struct ListElts
{
    Element *premier;
};

ListElts *initialisation(char nom[100], int type, int nature)
{
    ListElts *liste = malloc(sizeof(*liste));
    Element *element = malloc(sizeof(*element));

    if (liste == NULL || element == NULL)
    {
        exit(EXIT_FAILURE);
    }
	element->Type = type;
    element->Nature = nature;
    strcpy(element->Nom,nom);
    element->suivant = NULL;
    liste->premier = element;
    return liste;
}


int insertion(ListElts *liste, char nom[100], int type, int nature)
{
	if(rechercherNom(liste,nom)==0)
    {
    Element *nouveau = malloc(sizeof(*nouveau));
    if (liste == NULL)
    {
        ListElts *ListeElements = initialisation(nom,type,nature);
    }
	else{
    nouveau->Type = type;
	nouveau->Nature = nature;
    strcpy(nouveau->Nom,nom);
    nouveau->suivant=NULL;
    Element *p= liste->premier;
    while (p->suivant != NULL)
    {
        p = p->suivant;
    }
    p->suivant=nouveau;
	}
	}
	else return 1;
	
}

ListElts rechercherNom(ListElts *liste, char nom[100])
{
    if (liste == NULL)
    {
        exit(EXIT_FAILURE);
    }

    Element *actuel = liste->premier;

    while (actuel!= NULL)
    {
        if(strcmpi(actuel->Nom,nom)==0)
        {
            return;
        }
		else actuel = actuel->suivant;
    }
	if (actuel== NULL) return 0;
	else return 1;

    }












