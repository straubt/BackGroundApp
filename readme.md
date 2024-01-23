LazyVGrid:
Ce composant permet d'afficher du contenu (vertical grid) de manière asyncrone, dans notre cas, la grid ne se mettra a jour lorsque les images seront chragées. 

On utilise des collones flexibles:
 les collones fixes, ne s'adaptent jamais, et si il n'y a pas assez d'espace, la taille peut aller jusqu'en dehors de l'écran.
 les collones flexibles, restent tant que possible dans les mesures définies par min et max  (.flexible(minimum: , maximum:))
 et si il n'y a pas assez d'espace, elles créent une nouvelle ligne .

 
