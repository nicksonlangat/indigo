��    7      �  I   �      �     �     �     �  	               �   %     �     �     �               0     F  "   N     q     x     �  �   �  U  -    �  �   �	  I  c
    �  �   �  _  �  �     v      y  �   �         +     C  %   \     �     �     �     �     �  "   �            I  !  �  k     +     0     9     A  ;   I  W   �  v   �  P   T  /   �  j   �    @      W     x     �  	   �     �     �  �   �     �     �     �     �  /   �  '        4  5   <  	   r     |     �  �   �  �  R  :  �   �   /"  �  (#  N  �$    �%  �  '    �(  �  �)  R  �+  �   �,  W  �-     �.     /  &   "/     I/     `/     x/     �/     �/  &   �/     �/     �/  �  �/  )  �1     �3  
   �3     �3     �3  G   �3  t   .4  �   �4  h   65  ?   �5  �   �5               0             (   +   	                                3      &             
      .      )       *   '   1   ,   6                          !      $   5                2   "           %               #                         /   7   4   -           %(type)s %(number)s of %(year)s %s (about to be imported) 'Commences on' date missing (unknown) Act Apply amendment Apply the amendments made by %(amending_title)s (%(numbered_title)s) on %(date)s.

The amendment has already been linked, so start at Step 3 of https://docs.laws.africa/managing-works/amending-works. Article By-law Chapter Chapter %(cap)s Check / update primary work Check / update repeal English Error talking to Google Sheets: %s French Government Notice Import content Import the content for this work – either the initial publication (usually a PDF of the Gazette) or a later consolidation (usually a .docx file). It looks like this work amends "%(amended_work)s" (see row %(row_num)s of the spreadsheet), but it couldn't be linked automatically.

Possible reasons:
– a typo in the spreadsheet
– more than one amended work was listed (it only works if there's one)
– the amended work doesn't exist on the system.

Please link the amendment manually. It looks like this work amends %(amended_title)s (%(numbered_title)s), but it couldn't be linked automatically because this work hasn't commenced yet (so there's no date for the amendment).

Please link the amendment manually (and apply it) when this work comes into force. It looks like this work commences "%(commences)s" (see row %(row_num)s of the spreadsheet), but 'commences_on_date' wasn't given so no action has been taken.

If it should be linked, please do so manually. It looks like this work commences "%(commences)s" on %(date)s (see row %(row_num)s of the spreadsheet), but "%(commences)s" wasn't found, so no action has been taken.

Possible reasons:
– a typo in the spreadsheet
– the commenced work doesn't exist on the system.

If the commencement should be linked, please do so manually. It looks like this work has subleg "%(subleg)s" (see row %(row_num)s of the spreadsheet), but it couldn't be linked automatically.

Possible reasons:
– a typo in the spreadsheet
– the subleg work doesn't exist on the system.

Please link the subleg work manually. It looks like this work has the following taxonomy: "%(topics)s" (see row %(row_num)s of the spreadsheet), but it couldn't be linked automatically.

Possible reasons:
– a typo in the spreadsheet
– the taxonomy doesn't exist on the system. It looks like this work is amended by "%(amending_work)s" (see row %(row_num)s of the spreadsheet), but it couldn't be linked automatically.

Possible reasons:
– a typo in the spreadsheet
– more than one amending work was listed (it only works if there's one)
– the amending work doesn't exist on the system.

Please link the amendment manually. It looks like this work repeals %(title)s (%(numbered_title)s), but it couldn't be linked automatically because this work hasn't commenced yet (so there's no date for the repeal).

Please link the repeal manually when this work comes into force. It looks like this work was commenced by "%(commenced_by)s" on %(date)s (see row %(row_num)s of the spreadsheet), but it couldn't be linked automatically. This work has thus been recorded as 'Not commenced'.

Possible reasons:
– a typo in the spreadsheet
– the commencing work doesn't exist on the system.

Please link the commencement date and commencing work manually. It looks like this work was repealed by "%(repealed_by)s" (see row %(row_num)s of the spreadsheet), but it couldn't be linked automatically.

Possible reasons:
– a typo in the spreadsheet
– the repealing work doesn't exist on the system.

Please link the repeal manually. It looks like this work was repealed by %(title)s (%(numbered_title)s), but it couldn't be linked automatically.

Please link it manually. It looks like this work's primary work is "%(work)s" (see row %(row_num)s of the spreadsheet), but it couldn't be linked automatically.

Possible reasons:
– a typo in the spreadsheet
– the primary work doesn't exist on the system.

Please link the primary work manually. Link amendment (active) Link amendment (passive) Link amendment (pending commencement) Link commencement (active) Link commencement (passive) Link gazette Link primary work Link repeal Link repeal (pending commencement) Link subleg Link taxonomy On the spreadsheet (see row %(row_num)s), it says that this work is subleg under %(title)s (%(numbered_title)s).

But this work is already subleg under %(parent)s, so nothing was done.

Double-check which work this work is subleg of and update it manually if needed. If the spreadsheet was wrong, cancel this task with a comment. On the spreadsheet (see row %(row_num)s), it says that this work was repealed by %(repealing_title)s (%(repealing_numbered_title)s).

But this work is already listed as having been repealed by %(repealed_by)s (%(repealed_by_numbered_title)s), so the repeal information wasn't updated automatically.

If the old / existing repeal information was wrong, update it manually. Otherwise (if the spreadsheet was wrong), cancel this task with a comment.
 Part Preamble Preface Section There doesn't appear to be data in sheet %(name)s of %(id)s There is not enough text in the document to import. You may need to OCR the file first. This work's gazette (original publication document) couldn't be linked automatically.

Find it and upload it manually. Unable to access spreadsheet. Is the URL correct and have you shared it with %s? We couldn't get any useful text out of the file Your sheet did not import successfully; please check that you have link sharing ON (Anyone with the link). Project-Id-Version: 6dbd8a386c58cbb3cf8bf6a67e82186a
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2022-06-30 08:18
Last-Translator: Greg Kempe (longhotsummer)
Language-Team: French
Language: fr_FR
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=2; plural=(n > 1);
X-Generator: crowdin.com
X-Crowdin-Project: 6dbd8a386c58cbb3cf8bf6a67e82186a
X-Crowdin-Language: fr
X-Crowdin-File: /master/indigo/locale/af/LC_MESSAGES/django.po
X-Crowdin-Project-ID: 2
X-Crowdin-File-ID: 12
 %(type)s %(number)s sur %(year)s %s (vers être importé) Il manque une date de début (inconnu) Agir Appliquer la modification Appliquer les modifications apportées par %(amending_title)s (%(numbered_title)s) le %(date)s.

L'amendement a déjà été lié, alors commencez à l'étape 3 de https://docs.laws.africa/managing-works/amending-works. Article Règle Chapitre Chapitre %(cap)s Vérifier / mettre à jour le travail principal Vérifier / mettre à jour l'abrogation Anglais Erreur lors de la conversation avec Google Sheets: %s Français Avis du Gouvernement Importer du contenu Importez le contenu de ce travail – soit la publication initiale (généralement un PDF de la Gazette) ou une consolidation ultérieure (généralement un fichier .docx). Il semble que ce travail modifie "%(amended_work)s" (voir la ligne %(row_num)s de la feuille de calcul), mais il ne peut pas être lié automatiquement.

Raisons possibles :
– une faute de frappe dans la feuille de calcul
– plus d'une œuvre modifiée a été répertoriée (elle ne fonctionne que s'il y en a une)
– le travail modifié n'existe pas sur le système.

Veuillez lier la modification manuellement. On dirait que cette œuvre modifie %(amended_title)s (%(numbered_title)s), mais il ne peut pas être lié automatiquement parce que ce travail n'a pas encore commencé (donc il n'y a pas de date pour l'amendement).

Veuillez lier la modification manuellement (et l'appliquer) lorsque ce travail entrera en vigueur. On dirait que cette œuvre commence «%(commences)s» (voir la ligne %(row_num)s de la feuille de calcul), mais 'commences_on_date' n'a pas été donné, donc aucune action n'a été prise.

Si elle doit être liée, veuillez le faire manuellement. On dirait que cette œuvre commence «%(commences)s» sur %(date)s (voir la ligne %(row_num)s de la feuille de calcul), mais "%(commences)s" n'a pas été trouvé, donc aucune action n'a été prise.

Raisons possibles :
– une faute de frappe dans la feuille de calcul
– le travail commencé n’existe pas sur le système.

Si le début doit être lié, veuillez le faire manuellement. Il semble que ce travail ait un subleg "%(subleg)s" (voir la ligne %(row_num)s de la feuille de calcul), mais il ne peut pas être lié automatiquement.

Raisons possibles :
– une faute de frappe dans la feuille de calcul
– le travail de sous-branche n'existe pas sur le système.

Veuillez lier le travail de subleg manuellement. On dirait que cette œuvre a la taxonomie suivante : "%(topics)s" (voir la ligne %(row_num)s de la feuille de calcul), mais il ne peut pas être lié automatiquement.

Raisons possibles :
– une faute de frappe dans la feuille de calcul
– la taxonomie n'existe pas sur le système. Il semble que cette œuvre soit modifiée par "%(amending_work)s" (voir la ligne %(row_num)s de la feuille de calcul), mais elle ne peut pas être liée automatiquement.

Raisons possibles :
– une faute de frappe dans la feuille de calcul
– plus d'une œuvre rectificative a été listée (elle ne fonctionne que s'il y en a une)
– le travail modificatif n'existe pas sur le système.

Veuillez lier la modification manuellement. On dirait que ce travail abroge %(title)s (%(numbered_title)s), mais il ne peut pas être lié automatiquement parce que ce travail n'a pas encore commencé (donc il n'y a pas de date pour l'abrogation).

Veuillez lier l'abrogation manuellement lorsque ce travail entre en vigueur. On dirait que cette œuvre a été commencée par "%(commenced_by)s" sur %(date)s (voir la ligne %(row_num)s de la feuille de calcul), mais il ne peut pas être lié automatiquement. Ce travail a donc été enregistré comme "Non commencé".

Raisons possibles :
– une faute de frappe dans la feuille de calcul
– le début du travail n'existe pas sur le système.

Veuillez lier la date de début et le début des travaux manuellement. Il semble que ce travail ait été abrogé par "%(repealed_by)s" (voir la ligne %(row_num)s de la feuille de calcul), mais il ne peut pas être relié automatiquement.

Raisons possibles :
– une faute de frappe dans la feuille de calcul
– le travail d'abrogation n'existe pas sur le système.

Veuillez lier l'abrogation manuellement. Il semble que ce travail ait été abrogé par %(title)s (%(numbered_title)s), mais il ne peut pas être lié automatiquement.

Veuillez le lier manuellement. Il semble que le travail principal de cette œuvre soit "%(work)s" (voir la ligne %(row_num)s de la feuille de calcul), mais il ne peut pas être lié automatiquement.

Raisons possibles :
– une faute de frappe dans la feuille de calcul
– le travail principal n'existe pas sur le système.

Veuillez lier le travail principal manuellement. Amendement du lien (actif) Amendement du lien (passif) Amendement du lien (début en attente) Début du lien (actif) Début du lien (passif) Lier la gazette Lier le travail principal Abrogation du lien Abrogation du lien (début en attente) Lier le sous-segment Link taxonomy Sur la feuille de calcul (voir la ligne %(row_num)s), il est dit que cette œuvre est sublime sous %(title)s (%(numbered_title)s).

Mais ce travail est déjà sublime en dessous de %(parent)s, donc rien n'a été fait.

Double-vérifier quel travail ce travail est subleg de et le mettre à jour manuellement si nécessaire. Si la feuille de calcul était incorrecte, annulez cette tâche avec un commentaire. Sur la feuille de calcul (voir la ligne %(row_num)s), il est dit que cette œuvre a été abrogée par %(repealing_title)s (%(repealing_numbered_title)s).

Mais ce travail est déjà répertorié comme ayant été abrogé par %(repealed_by)s (%(repealed_by_numbered_title)s), les informations d'abrogation n'ont donc pas été mises à jour automatiquement.

Si les informations d'abrogation antérieures ou existantes sont erronées, mettez à jour manuellement. Sinon, si la feuille de calcul est incorrecte, annulez cette tâche avec un commentaire.
 Pièce Préambule Préface Section Il ne semble pas y avoir de données dans la feuille %(name)s de %(id)s Il n'y a pas assez de texte dans le document pour l'importation. Vous pouvez avoir besoin de OCR le fichier d'abord. La gazette de ce travail (document de publication original) ne peut pas être liée automatiquement.

Trouvez-la et téléchargez-la manuellement. Impossible d'accéder à la feuille de calcul. L'URL est-elle correcte et l'avez-vous partagée avec %s? Nous n'avons pas pu obtenir de texte utile à partir du fichier Votre feuille n'a pas été importée avec succès ; veuillez vérifier que vous avez le partage de liens activé. (Quiconque avec le lien). 