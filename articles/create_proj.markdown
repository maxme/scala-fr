# Introduction

Dans un [précédent article](http://www.scala-fr.org/sbt-scala-build-tool-ou-comment-compiler-son-projet-scala/), nous vous présentions sbt. Cette fois nous allons voir comment gérer un projet Scala avec <code>maven</code>.

Le plus simple, c'est de démarrer de zéro, et d'initialiser un projet en utilisant un archetype prédéfini. Cet archetype est un template de projet qui contient le minimum pour démarrer :

- La structure de répertoire de projet
- Le pom.xml
- Des fichiers sources quasiment vide (un main(), et un test pour scala-archetype-simple)

# Initialisation d'un projet

Pour l'initialisation d'un projet nous allons utiliser le plugin maven archetype (disponible dans le repository officiel de maven). Nous allons passer en paramètre de ce plugin, un lien vers une liste d'archetype : scala-tools (pour le moment, seul site à proposer des archetypes pour Scala).

	$ mvn archetype:generate -DarchetypeCatalog=http://scala-tools.org
	[...]
	Choose archetype:
	1: http://scala-tools.org -> scala-archetype-simple (A simple scala project)
	2: http://scala-tools.org -> lift-archetype-blank (A blank/empty liftweb project)
	3: http://scala-tools.org -> lift-archetype-basic (A basic liftweb project (with DB, css, ...))
	Choose a number:  (1/2/3): 1

Le plugin va ensuite vous posez quelques questions pour générer le pom.xml. Sélectionner le projet scala de base (1) à moins que vous soihaitiez faire du [lift](http://liftweb.net/).

Le projet ainsi initialisé contient déjà quelques dépendances et quelques plugins pratiques pour une bonne gestion d'un projet Scala :

- Un lien vers le repository maven de bibliothèques et de plugins Scala-tools: [http://scala-tools.org/repo-releases](http://scala-tools.org/repo-releases)

- Une dépendance vers jUnit

- Une dépendance vers [specs](http://code.google.com/p/specs/)

- Le plugin [maven-scala-plugin](http://www.scala-tools.org/mvnsites/maven-scala-plugin/)

# Quelques actions de maven-scala-plugin

Les *goal* maven classiques sont biensûr fonctionnels (compile, package, release, ...).

Le goal scala, propose différentes actions notamment :

- Lancer une application

		$ mvn scala:run -DmainClass=org.example.MyClass

- Générer la documentation de l'API

		$ mvn scala:doc

- Lancer le mode compilation continue (lance une boucle infinie qui compile toutes les sources qui sont sauvegardées, très pratique si vous développez avec un éditeur de texte simple type emacs ou vi)

		$ mvn scala:cc

*Note pour les utilisateurs d'emacs* : vous pouvez passer en compilation-mode avec [cette astuce pour lancer maven](http://vastusutra.blogspot.com/2007/06/getting-emacs-and-maven-2-to-play.html), puis lancer <code>mvn scala:cc</code>, je vous conseil aussi d'ajouter cette ligne dans votre .emacs.el : <code>(setq compilation-scroll-output t)</code> pour enclencher le scrolling automatique de la fenetre de compilation. Avec ça (et les ctags pour la complétion), vous pouvez jeter Eclipse et NetBeans ;). Vous pouvez aussi utiliser le flymake-mode beaucoup plus pratique mais malheuresement un peu lent à cause de l'utilisation de maven en Arrière plan.

Je n'ai rien contre Eclipse ou Netbeans, mais mon process emacs ne dépasse jamais 30Mo de RAM et il ne s'arrête pas inopinément.

Plus de détails sur la page de [documentation de maven-scala-plugin](http://www.scala-tools.org/mvnsites/maven-scala-plugin/usage.html).

# Ajouter des dépendances

C'est du maven classique. Pour ajouter une dépendance, éditer votre fichier <code>pom.xml</code> et ajouter les groupId / artifactId / version dont vous avez besoin dans <code>project->dependencies</code>. Si je veux par exemple ajouter la dépendance vers scalacheck, il me suffit d'ajouter :

	<dependencies> 
	[...] 
	  <dependency> 
	    <groupId>org.scala-tools.testing</groupId> 
		<artifactId>scalacheck</artifactId>
		<version>1.5</version>
	  </dependency>
	[...]
	</dependencies>

Note : ScalaCheck est disponible sur le repository maven scala-tools (ajouté par défaut à l'initiation du projet avec l'archetype scala-archetype-simple).

# Démonstration

Une démonstration de l'utilisation de mvn dans emacs, en utilisant <code>mvn archetype:generate</code> pour initialiser un projet exemple.
