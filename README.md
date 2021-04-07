# IOSproject Tristan BONNEAU, Tristan ESTEBAN; Quentin PAGNEUX, Etienen YGORRA
Bienvenue sur notre application.
Comme vous allez pouvoir le constater au lancement de l'application une page est directement affiché, 
c'est celle des tous les evenements. Si vous cliquez sur l'un des evenements vous pourrez afficher toutes les 
information lié à ce dernier.
Il y a aussi deux autres petits onglets en bas Attendees/Speakers et sur l'autre Sponsors.
Sur l'onglet Attendees/Speakers vous pourrez retrouver la liste de l'ensemble des personnes presententes 
aux evenements ainsi que des informations les concernants(Role, Nom, numéro,email, compagny et le lieu où cette personne parle) 
Sur le derniers onglets vous pourrez retrouver l'ensemble des entreprises sponsorisant les evenements ainsi que des informations les concernants.

## Nos fonctions principal :
- getData : Cette fonction prend en paramètre une url, via cette url elle va récupérer de la data JSON, ensuite nous allons convertir ces donnée JSON dans un objet que nous avons défini dans des structs qui correspondent exactement au data JSON. Mais certaine des données étaient des id, nous avons donc du faire une fonction getDataName
- getDataName : qui va prendre l'id en parametre pour pouvoir faire des liens url à l'api avec les id dedans qui nous permettent d'obtenir le même type de data mais de l'id en question. Une fois que nous avons récupéré ce que nous voulions (par exemple le nom d'une personne), nous allons remplacer l'id de cette personne par son nom dans l'objet.
- Une fois notre objet complet et bien set, nous allons l'afficher dans nos cell.

Welcome to our application.
As you can see when you launch the application, a page is directly displayed, 
it is the one of all the events. If you click on one of the events you will be able to display all the 
information related to it.
There are also two other small tabs at the bottom Attendees/Speakers and on the other Sponsors.
On the Attendees/Speakers tab you will be able to find a list of all the people present at the events 
and information about them (Role, Name, number, email, company and the place where this person speaks) 
On the last tab you can find all the companies sponsoring the events and information about them.


私たちのアプリケーションへようこそ。
アプリケーションを起動すると、ご覧の通り、ページが直接表示されます。
それはすべてのイベントの1つです。イベントをクリックすると、すべての情報が表示されます。
に関連する情報を提供します。
また、一番下の「Attendees/Speakers」と、もう一つの「Sponsor」にも、2つの小さなタブがあります。
Attendees/Speakersタブでは、イベントに出席しているすべての人のリストを見ることができます。
役割、名前、番号、メール、会社、この人が話す場所）。
最後のタブでは、イベントに協賛しているすべての企業とその情報を見ることができます。
