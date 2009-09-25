# Introduction

<code>sbt</code> signifie Scala Build Tool. Encore un outils de compilation ? <code>ant</code>, <code>maven</code> ne suffisent pas ?

<code>sbt</code> se veut non intrusif : vous pouvez l'utiliser sans modifier la disposition de votre projet, uniquement en modifiant un descripteur (ce descripteur est écrit en Scala, un peu comme <code>scons</code> pour Python ou <code>rake</code> en Ruby). Pour cela il se base sur le même format de projet que <code>maven</code>.

    src/
      main/
        resources/  # Fichiers à inclure dans le jar principal
        scala/      # Sources Scala
        java/       # Sources Java
      test/
        resources   # Fichiers à inclire dans le jar de test
        scala/      # Sources de Test Scala
        java/       # Sources de Test Java 

Son principal intérêt est d'intégrer des outils liés à Scala sans avoir besoin de configurer quoique ce soit:
  
 * Génération de documentation avec scaladoc.
 * Tests unitaires avec ScalaTest.
 * Génération de tests unitaires avec ScalaCheck.
 * Intégration de specs, framework de [behavior driven development](http://fr.wikipedia.org/wiki/Behavior_Driven_Development).

sbt se base sur maven par défaut pour gérer les dépendances.

# Installer sbt

Malheuresement sbt n'est pas packagé dans <code>sbaz</code>. Il vous faudra le télécharger et l'installer à la main.

Pour cela, rien de plus simple, télécharger la dernière version de *sbt-launcher.jar* sur la [page de téléchargement de sbt](http://code.google.com/p/simple-build-tool/downloads/list).

Puis créer un script shell dans votre PATH, chez moi ça donne ça :

	$ echo $PATH
	/sw/bin:/sw/sbin:/Users/max/dist/sbin
	$ wget http://simple-build-tool.googlecode.com/files/sbt-launcher-0.5.4.jar -O /Users/max/dist/sbin/sbt-launcher.jar
    $ echo 'java -Xmx512M -jar `dirname $0`/sbt-launcher.jar "$@"' > /Users/max/dist/sbin/sbt
    $ chmod +x /Users/max/dist/sbin/sbt

<code>sbt</code> est installé, vous pouvez le l'utiliser.

# Utiliser sbt

<code>sbt</code> se lance en mode interactif ou en mode batch. Le mode batch permet de lancer une suite de tâches les unes à la suite des autres. Le mode interactif lance un shell particulier vous permettant de taper des commandes particulières (tâches ou autres).

Lorsque vous lancer <code>sbt</code> dans un répertoire qui ne contient pas les descripteurs, il va vous proposer de créer une structure de projet.

## Créer un projet

Lancer sbt sans arguments dans le répertoire où vous souhaitez créer votre projet:

    $ mkdir sbttest
    $ sbt
	Project does not exist, create new project? (y/N/s) : y
	Name: SbtTest
	Organization []: scala-fr
	Version [1.0]: 
	Scala version [2.7.5]: 
	sbt version [0.5.3]: 
	[...]
	[success] Successfully initialized directory structure.

Voilà, la structure de projet est créée, voici à quoi elle ressemble : 

	$ \tree
    |-- lib
	|-- project
	|   |-- boot
	|   |   `-- scala-2.7.5
	|   |       |-- lib
	|   |       |   |-- scala-compiler.jar
	|   |       |   `-- scala-library.jar
	|   |       |-- sbt-0.5.3
	|   |       |   |-- ivy-2.0.0.jar
	|   |       |   |-- jsch-0.1.31.jar
	|   |       |   `-- sbt_2.7.5-0.5.3.jar
	|   |       `-- update.log
	|   `-- build.properties
	|-- src
	|   |-- main
	|   |   |-- resources
	|   |   `-- scala
	|   `-- test
	|       |-- resources
	|       `-- scala
	`-- target
	
## Mode interactif

Si vous le lancer sans arguments dans un répertoire projet, il démarre en mode interactif:

    $ sbt
    [info] Building project xxx 0.1 using XXX
	[info]    with sbt 0.4.6 and Scala 2.7.4
	[info] No actions specified, interactive session started. Execute 'help' for more information.
	>
	
Un shell sbt est ouvert, vous pouvez tapez vos commandes. 

## Mode batch

En mode batch vous lancer directement les tâches (Consulter [la liste exhaustive des tâches](http://code.google.com/p/simple-build-tool/wiki/RunningSbt))

Exemple, je viens d'écrire du code (un simple <code>println("hey !")</code>dans le fichier <code>src/main/scala/sbttest.scala</code>, je lance la tâche <code>run</code>:

    $ sbt run
	[info] Building project SbtTest 1.0 using sbt.DefaultProject
	[info]    with sbt 0.5.3 and Scala 2.7.5
	...
	[info] == compile ==
	...
	[info] == run ==
	[info] Running RunSbtTest ...
	hey !
	...
	[info] Total build time: 1 s
	
On s'aperçoit que la tâche <code>run</code> dépend de la tâche <code>compile</code>, et ça tombe bien ;). Vous venez de compiler et de lancer votre premier projet Scala avec sbt et son projet par défaut (sbt.DefaultProject).

# Conclusion

Ca sera tout pour cet article, il y a pas mal de possibilités qui n'ont pas été abordées ici. Elles le seront sûrement un peu plus en détails dans les futurs articles.

En apparence <code>sbt</code> simplifie tout. Pour les projets Scala simple, il sera sûrement parfaitement adapté, mais dès que vous commencez à dévier du chemin classique, ça devient plus complexe et mal documenté; c'est là que les ennuis commencent.

Même si vous avez l'habitude, et préférez utiliser maven; si vous êtes développeur Scala, vous aurez sûrement besoin d'installer sbt pour compiler des projets tiers. Ce sera une bonne occasion pour apprendre quelques commandes, le tester et vous en faire votre opinion.

En savoir plus:

- Différents mode d'installation : [How to setup sbt](http://code.google.com/p/simple-build-tool/wiki/Setup)
- Utilisation : [Basic usage](http://code.google.com/p/simple-build-tool/wiki/RunningSbt)
- Aller plus loin dans la mise en place de vos propre option de build: [Build Configuration](http://code.google.com/p/simple-build-tool/wiki/BuildConfiguration)

