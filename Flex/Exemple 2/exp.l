%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct Element Element;
struct Element
{
    int Taille;
    char Nom[100];
    Element *suivant;
};

typedef struct ListElts ListElts;
struct ListElts
{
    Element *premier;
};

ListElts *initialisation()
{
    int taille;
    char nom[100];
    ListElts *liste = malloc(sizeof(*liste));
    Element *element = malloc(sizeof(*element));

    if (liste == NULL || element == NULL)
    {
        exit(EXIT_FAILURE);
    }
    printf("Donner le 1er element : \n");
    printf("Nom : ");
    scanf("%s",nom);
    taille=strlen(nom);
    element->Taille = taille;
    strcpy(element->Nom,nom);
    element->suivant = NULL;
    liste->premier = element;
    return liste;
}


void insertion(ListElts *liste, char nom[100], int taille)
{
    Element *nouveau = malloc(sizeof(*nouveau));
    if (liste == NULL || nouveau == NULL)
    {
        exit(EXIT_FAILURE);
    }
    nouveau->Taille = taille;
    strcpy(nouveau->Nom,nom);
    nouveau->suivant=NULL;
    Element *p= liste->premier;
    while (p->suivant != NULL)
    {
        p = p->suivant;
    }
    p->suivant=nouveau;
}


void afficherListe(ListElts *liste)
{
    if (liste == NULL)
    {
        exit(EXIT_FAILURE);
    }

    Element *actuel = liste->premier;

    while (actuel->suivant != NULL)
    {
        printf("Nom : %s, Taille : %d", actuel->Nom, actuel->Taille);
        printf(" -> ");
        actuel = actuel->suivant;
    }
    printf("Nom : %s, Taille : %d", actuel->Nom, actuel->Taille);
    }
%}
%option noyywrap
%%
%%
int main()
{
    int nbr,taille;
    char nom[100];
    printf("Entrer le nombre d'elements : ");
    scanf("%d", &nbr);
    if(nbr!=0)
    {
    ListElts *ListeElements = initialisation();
    for(int i=1; i<nbr; i++){
    printf("Donner le %deme element: \n", i+1);
    printf("Nom : ");
    scanf("%s",nom);
    taille=strlen(nom);
    insertion(ListeElements, nom, taille);
    }
    afficherListe(ListeElements);
    }

    return 0;
}