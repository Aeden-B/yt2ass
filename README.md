# yt2ass
Converting Youtube Karaoke Subtitles for Aegisub
(Mostly Hololive subtitles)

To install :
- Add youtube-converter.lua in autoload aegisub folder

(French Below / Français en dessous)

Steps to follow :
- To install the script, copy it to the autoload folder of aegisub
- get the srv3 via youtube-dl or the youtube api cf https://github.com/arcusmaximus/YTSubConverter#reverse-conversion
- convert to ass via `YTSubConverter [name of srv3].srv3 [name of desired ass].ass`
- Open in Aegisub, menu "Subtitle", "Sort all styles", "Style name"
- Select and delete all lines with YTSoftShadow style
- menu "Edit", "Find and replace" in find put this regexp `(?!\{\\c&HD9D9D9&\})\{[^\}]*\}` with the tag serving as a color change in my case it is HD9D9D9, check "Use regular expressions" and click on replace all to remove all other useless tags.
- Delete translation lines if present
- select all the lines, menu "automation", "Youtube Converter"

NB: The lines which concern the same sentence must be consecutive otherwise the script cannot concatenate. 

Etapes à suivre :
- Pour installer le script, le copier dans le dossier autoload de aegisub
- récupérer le srv3 via youtube-dl ou l'api youtube cf https://github.com/arcusmaximus/YTSubConverter#reverse-conversion
- convertir en ass via `YTSubConverter [nom du srv3].srv3 [nom du ass voulu].ass`
- Ouvrir dans Aegisub, menu "Sous-titre", "Trier toutes les styles", "Nom du style"
- Sélectionner et supprimer toutes les lignes ayant le style YTSoftShadow
- menu "Edition", "Chercher et remplacer" dans chercher mettre cette regexp `(?!\{\\c&HD9D9D9&\})\{[^\}]*\}` avec le tag servant de changement de coloration dans mon cas c'est HD9D9D9, cocher "Utiliser des expressions régulières" et cliquer sur remplacer tout pour supprimer toutes les autres balises inutiles.
- Supprimer les lignes de traduction si présentes
- sélectionner toutes les lignes, menu "automatisme", "Youtube Converter"

NB : Il faut que les lignes qui concernent une même phrase soit à la suite sinon le script n'arrive pas à faire la concaténation.
