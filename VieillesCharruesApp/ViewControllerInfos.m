//
//  ViewControllerInfos.m
//
//  Created by ToM on 30/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerInfos.h"
#import "TableVIewControllerPartenaires.h"

@implementation ViewControllerInfos

-(void) viewDidLoad
{
	[webView loadHTMLString:@"<html style=\"font-family:verdana\">\
	 <h5>Animaux</h5>\
	 <p>Les animaux de compagnies ne sont pas admis sur le site, ni dans les campings.</p>\
	 \
	 <h5>DAB</h5>\
	 <p>Des distributeurs à billets situées à l’intérieur et à l’extérieur de l’enceinte seront accessibles aux festivaliers.</p>\
	 \
	 <h5>Enfants</h5>\
	 <p>L’entrée est gratuite pour les enfants de moins de 8 ans. Un \"champignon rouge\" à l’intérieur du site, au milieu de la Garenne, recueillera les enfants égarés.</p>\
	 \
	 <h5>Handicapés</h5>\
	 <p>Les personnes handicapées sont les bienvenues. Un parking à proximité du site leur est réservé. L’accès est réglementé par un pass véhicule\" handicapés \". Le festival dispose d’une plateforme destinée aux fauteuils roulants près de la grande scène ainsi que de WC aménagés. Pour toute information concernant les accès handicapés, merci de contacter le : 02 98 99 25 45<br/>\
	 ou par mail : accueil handicapé</p>\
	 \
	 <h5>Horaires d'ouvertures des portes</h5>\
	 <p>Jeudi 15 juillet : 16h30<br/>\
	 Vendredi 16 juillet : 15h<br/>\
	 Samedi 17 juillet : 14h30<br/>\
	 Dimanche 18 juillet : 13h30<br/></p>\
	 \
	 <h5>Horaires d'ouverture du Verger</h5>\
	 <p>Vendredi 16 juillet 2010 : 16h16 à 22h22<br/>\
	 Samedi 17 juillet 2010 : 16h02 à 22h02<br/>\
	 Dimanche 18 juillet 2010 : 15h15 à 21h21<br/></p>\
	 \
	 <h5>Infos festivaliers</h5>\
	 <p>Trois points vous accueillent en ville à la gare et sur le site du festival. Vous pourrez vous y procurez le dépliant des horaires de passage des groupes, les horaires des transports, etc... Ou bien un ami festivalier pourra sûrement vous renseigner.</p>\
	 \
	 <h5>Le village</h5>\
	 \
	 <p>Cet espace est un lieu de détente et de découvertes artistiques multiples et variées. Les festivaliers seront transportés dans la magie des arts de la rue. Des musiciens bretons proposeront également des rencontres plus intimes au cabaret situé sous le chapiteau du village. On y dégustera des cuisines et boissons de différents terroirs : crêpes, bières bretonnes, bar à vins, soupe de poisson, paëlla, cuisine africaine…</p>\
	 \
	 <h5>Objet perdu ?</h5>\
	 <p>Il est peut être chez nous pendant le festival POINT INFOS de 10h à 2h, le lundi de 8h à 12h30. Après le festival : 0820 890 066 (0.099 euros/min)</p>\
	 \
	 Important : Composez sur votre portable *#06# et notez le numéro de série qui apparait à l’écran. Il nous sera indispensable pour vous le restituer s’il nous a été rapporté.\
	 \
	 \
	 \
	 <h5>Objets interdits</h5>\
	 \
	 <p>Appareils enregistreurs (walkman, mini-disc…), appareils photos, caméras, touts types de contenants (de l'eau sera distribuée gratuitement sur l'ensemble des bars du site et au Champignon rouge) ainsi que les substances illicites sont formellement interdits sur le site. Une fouille aura lieu aux entrées. Merci de respecter ces consignes pour faciliter le travail de la sécurité.</p>\
	 \
	 \
	 \
	 <h5>Parkings et camping</h5>\
	 \
	 <p>- Les parkings n’ouvriront que le jeudi midi. (Attention pour les campeurs arrivant dès le mercredi soir !)\
	 - Deux grands parkings à disposition des festivaliers :<br/>\
	 • le parking ouest à 1,5 km du site de Kerampuilh<br/>\
	 • le parking est à 2,5 km du site de Kerampuilh. Des navettes mises en place par la CFTA feront des trajets aller/retour gratuits en continu jusqu’à la fermeture du site, entre le parking et la gare SNCF de Carhaix. (Bien utile quand nous avons les jambes en compote)<br/>\
	 \
	 - le camping gratuit du festival peut accueillir 30 000 campeurs (à quelques festivaliers près, il est toujours possible de se serrer dans les tentes). Il sera accessible aux festivaliers dès le mercredi à 15h sur présentation d’un billet d’entrée pour le festival.</p>\
	 \
	 \
	 \
	 <h5>Petits-déjeuners, supérette et pizzeria</h5>\
	 \
	 <p>Des petits-déjeuners sont servis à l’entrée du site tous les matins de 7h30 à 12h. A côté, vous trouverez une supérette ouverte dès le jeudi midi ainsi que les 3 jours du festival de 9h à 19h.</p>\
	 \
	 \
	 \
	 <h5>Scènes</h5>\
	 \
	 <p>Les concerts se déroulent sur deux scènes différentes en alternance (scène GLENMOR et KEROUAC). L'espace Xavier Grall est dédié aux jeunes talents et aux musiques électroniques. Les deux scènes principales sont équipées d'écrans géants (pour les gens qui se retrouveraient malencontreusement derrière un géant, de plus coiffés d'un chapeau de cowboy).</p>\
	 \
	 \
	 \
	 <h5>Secours</h5>\
	 \
	 <p>En cas d’accident, un service d’urgence est prévu avec La Croix Rouge dans l’enceinte du site. En dehors, il faudra prévenir les pompiers (18), vous rendre à l’hôpital de Carhaix situé rue du Docteur Menguy tél : 02 98 99 20 20, ou bien contacter le SMUR (15).</p></html>" baseURL:nil];
}

- (IBAction)revealAbout:(id)sender {
	[textAbout loadHTMLString:@"<body style=\"background-color:black; font-family:verdana\"><p style=\"text-align:center; color:white;\" >Projet Open Source réalisé par :<br/>Thomas Belin<br/>éleve ingénieur à Polytech'Nantes</br><b>ThomasBelin4@gmail.com</b><br/>Sources disponibles à l'adresse :<br/>code.google.com/p/vieillescharrues</p></body>" baseURL:nil];
	[self.view.window addSubview:viewAbout];
    
}

-(IBAction)hideAbout:(id)sender{
	[viewAbout removeFromSuperview];
}


- (IBAction) loadPartenaires
{
	TableVIewControllerPartenaires *anotherViewController = [[TableVIewControllerPartenaires alloc] initWithNibName:@"TableVIewControllerPartenaires" bundle:nil];
	[self.navigationController pushViewController:anotherViewController animated:YES];
	
	[anotherViewController release];
}
@end
